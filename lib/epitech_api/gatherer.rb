require 'epitech_api/DataTypes/promo'
require 'epitech_api/Managers/promo_manager'
require 'epitech_api/Managers/user_manager'


module EpitechApi

  class Gatherer

    attr_accessor :promo_manager, :user_manager

    def initialize(token)
      @token = token
      @promo_manager = PromoManager.new @token
      @user_manager = UserManager.new @token
    end

  end
end