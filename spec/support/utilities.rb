include ApplicationHelper

def valid_signin(user)
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def sign_in(user, options={})
  if options[:no_capybara]
    remenber_token = User.new_remenber_token
    cookies[:remenber_token] = rembner_token
    user.update_attribute(:remenber_token, User.encrypt(remenber_token))
  else
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers.define :have_not_error_message do |message|
  match do |page|
    expect(page).not_to have_selector('div.alert.alert-error')
  end
end
