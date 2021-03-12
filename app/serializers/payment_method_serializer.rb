class PaymentMethodSerializer
  include FastJsonapi::ObjectSerializer

  attributes :title, :body, :author_id

  attribute :author do |payment_method|
    AdminSerializer.new(payment_method.admin).serializable_hash[:data]
  end

  attribute :tags do |payment_method|
    payment_method.searcheable_item&.tag_list
  end
end
