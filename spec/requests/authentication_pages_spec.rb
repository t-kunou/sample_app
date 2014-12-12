require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid infomation" do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
      it { should have_error_message('Invalid') }

      describe "after visitiong another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid infomation" do
        let(:user) { FactoryGirl.create(:user) }

      describe "before sign in" do
        it { should_not have_link('Profile', href: user_path(user)) }
        it { should_not have_link('Settings', href: edit_user_path(user)) }
        it { should_not have_link('Sign out', href: signout_path ) }
      end

      describe "after sign in" do
        before do
          sign_in user
        end

        it { should have_title(user.name) }
        it { should have_link('Users', href: users_path) }
        it { should have_link('Profile', href: user_path(user)) }
        it { should have_link('Settings', href: edit_user_path(user)) }
        it { should have_link('Sign out', href: signout_path ) }
        it { should_not have_link('sign in', href: signin_path) }

        describe "followed by signout" do
          before { click_link "Sign out" }
          it { should have_link('Sign in') }
        end

        describe "after visitiong signup page" do
          before do
            click_link "Home"
            click_link "Sign up"
          end
          it { should have_content('Welcome') }
        end

      end
    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "visiting the user index" do
          before { visit users_path }
          it { should have_title('Sign in') }
        end
      end

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          sign_in user
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            expect(page).to have_title('Edit user')
          end
        end
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user, no_capybara:true }

      describe "submitting a GET requrest to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Edit usrer')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_path) }
      end
    end

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin, no_capybara: true }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_path) }
      end
    end

  end
end
