require 'rails_helper'

RSpec.describe PracticeRecordsHelper, type: :helper do

  describe "practiced_date_format_ja" do
    let(:practice_record) do
      FactoryBot.create(:practice_record)
    end

    let(:practiced_date) { practice_record.practiced_date }

    it "日本語の日付フォーマットに変換すること" do
      expect(practiced_date_format_ja(practiced_date)).to eq practiced_date.strftime("%Y/%m/%d")
    end
  end

  describe "format_with_line_breaks" do
    let(:text) { "テスト\r\nテスト" }

    it "改行コードをbrタグに変換すること" do
      expect(format_with_line_breaks(text)).to eq "テスト<br />テスト"
    end
  end
end
