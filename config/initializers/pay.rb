Pay.setup do |config|
  config.chargeable_class = 'Pay::Charge'
  config.chargeable_table = 'pay_charges'

  # For use in the receipt/refund/renewal mailers
  config.business_name = "Demo Business"
  config.business_address = "Some Where"
  config.application_name = "Demo App"
  config.support_email = "polamoussa@gmail.com"

  config.send_emails = true

  config.default_product_name = "default"
  config.default_plan_name = "default"

  config.automount_routes = true
  config.routes_path = "/pay" # Only when automount_routes is true
end