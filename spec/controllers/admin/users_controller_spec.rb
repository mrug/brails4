require 'spec_helper'

describe Admin::UsersController do
  login(:admin)
  let(:profile) { create(:profile)}
  let(:user) { profile.user}
  let(:attrs) { attributes_for(:user)}
  let(:invalid_attrs) { attributes_for(:user, title: nil)}

  describe "GET #index" do
    it "populates an array of users" do
      get :index
      page_users = assigns[:users]

      expect(page_users).to include(user)
    end

    it "renders the :index view" do
      get :index

      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    context "when find the user" do
      it "assigns the requested User to @user" do
        get :show, id: user.id
        page_user = assigns[:user]

        expect(user).to eq page_user
      end

      it "renders the :show template" do
        get :show, id: user.id

        expect(response).to render_template :show
      end
    end
  end

  describe "GET #edit" do
    it "assigns the requested User to @user" do
      get :edit, id: user.id
      page_user = assigns[:user]

      expect(user).to eq page_user
    end

    it "renders the :edit template" do
      get :edit, id: user.id

      expect(response).to render_template :edit
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      it "changes @user attributes" do
        attributes = attributes_for(:user, name: "New title")

        put :update, id: user.id, user: attributes
        user.reload

        expect(user.name).to eq "New title"
      end

      it "redirects to the :index view" do
        attributes = attributes_for(:user, name: "New title")

        put :update, id: user.id, user: attributes

        expect(response).to redirect_to admin_user_path(assigns[:user])
      end
    end

    context "with invalid attributes" do
      it "doesn't changes @user attributes" do
        put :update, id: user.id, user: invalid_attrs
        updated_user = user.reload

        expect(user).to eq updated_user
      end

      it "redirects to the :edit view" do
        put :update, id: user.id, user: invalid_attrs

        expect(response).to render_template :edit
      end
    end
  end
end