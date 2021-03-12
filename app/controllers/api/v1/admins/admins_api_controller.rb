class Api::V1::Admins::AdminApiController < Api::ApiController
  include ContentHelper
  before_action :authenticate_admin!
  # load_and_authorize_resource

  private

  def current_user
    current_admin
  end
end
