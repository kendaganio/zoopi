require 'rails_helper'

describe "Unicorns API" do

  describe "GET /unicorns" do
    it "returns rainbows" do
      get '/api/unicorns', {}, { 'Accept' => 'application/json' }

      expect(body["rainbows"]).to be_truthy
    end
  end

end
