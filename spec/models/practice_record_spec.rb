require 'rails_helper'

RSpec.describe PracticeRecord, type: :model do
  describe "validation" do
    let(:user) { FactoryBot.create(:user) }

    describe "title" do

      context "titleあり" do
        let(:practice_record) { FactoryBot.build(:practice_record, user: user, title: "今日の練習") }

        it "作成成功" do
          expect(practice_record.save).to eq true
        end

        it "有効" do
          expect(practice_record).to be_valid
        end
      end

      context "titleなし" do
        let(:practice_record) { FactoryBot.build(:practice_record, user: user, title: nil) }

        it "作成失敗" do
          expect(practice_record.save).to eq false
        end

        it "無効" do
          expect(practice_record).to be_invalid
        end
      end
    end
  end
end
