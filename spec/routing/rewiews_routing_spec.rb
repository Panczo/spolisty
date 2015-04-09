require "rails_helper"

RSpec.describe RewiewsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/rewiews").to route_to("rewiews#index")
    end

    it "routes to #new" do
      expect(:get => "/rewiews/new").to route_to("rewiews#new")
    end

    it "routes to #show" do
      expect(:get => "/rewiews/1").to route_to("rewiews#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/rewiews/1/edit").to route_to("rewiews#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/rewiews").to route_to("rewiews#create")
    end

    it "routes to #update" do
      expect(:put => "/rewiews/1").to route_to("rewiews#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/rewiews/1").to route_to("rewiews#destroy", :id => "1")
    end

  end
end
