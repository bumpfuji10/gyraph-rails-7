module ApplicationHelper
  def extract_domain_from_email(email)
    return "@#{email.split('@').first}"
  end
end
