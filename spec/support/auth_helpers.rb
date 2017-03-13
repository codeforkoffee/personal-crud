module AuthHelpers
  def sign_in(user)
    params = { email: user.email, password: user.password }

    post "/login", params
  end
end
