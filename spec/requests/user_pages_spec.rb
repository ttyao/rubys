require 'spec_helper'

describe "UserPages" do
  subject {page}
  describe "Signup page" do
    before {visit signup_path}
    it {should have_content 'Sign up'}
    it {should have_title(full_title('Sign up'))}
  end

  describe "edit" do
    let(:user) {FactoryGirl.create(:user)}
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it {should have_content("Update your profile")}
      it {should have_title("Edit user")}
      it {should have_link("change", href: "http://gravatar.com/emails")}
    end

    describe "with valid information" do
      let(:new_user) { "New Name" }
      let(:new_email) { "new@gmail.com" }
      before do
        fill_in "Name", with: new_user
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it {should have_title new_user}
      it {should have_selector 'div.alert.alert-success'}
      it {should have_link 'Sign out', href: signout_path}
      specify {expect(user.reload.name).to eq new_user}
      specify {expect(user.reload.email).to eq new_email}
    end

    describe "with invalid information" do
      before {click_button "Save changes"}
      it {should have_content "error"}
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user)}
    before {visit user_path(user)}

    it {should have_content(user.name)}
    it {should have_title(user.name)}
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end
