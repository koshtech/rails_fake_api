RailsFakeApi::Engine.routes.draw do
  scope :fake_api do
    get ':resource_name', to: 'fake_api#index'
    post ':resource_name', to: 'fake_api#create'

    get ':resource_name/:id', to: 'fake_api#show'
    put ':resource_name/:id', to: 'fake_api#update'
    patch ':resource_name/:id', to: 'fake_api#update'
    delete ':resource_name/:id', to: 'fake_api#destroy'
  end
end
