require 'rails_helper'

describe "Animal API" do

  before :each do
    FactoryGirl.create :animal, name: 'Dog'
    FactoryGirl.create :animal, name: 'Cat'
  end

  describe "GET /animals" do
    it "returns all the aminals" do
      get '/api/animals', {}, { 'Accept' => 'application/json' }

      body = JSON.parse response.body
      aminals = body.map { |m| m['name'] }

      expect(response.status).to eq 200
      expect(aminals).to match_array ['Dog', 'Cat']
    end


    context "has filters" do

      before do
        dog = Animal.find_by_name 'Dog'
        wildTag = FactoryGirl.create :tag, value: 'wild'

        dog.tags << wildTag
      end

      it "returns only filtered aminals" do
        get '/api/animals?filters[]=wild', {}, { 'Accept' => 'application/json' }

        body = JSON.parse response.body
        aminals = body.map { |m| m['name'] }

        expect(aminals).to match_array ['Dog']
      end

    end
  end

  describe "GET /animals/:id" do
    it "returns an aminal" do
      get '/api/animals/1', {}, { 'Accept' => 'application/json' }

      body = JSON.parse response.body

      expect(response.status).to eq 200
      expect(body['name']).to eq 'Dog'
    end

    it "returns with zoo" do
      z = FactoryGirl.create :zoo
      FactoryGirl.create :animal, name: 'Unicorn', zoo: z

      get '/api/animals/3', {}, { 'Accept' => 'application/json' }
      body = JSON.parse response.body

      expect(response.status).to eq 200
      expect(body['zoo'].nil?).to eq false
      expect(body['name']).to eq 'Unicorn'

    end
  end

  describe "PUT /animals/:id" do
    it "updates a aminal" do
      put '/api/animals/1', {
        animal: { name: 'Boo' }
      }, { 'Accept' => 'application/json' }

      body = JSON.parse response.body

      expect(response.status).to eq 200
      expect(body['name']).to eq 'Boo'
    end
  end

  describe "DELETE /animals/:id" do
    it "deletes a aminal" do
      delete '/api/animals/1', {}, { 'Accept' => 'application/json' }
      get '/api/animals', {}, { 'Accept' => 'application/json' }

      body = JSON.parse response.body

      expect(response.status).to eq 200
      expect(body.count).to eq 1
    end
  end

end
