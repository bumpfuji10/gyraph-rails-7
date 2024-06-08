require 'rails_helper'

RSpec.describe PracticeRecordDetail, type: :model do
  describe "validations" do

    describe "activity_title" do

      context "activity_titleあり" do
        let(:practice_record_detail) { FactoryBot.build(:practice_record_detail, activity_title: "本日の練習") }

        it "保存成功" do
          expect(practice_record_detail.save).to eq true
        end

        it "有効" do
          expect(practice_record_detail).to be_valid
        end
      end

      context "activity_titleなし" do
        let(:practice_record_detail) { FactoryBot.build(:practice_record_detail, activity_title: nil) }

        it "保存失敗" do
          expect(practice_record_detail.save).to eq false
        end

        it "無効" do
          expect(practice_record_detail).to be_invalid
        end
      end

      context "長さ100文字" do
        let(:practice_record_detail) { FactoryBot.build(:practice_record_detail, activity_title: "a" * 100) }

        it "保存成功" do
          expect(practice_record_detail.save).to eq true
        end

        it "有効" do
          expect(practice_record_detail).to be_valid
        end
      end

      context "長さ101文字" do
        let(:practice_record_detail) { FactoryBot.build(:practice_record_detail, activity_title: "a" * 101) }

        it "保存失敗" do
          expect(practice_record_detail.save).to eq false
        end

        it "無効" do
          expect(practice_record_detail).to be_invalid
        end
      end
    end

    context "content" do

      context "contentあり" do
        let(:practice_record_detail) { FactoryBot.build(:practice_record_detail, content: "いい感じでした") }

        it "保存成功" do
          expect(practice_record_detail.save).to eq true
        end

        it "有効" do
          expect(practice_record_detail).to be_valid
        end
      end

      context "contentなし" do
        let(:practice_record_detail) { FactoryBot.build(:practice_record_detail, content: nil) }

        it "保存失敗" do
          expect(practice_record_detail.save).to eq false
        end

        it "無効" do
          expect(practice_record_detail).to be_invalid
        end
      end

      context "長さ10000文字" do
        let(:practice_record_detail) { FactoryBot.build(:practice_record_detail, content: "a" * 10000) }

        it "保存成功" do
          expect(practice_record_detail.save).to eq true
        end

        it "有効" do
          expect(practice_record_detail).to be_valid
        end
      end

      context "長さ10001文字" do
        let(:practice_record_detail) { FactoryBot.build(:practice_record_detail, content: "a" * 10001) }

        it "保存失敗" do
          expect(practice_record_detail.save).to eq false
        end

        it "無効" do
          expect(practice_record_detail).to be_invalid
        end
      end
    end
  end
end
