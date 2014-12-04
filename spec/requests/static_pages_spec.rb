require 'spec_helper'

describe "StaticPages" do
  let(:msg) { "Ruby on Rails Tutorial Sample App | " }

  describe "Home page" do
    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      expect(page).to have_content('Sample App')
    end
    it "should have the titile 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_title(msg + "Home")
    end
  end

  describe "Help page" do
    it "should have the conent 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end
    it "should have the titile 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_title(msg + "Help")
    end
  end
  
  describe "About page" do
    it "should have the congtent 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_content('About Us')
    end
    it "should have the titile 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_title(msg + "About Us")
    end
  end

  describe "Contact page" do
    it "should have the congtent 'Contact'" do
      visit '/static_pages/contact'
      expect(page).to have_content('Contact')
    end
    it "should have the title 'Contact'" do
      visit '/static_pages/contact'
      expect(page).to have_title(msg + "Contact")
    end
  end

end
