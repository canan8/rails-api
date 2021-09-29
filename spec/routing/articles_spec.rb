require 'rails_helper'

RSpec.describe '/articles route' do
  it 'routes to articles#index' do
    expect(get '/articles').to route_to('articles#index')
  end

  it 'routes to articles#index' do
    expect(get '/articles/1').to route_to('articles#show', id: '1')
  end
end
