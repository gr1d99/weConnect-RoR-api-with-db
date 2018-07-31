module ApplicationControllerConcern
  extend ActiveSupport::Concern

  included do
    def business
      @current_user.businesses.find(params[:business_id])
    end
  end
end
