module SessionsHelper

  def sign_in(user)
    remenber_token = User.new_remenber_token
    cookies.permanent[:remenber_token] = remenber_token
    user.update_attribute(:remenber_token, User.encrypt(remenber_token))
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remenber_token = User.encrypt(cookies[:remenber_token])
    @current_user ||= User.find_by(remenber_token: remenber_token)
  end

  def current_user?(user)
    user == current_user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remenber_token)
  end

end
