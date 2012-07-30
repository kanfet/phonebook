require "spec_helper"

describe PhonesController do

  describe "GET #index" do
    before(:each) do
      @phones = [mock_model(Phone), mock_model(Phone), mock_model(Phone)]
      Phone.stub(:all).and_return(@phones)
      get :index
    end

    it { should assign_to(:phones).with(@phones) }
    it { should render_template :index }
  end

  describe "POST #create" do

    context "with valid attributes" do
      it "creates new phone" do
        expect{
          post :create, phone: attributes_for(:phone)
        }.to change(Phone, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "does not create new phone" do
        expect{
          post :create, phone: attributes_for(:invalid_phone)
        }.not_to change(Phone, :count)
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes phone" do
      phone = create :phone
      expect{
        delete :destroy, id: phone
      }.to change(Phone, :count).by(-1)
    end
  end

  describe "GET #edit" do
    before(:each) do
      @phone = create :phone
      get :edit, id: @phone
    end
    it { should assign_to(:phone).with(@phone) }
  end

  describe "GET #show" do
    before(:each) do
      @phone = create :phone
      get :show, id: @phone
    end
    it { should assign_to(:phone).with(@phone) }
  end

  describe "PUT #update" do
    before(:each) do
      @phone = create :phone
    end

    it "assigns requested phone" do
      put :update, id: @phone, phone: attributes_for(:phone, name: "Chuck Norris")
      assigns(:phone).should == @phone
    end

    context "with valid attributes" do
      it "changes phone's attributes" do
        put :update, id: @phone, phone: attributes_for(:phone, name: "Chuck Norris")
        @phone.reload
        @phone.name.should == "Chuck Norris"
      end
    end

    context "with invalid attributes" do
      it "does not change phone's attributes" do
        put :update, id: @phone, phone: attributes_for(:phone, name: nil)
        @phone.reload
        @phone.name.should_not == nil
      end
    end
  end
end