module RailsFakeApi
  class ApplicationController < ActionController::API
    skip_before_action :verify_authenticity_token, raise: false

    rescue_from StandardError, with: :internal_server_error
    rescue_from RailsFakeApi::Errors::ResourceNotFound, with: :resource_not_found_error

    private

    def resource_not_found_error(exception)
      render json: { error: exception.message }, status: :not_found
    end

    def internal_server_error(exception)
      Rails.logger.error "Internal Server Error: #{exception.message}\n#{exception.backtrace.join("\n")}"
      render json: { error: I18n.t('rails_fake_api.errors.internal_server_error') }, status: :internal_server_error
    end
  end
end
