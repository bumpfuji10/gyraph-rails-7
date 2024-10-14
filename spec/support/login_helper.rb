module LoginHelper
  def log_in(user)
    session[:user_id] = user.id
  end
end

RSpec.configure do |config|
  config.include LoginHelper, type: :request
end
