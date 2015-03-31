require 'rails_helper'

describe "Zoo API" do

  before :each do
    FactoryGirl.create :zoo, name: 'ZooPad'
    FactoryGirl.create :zoo, name: 'ZooPad2'
  end

  describe "GET /zoos" do
    it "returns all the zoos" do
      get '/api/zoos', {}, { 'Accept' => 'application/json' }

      body = JSON.parse response.body
      zoo_names = body.map { |m| m['name'] }

      expect(response.status).to eq 200
      expect(zoo_names).to match_array ['ZooPad', 'ZooPad2']

    end
  end

  describe "GET /zoos/:id" do
    it "returns a zoo" do
      get '/api/zoos/1', {}, { 'Accept' => 'application/json' }

      body = JSON.parse response.body

      expect(response.status).to eq 200
      expect(body['name']).to eq 'ZooPad'
    end

    it "returns with animals in tow" do
      new_zoo = FactoryGirl.create :zoo_with_animals, name: 'ZooPad3'
      new_zoo.animals << FactoryGirl.create(:animal)
      new_zoo.save

      get '/api/zoos/3', {}, { 'Accept' => 'application/json' }

      body = JSON.parse response.body

      expect(response.status).to eq 200
      expect(body['animals'].count).to eq 4
      expect(body['name']).to eq 'ZooPad3'
    end
  end

  describe "PUT /zoos/:id" do
    it "updates a zoo" do
      put '/api/zoos/1', {
        zoo: { name: 'New Name' }
      }, { 'Accept' => 'application/json' }

      body = JSON.parse response.body

      expect(response.status).to eq 200
      expect(body['name']).to eq 'New Name'
    end
  end

  describe "DELETE /zoos/:id" do
    it "deletes a zoo" do
      delete '/api/zoos/1', {}, { 'Accept' => 'application/json' }
      get '/api/zoos', {}, { 'Accept' => 'application/json' }

      body = JSON.parse response.body

      expect(response.status).to eq 200
      expect(body.count).to eq 1
    end
  end

end

