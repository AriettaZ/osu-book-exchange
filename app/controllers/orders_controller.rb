# Author: Gail Chen
# Created: 7/18
# Edit: 7/22 Gail updated post status corresponding to changes in order status.
# Edit: 7/23 Gail added mailer.
# Descript: An order is created when a contract is confirmed. Only buyers and
# admins can close or cancel the order. Users can report problems at any time.

class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  access user: [:edit,:update,:show], site_admin: :all
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.where.not(status: "deleted")
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @showFrom = params[:showFrom]
    contract = Contract.find(@order.contract_id)
    if !current_user.has_roles?(:site_admin) && current_user.id != contract.buyer_id && current_user.id != contract.seller_id
      flash[:notice] = "Sorry, you don't have access to this order."
      redirect_to root_path
    end
  end

  # GET /orders/new
  def new
    @order = Order.new
    if @createdby == "user"
      @order.contract_id = params[:contract_id]
    end
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    respond_to do |format|
      if @order.save
        contract = Contract.find(@order.contract_id)
        contract.status = 1
        contract.save
        MagicMailer.newOrder(@order, User.find(contract.seller_id)).deliver_now
        MagicMailer.newOrder(@order, User.find(contract.buyer_id)).deliver_now
        CloseExpiredOrdersJob.set(wait_until: (contract.meeting_time+3.days)).perform_later(@order)
        format.html { redirect_to @order, notice: 'The contract was confirmed and an order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    contract = Contract.find(@order.contract_id)
    post = Post.find(contract.post_id)
    respond_to do |format|
      if @order.update(order_params)
        # If order is canceled, then post is active(1) and an email is sent to users.
        if @order.status == "canceled"
          post.status = 1
          post.save
          MagicMailer.orderCanceled(@order, User.find(contract.buyer_id)).deliver_now
          MagicMailer.orderCanceled(@order, User.find(contract.seller_id)).deliver_now
          format.html { redirect_to @order, notice: 'Order was successfully canceled.' }
          format.json { render :show, status: :ok, location: @order }

        # If order is problematic, then post is closed(3) and reports to the magic team.
        elsif @order.status == "problematic"
          post.status = 3
          post.save
          MagicMailer.problematicOrder(@order, current_user).deliver_now
          format.html { redirect_to profile_messages_url(talk_to: 13, post_id: 0) }
          # format.html { redirect_to contact_us_url, notice: 'The MAG¡C team will contact you within 3 workdays.' }

        # If order is completed, then post is closed(3) and an email is sent to users.
        elsif @order.status == "completed"
          post.status = 3
          post.save
          MagicMailer.orderCompleted(@order, User.find(contract.seller_id)).deliver_now
          MagicMailer.orderCompleted(@order, User.find(contract.buyer_id)).deliver_now
          format.html { redirect_to @order, notice: 'Order was successfully completed.' }
          format.json { render :show, status: :ok, location: @order }

        # If order is reactived, then post is closed(3) and an email is sent to users.
        else
          post.status = 3
          post.save
          MagicMailer.orderActive(@order, User.find(contract.seller_id)).deliver_now
          MagicMailer.orderActive(@order, User.find(contract.buyer_id)).deliver_now
          format.html { redirect_to @order, notice: 'Order was successfully activated.' }
          format.json { render :show, status: :ok, location: @order }
        end
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:status, :contract_id)
    end
end
