require 'rails_helper'

RSpec.describe AccessTokensController, type: :controller do
  describe '#create' do
    context 'when invalid requests' do
      let(:error) do
        {
          "status" => "401",
          "source" => { "pointer" => "/code" },
          "title" =>  "Authentication code is invalid",
          "detail" => "You must provide valid code in order to exchange it for token."
        }
      end

      subject { post :create }

      it "should return 401 status code " do
        subject
        expect(response).to have_http_status(401)
      end

      it "should return a proper error body " do
        subject
        expect(json['errors']).to include(error)
      end
    end
  end
end
