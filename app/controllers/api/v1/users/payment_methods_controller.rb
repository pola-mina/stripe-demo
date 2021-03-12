class Api::V1::Users::PaymentMethodsController < Api::V1::Users::UserApiController
  before_action :set_payment_method, except: %i[index]

  def index
    payment_methods = listing_records(@payment_methods, params)
    payment_methods = ArticleSerializer.new(payment_methods, { fields: { article: params[:fields] } })
    render json: { items: payment_methods.serializable_hash[:data], count: @total_count }, status: :ok
  end

  def show
    render json: serializer.constantize.new(content, { fields: { content: params[:fields] } }).serializable_hash[:data],
        status: :ok
  end

  def create
    content.author_id = current_admin.id
    if content.save
      render json: serializer.constantize.new(content).serializable_hash[:data], status: :ok
    else
      render json: ErrorsSerializer.new(content).serialize, status: :unprocessable_entity
    end
  end

  def destroy
    if content.destroy
      render json: {}, status: :ok
    else
      render json: ErrorsSerializer.new(content).serialize, status: :unprocessable_entity
    end
  end

  private

  def set_article
    @article = params[:id].present? ? Article.find_by_id(params[:id]) : Article.new(article_params)
  end

  def article_params
    params.permit(:title, :body, searcheable_item_attributes: [:tag_list])
  end
end
