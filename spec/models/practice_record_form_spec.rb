require "rails_helper"

RSpec.describe PracticeRecordForm, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:attributes) do
    {
      user: user,
      title: "本日の練習",
      practiced_date: Date.today,
      practice_record_details_attributes: [
        { activity_title: "ゆか", content: "転倒1回" },
        { activity_title: "あん馬", content: "落下2回"}
      ]
    }
  end
  let(:practice_record_form) { PracticeRecordForm.new(attributes) }

  describe "validates" do

    context "title" do

      context "titleがある場合" do
        it "practice_record_formが有効" do
          expect(practice_record_form).to be_valid
        end
      end

      context "titleが無い場合" do

        it "practice_record_formが無効" do
          practice_record_form.title = nil
          expect(practice_record_form).to be_invalid
        end
      end
    end

    context "practiced_date" do

      context "practiced_dateがある場合" do

        it "practice_record_formが有効" do
          expect(practice_record_form).to be_valid
        end
      end

      context "practiced_dateが無い場合" do

        it "practice_record_formが無効" do
          practice_record_form.practiced_date = nil
          expect(practice_record_form).to be_invalid
        end
      end
    end

    context "practice_record_details_attributes" do

      context "practice_record_details_attributesがある場合" do

      end

      context "practice_record_details_attributesが無い場合" do

      end
    end
  end
end
