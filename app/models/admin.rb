# frozen_string_literal: true

class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  extend Devise::Models

  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
end
