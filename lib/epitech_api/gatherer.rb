require_relative 'DataTypes/promo'
require_relative 'Managers/promo_manager'
require_relative 'Managers/user_manager'


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