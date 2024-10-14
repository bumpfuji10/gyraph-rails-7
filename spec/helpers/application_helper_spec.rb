require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do

  describe "extract_domain_from_email" do
    let(:email) { "test@test.com" }

    it "emailの@以前の文字列をIDかのような形式で加工すること" do
      expect(extract_domain_from_email(email)).to eq "@test"
    end
  end
end
