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
    @order.contract_id = params[:contract_id]
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
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
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
        # If order is canceled, then post is active(1)
        if @order.status == "canceled"
          post.status = 1

        # If order is problematic, active or closed, then post is closed(3)
        else
          post.status = 3
        end
        post.save
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
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
