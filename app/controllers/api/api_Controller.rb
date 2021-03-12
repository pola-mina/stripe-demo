class Api::ApiController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ApiHelper

  before_action :set_fields, only: %i[index show]
end
