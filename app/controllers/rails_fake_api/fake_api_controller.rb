module RailsFakeApi
  class FakeApiController < ApplicationController
    skip_before_action :verify_authenticity_token, raise: false

    before_action :set_resource_name
    before_action :set_resource_data, only: [:show, :update, :destroy]

    # GET /fake_api/:resource_name
    def index
      render json: JsonFileStore.read(@resource_name)
    end

    # GET /fake_api/:resource_name/:id
    def show
      if @resource_data
        render json: @resource_data
      else
        render json: { error: I18n.t('rails_fake_api.errors.resource_not_found') }, status: :not_found
      end
    end

    # POST /fake_api/:resource_name
    def create
      new_item = params.permit!.to_h
      new_item['id'] = JsonFileStore.next_id(@resource_name)

      data = JsonFileStore.read(@resource_name)
      data << new_item
      JsonFileStore.write(@resource_name, data)

      render json: new_item, status: :created
    end

    # PATCH/PUT /fake_api/:resource_name/:id
    def update
      if @resource_data
        updated_data = params.permit!.to_h.except(:id, :action, :controller, :resource_name)
        @resource_data.merge!(updated_data)

        data = JsonFileStore.read(@resource_name)
        index = data.find_index { |item| item['id'].to_s == params[:id].to_s }
        data[index] = @resource_data if index

        JsonFileStore.write(@resource_name, data)
        render json: @resource_data
      else
        render json: { error: I18n.t('rails_fake_api.errors.resource_not_found') }, status: :not_found
      end
    end

    # DELETE /fake_api/:resource_name/:id
    def destroy
      if @resource_data
        data = JsonFileStore.read(@resource_name)
        data.reject! { |item| item['id'].to_s == params[:id].to_s }
        JsonFileStore.write(@resource_name, data)
        head :no_content
      else
        render json: { error: I18n.t('rails_fake_api.errors.resource_not_found') }, status: :not_found
      end
    end

    private

    def set_resource_name
      @resource_name = params[:resource_name]
    end

    def set_resource_data
      @resource_data = JsonFileStore.find(@resource_name, params[:id])
    end
  end
end
