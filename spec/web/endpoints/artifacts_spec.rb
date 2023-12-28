# frozen_string_literal: true

RSpec.describe Mihari::Web::Endpoints::Artifacts, :vcr do
  include Rack::Test::Methods

  let_it_be(:artifact) { FactoryBot.create(:artifact) }
  let_it_be(:artifact_to_delete) { FactoryBot.create(:artifact) }

  def app
    Mihari::Web::Endpoints::Artifacts
  end

  describe "get /api/artifacts" do
    it "returns 200" do
      get "/api/artifacts"
      expect(last_response.status).to eq(200)

      json = JSON.parse(last_response.body.to_s)
      expect(json).to be_a(Hash)
    end
  end

  describe "get /api/artifacts/:id" do
    it "returns 400" do
      get "/api/artifacts/foo"
      expect(last_response.status).to eq(400)
    end

    it "returns 404" do
      get "/api/artifacts/0"
      expect(last_response.status).to eq(404)
    end

    it "returns 200" do
      get "/api/artifacts/#{artifact.id}"
      expect(last_response.status).to eq(200)

      json = JSON.parse(last_response.body.to_s)
      expect(json).to be_a(Hash)
      expect(json["id"]).to eq(artifact.id)
    end
  end

  describe "get /api/artifacts/:id/enrich" do
    it "returns 201" do
      post "/api/artifacts/#{artifact.id}/enrich"
      expect(last_response.status).to eq(201)
    end
  end

  describe "delete /api/artifacts/:id" do
    it "returns 400" do
      delete "/api/artifacts/foo"
      expect(last_response.status).to eq(400)
    end

    it "returns 404" do
      delete "/api/artifacts/0"
      expect(last_response.status).to eq(404)
    end

    it "returns 201" do
      delete "/api/artifacts/#{artifact_to_delete.id}"
      expect(last_response.status).to eq(204)
    end
  end
end
