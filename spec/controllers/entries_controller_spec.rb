require 'rails_helper'

describe EntriesController do
  render_views

  let!(:entry){ FactoryGirl.create(:entry) }
  let!(:field){ FactoryGirl.create(:field) }

  describe "GET #index" do
    before(:each) { get :index }

    it "renders the :index view" do
      expect(response).to render_template :index
    end

    it 'to be success' do
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "assigns the requested entry to @entry" do
      get :show, id: entry
      expect(assigns(:entry)).to eq(entry)
    end
    
    it "renders the #show view" do
      get :show, id: entry 
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new_thing" do
    before(:each) { get :new_thing, category: "ARTICLE" }

    it "assigns new entry to @entry" do
      expect(assigns(:entry)).to be_a_new(Entry)
    end
    
    it "renders the #new view" do
      expect(response).to render_template(:new_thing)
    end
  end

  describe "GET #destroy" do

    it "deletes entry given in parametres" do
      get :destroy, id: entry
      expect(Entry.count).to eq(0)
    end
    
  end

  describe "POST #create" do

    describe "with valid params" do 
      it "creates and saves entry" do
        expect{
          post :create, entry:{"category"=>"ARTICLE"}, author:{"content"=>"pekka"}, title:{"content"=>"otsikko"}, journal:{"content"=>"Me Naiset"}, year:{"content"=>"2015"}, volume:{"content"=>"2"}, number:{"content"=>""}, pages:{"content"=>""}, month:{"content"=>""}, note:{"content"=>""}, key:{"content"=>""}
        }.to change(Entry,:count).by(1)
      end
    end

    describe "with invalid params" do 
      it "doesn't create and save entry" do
        expect{
          post :create, entry:{"category"=>"ARTICLE"}, author:{"content"=>""}, title:{"content"=>"otsikko"}, journal:{"content"=>"Me Naiset"}, year:{"content"=>"2015"}, volume:{"content"=>"2"}, number:{"content"=>""}, pages:{"content"=>""}, month:{"content"=>""}, note:{"content"=>""}, key:{"content"=>""}
        }.to change(Entry,:count).by(0)
      end
    end
  end
end