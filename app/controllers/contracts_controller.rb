# Author: Gail Chen
# Created: 7/18
# Edit: 7/21 Gail added admin controls.
# Edit: 7/22 Gail updated post status corresponding to contract status.
# Edit: 7/23 Gail added mailer.
# Descript: A contract can be created either by a user from post page, or by an
# admin from from index page.

class ContractsController < ApplicationController
  before_action :set_contract, only: [:show, :edit, :update, :destroy]
  access user: [:show, :new, :edit, :create, :update, :destory], site_admin: :all
  # GET /contracts
  # GET /contracts.json
  def index
    @contracts = Contract.where.not(status: "deleted")
  end

  # GET /contracts/1
  # GET /contracts/1.json
  def show
    # Only the buyer and seller of the contract and admins can see the contract page
    @showFrom = params[:showFrom]
    if !(current_user.has_roles?(:site_admin) || current_user.id == @contract.buyer_id || current_user.id == @contract.seller_id)
      flash[:notice] = "Sorry, you don't have access to this contract."
      redirect_to profile_mycontract_path
    end
  end

  # GET /contracts/new
  def new
    @contract = Contract.new
    # Users need to sign in to create a contract.
    if !current_user.is_a?(GuestUser)
      # The user creates a contract from the post page.
      if !params[:admin].present?
        @contract.post_id = params[:post_id]
        @sender_id = params[:sender_id]
        @receiver_id = params[:receiver_id]
        @createdby = "user"
        set_users()
      else
        # The admin creates a contract from the contract index page
        @createdby = "admin"
      end
    else
      flash[:notice] = "You have to sign in to start a contract."
      redirect_to new_user_session_url
    end
  end

  # Set the new contract's seller_id, buyer_id, unsigned_user_id
  def set_users
    post = Post.find(@contract.post_id)
    if post.post_type == "offer"
      @contract.seller_id = post.user_id
      # If the person who starts this contract is not the person offering the book, then he is the buyer; otherwise, the receiver is the buyer %>
      if @sender_id != post.user_id
        @contract.buyer_id = @sender_id
      else
        @contract.buyer_id = @receiver_id
      end

    elsif post.post_type == "request"
      @contract.buyer_id = post.user_id
      # If the current user is not the person requesting the book, then he is the seller; otherwise, the receiver is the seller %>
      if @sender_id != post.user_id
        @contract.seller_id = @sender_id
      else
        @contract.seller_id = @receiver_id
      end
    end
    @contract.unsigned_user_id = @receiver_id
  end

  # GET /contracts/1/edit
  def edit
    @editFrom = params[:editFrom]
    # Contract can only be edited when it is waiting for someone to confirm or decline
    if @contract.status == "waiting"
      # Admin can edit more infos
      if current_user.has_roles?(:site_admin)
        @createdby = "admin"
      else
        @createdby = "user"
      end

    # elsif !current_user.has_roles?(:site_admin)
    else
      flash[:notice] = "Sorry, this contract cannot be edited because it is #{@contract.status} already."
      redirect_to contracts_url(@contracts)
    end
  end

  # POST /contracts
  # POST /contracts.json
  def create
    @createdby = params[:createdby]
    @contract = Contract.new(contract_params)
    respond_to do |format|
      if @contract.save
        post = Post.find(@contract.post_id)
        unsigned_user = User.find(@contract.unsigned_user_id)
        if @contract.unsigned_user_id == @contract.buyer_id
          signed_user = User.find(@contract.seller_id)
        else
          signed_user = User.find(@contract.buyer_id)
        end
        # If contract is waiting, then post is pending(2) and an email is sent to users.
        if @contract.status == "waiting"
          post.status = 2
          post.save
          @contract.save
          MagicMailer.newContract(@contract, signed_user, unsigned_user).deliver_now
          MagicMailer.unsignedContract(@contract, signed_user, unsigned_user).deliver_now
          DeclineExpiredContractJob.set(wait_until: @contract.expiration_time).perform_later(@contract, signed_user, unsigned_user)
          format.html { redirect_to @contract, notice: 'A contract was successfully created.' }
          format.json { render :show, status: :created, location: @contract }

        # If contract is confirmed, then post is closed(3) and an email is sent to users.
        elsif @contract.status == "confirmed"
          post.status = 3
          @contract.unsigned_user_id = nil
          post.save
          @contract.save
          @order = Order.create(contract_id: @contract.id)
          MagicMailer.newOrder(@order, User.find(@contract.seller_id)).deliver_now
          MagicMailer.newOrder(@order, User.find(@contract.buyer_id)).deliver_now
          CloseExpiredOrdersJob.set(wait_until: (@contract.meeting_time+3.days)).perform_later(@order)
          format.html { redirect_to order_url(@order), notice: 'Contract was confirmed and an order was successfully placed.' }

        # If contract is declined, then post is active(1) and an email is sent to users.
        elsif @contract.status == "declined"
          post.status = 1
          @contract.unsigned_user_id = nil
          post.save
          @contract.save
          MagicMailer.contractDeclined(@contract, signed_user, unsigned_user).deliver_now
          format.html { redirect_to @contract, notice: 'An contract was successfully declined.' }
          format.json { render :show, status: :created, location: @contract }
        end

      else
        format.html { render :new }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contracts/1
  # PATCH/PUT /contracts/1.json
  def update
    @editFrom = params[:editFrom]
    post = Post.find(@contract.post_id)
    respond_to do |format|
      if @contract.update(contract_params)
        # If the contract is confirmed, then post is closed(3) and an email is sent to users.
        if @contract.status == "confirmed"
          post.status = 3
          @contract.unsigned_user_id = nil
          @contract.save
          post.save
          @order = Order.create(contract_id: @contract.id)
          MagicMailer.newOrder(@order, User.find(@contract.seller_id)).deliver_now
          MagicMailer.newOrder(@order, User.find(@contract.buyer_id)).deliver_now
          CloseExpiredOrdersJob.set(wait_until: (@contract.meeting_time+3.days)).perform_later(@order)
          format.html { redirect_to order_url(@order), notice: 'Contract was confirmed and an order was successfully placed.' }

        else
          if @contract.unsigned_user_id != nil
            unsigned_user = User.find(@contract.unsigned_user_id)
            if @contract.unsigned_user_id == @contract.buyer_id
              signed_user = User.find(@contract.seller_id)
            else
              signed_user = User.find(@contract.buyer_id)
            end
          end
          # If the contract is declined, then post is active(1) and an email is sent to users.
          if @contract.status == "declined"
            post.status = 1
            @contract.unsigned_user_id = nil
            post.save
            @contract.save
            MagicMailer.contractDeclined(@contract, signed_user, unsigned_user).deliver_now
            format.html { redirect_to @contract, notice: 'The contract was successfully declined.' }
            format.json { render :show, status: :ok, location: @contract }

          # If the contract is waiting, then post is pending(2) and an email is sent to users.
          elsif @contract.status == "waiting"
            post.status = 2
            post.save
            MagicMailer.newContract(@contract, signed_user, unsigned_user).deliver_now
            MagicMailer.unsignedContract(@contract, signed_user, unsigned_user).deliver_now

            DeclineExpiredContractJob.set(wait_until: @contract.expiration_time).perform_later(@contract, signed_user, unsigned_user)
            format.html { redirect_to @contract, notice: 'The contract is now waiting for confirmation/decline.' }
            format.json { render :show, status: :ok, location: @contract }

          # If the contract is deleted, then post is set to active.
          elsif @contract.status == "deleted"
            post.status = 1
            post.save
            format.html { redirect_to profile_mycontract_url, notice: 'The contract was successfully deleted.' }
          end
        end
      else
        format.html { render :edit }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /contracts/1
  # DELETE /contracts/1.json
  def destroy
    post = Post.find(@contract.post_id)
    if @contract.status == "waiting"
      post.status == 1
      post.save
    end
    @contract.destroy
    respond_to do |format|
      format.html { redirect_to contracts_url, notice: 'Contract was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contract
      @contract = Contract.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contract_params
      params.require(:contract).permit(:meeting_time, :meeting_address_first, :meeting_address_second, :final_payment_method, :final_price, :expiration_time, :status, :post_id, :seller_id, :buyer_id, :unsigned_user_id)
    end

end
