class Api::V1::Users::PaymentMethodsController < Api::V1::Users::UserApiController
  before_action :set_payment_method, except: %i[index create]

  def index
    customer = if current_user.stripe_id?
      Stripe::Customer.retrieve(current_user.stripe_id)
    else
      Stripe::Customer.create(email: current_user.email, source: token)
    end
    payment_methods = listing_records(@payment_methods, params)
    payment_methods = PaymentMethodSerializer.new(payment_methods, { fields: { payment_method: params[:fields] } })
    render json: { items: payment_methods.serializable_hash[:data], count: @total_count }, status: :ok
  end

  def show
    render json: PaymentMethodSerializer.new(@payment_method, { fields: { payment_method: params[:fields] } }).serializable_hash[:data],
           status: :ok
  end

  def create
    customer = if current_user.cust_gateway_id?
                 Stripe::Customer.retrieve(current_user.stripe_id)
               else
                 new_cus = Stripe::Customer.create(email: current_user.email, source: params[:source])
                 current_user.update(cust_gateway_id: new_cus.id)
                 new_cus
               end
    byebug
    if @payment_method.save
      render json: PaymentMethodSerializer.new(@payment_method).serializable_hash[:data], status: :ok
    else
      render json: ErrorsSerializer.new(@payment_method).serialize, status: :unprocessable_entity
    end
  end

  def destroy
    if @payment_method.destroy
      render json: {}, status: :ok
    else
      render json: ErrorsSerializer.new(@payment_method).serialize, status: :unprocessable_entity
    end
  end

  private

  def set_payment_method
    @payment_method = Stripe::PaymentMethod.retrieve(params[:payment_method_id])
  end

  def payment_method_params
    params.permit(:title, :body, searcheable_item_attributes: [:tag_list])
  end
end
