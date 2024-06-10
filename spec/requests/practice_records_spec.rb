require 'rails_helper'

RSpec.describe "PracticeRecords", type: :request do
  describe "index" do
    let(:request) { get("/practice_records") }

    it "ステータスコード200" do
      request
      expect(response.status).to eq 200
    end
  end

  # describe "new" do
  #   let(:request) { get("/practice_records/new") }

  #   it "ステータスコード200" do
  #     request
  #     expect(response.status).to eq 200
  #   end
  # end

end
