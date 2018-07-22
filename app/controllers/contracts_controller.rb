class ContractsController < ApplicationController
  before_action :set_contract, only: [:show, :edit, :update, :destroy]
  access user: [:show, :new, :edit, :create, :update, :destory], site_admin: :all
  # GET /contracts
  # GET /contracts.json
  def index
    @contracts = Contract.all
  end

  # GET /contracts/1
  # GET /contracts/1.json
  def show
  end

  # GET /contracts/new
  def new
    @contract = Contract.new
    # if !params[:admin].present?
      @contract.post_id = params[:post_id]
      sender_id = params[:sender_id]
      receiver_id = params[:receiver_id]

      post = Post.find(@contract.post_id)
      if post.post_type == "offer"
        @contract.seller_id = post.user_id
        # If the person who starts this contract is not the person offering the book, then he is the buyer; otherwise, the receiver is the buyer %>
        if sender_id != post.user_id
          @contract.buyer_id = sender_id
        else
          @contract.buyer_id = receiver_id
        end
        
      elsif post.post_type == "request"
        @contract.buyer_id = post.user_id
        # If the current user is not the person requesting the book, then he is the seller; otherwise, the receiver is the seller %>
        if sender_id != post.user_id
          @contract.seller_id = sender_id
        else
          @contract.seller_id = receiver_id
        end
      end
      @contract.unsigned_user_id = receiver_id
  end

  # GET /contracts/1/edit
  def edit
  end

  # POST /contracts
  # POST /contracts.json
  def create
    @contract = Contract.new(contract_params)
    respond_to do |format|
      if @contract.save
        format.html { redirect_to @contract, notice: 'Contract was successfully created.' }
        format.json { render :show, status: :created, location: @contract }
      else
        # @user_create = params[:user_create]
        format.html { render :new }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contracts/1
  # PATCH/PUT /contracts/1.json
  def update
    respond_to do |format|
      if @contract.update(contract_params)
        if @contract.status == "confirmed" && Order.find_by(contract_id: @contract.id) == nil
          # format.html { redirect_to new_order_path(contract_id: @contract.id) }
          @order = Order.create(contract_id: @contract.id)
          format.html { redirect_to order_path(@order.id), notice: 'Order was successfully placed.' }
          format.json { render 'orders/show', status: :ok, location: @order }
        else
          format.html { redirect_to @contract, notice: 'Contract was successfully updated.' }
          format.json { render :show, status: :ok, location: @contract }
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

    # def user_create
    #   params.require(:contract).permit(:user_create)
    # end
end
