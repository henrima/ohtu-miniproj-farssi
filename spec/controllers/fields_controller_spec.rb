require 'rails_helper'

describe FieldsController do
  render_views

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
    it "assigns the requested field to @field" do
      get :show, id: field
      expect(assigns(:field)).to eq(field)
    end
    
    it "renders the #show view" do
      get :show, id: field
      expect(response).to render_template(:show)
    end
  end

  describe "GET #destroy" do

    it "deletes field given in parametres" do
      get :destroy, id: field
      expect(Field.count).to eq(0)
    end
    
  end

  describe "POST #create" do

    describe "with valid params" do 
      it "creates and saves field" do
        field_params = {"name" => "author", "content" => "pekka"}
        expect{
          post :create, field:field_params
        }.to change(Field,:count).by(1)
      end
    end


  end

  describe "POST #update" do

    describe "with valid params" do 
      it "updates field" do
        field_params = {"name" => "author", "content" => "juukelispuukelis"}
        put :update, id:field.id, field:field_params

        field2 = Field.find_by content:"juukelispuukelis"
        expect(field2.content).to eq("juukelispuukelis")
      end
    end
  end
end