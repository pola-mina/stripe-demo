class Api::V1::Users::UserApiController < Api::ApiController
  before_action :authenticate_user!
  # load_and_authorize_resource
end
