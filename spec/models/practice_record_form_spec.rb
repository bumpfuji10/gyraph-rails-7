require "rails_helper"

RSpec.describe PracticeRecordForm, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:attributes) do
    {
      user: user,
      title: "本日の練習",
      practiced_date: Date.today.to_s,
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

        it "practice_record_formが有効" do
          expect(practice_record_form).to be_valid
        end
      end

      context "practice_record_details_attributesが無い場合" do

          it "practice_record_formが無効" do
            practice_record_form.practice_record_details_attributes = nil
            expect(practice_record_form).to be_invalid
          end
      end
    end
  end

  describe "save" do

    context "有効な属性値の場合" do
      let(:valid_attributes) do
        {
          user: user,
          title: "本日の練習",
          practiced_date: Date.today.to_s,
          practice_record_details_attributes: [
            { activity_title: "ゆか", content: "転倒1回" },
            { activity_title: "あん馬", content: "落下2回"}
          ]
        }
      end
      let(:practice_record_form) { PracticeRecordForm.new(valid_attributes) }

      it "practice_recordが保存される" do
        expect(practice_record_form.save).to eq true
      end

      it "PracticeRecordにattributes通りのレコードが入っていること" do
        practice_record_form.save
        expect(PracticeRecord.last.title).to eq valid_attributes[:title]
      end

      it "practice_record_detailsが2つ保存される" do
        practice_record_form.save
        expect(PracticeRecord.last.practice_record_details.count).to eq valid_attributes[:practice_record_details_attributes].count
      end

      context "無効な属性値の場合" do
        let(:invalid_attributes) do
          {
            user: user,
            title: nil,
            practiced_date: Date.today,
            practice_record_details_attributes: [
              { activity_title: "ゆか", content: "転倒1回" },
              { activity_title: "あん馬", content: "落下2回"}
            ]
          }
        end
        let(:practice_record_form) { PracticeRecordForm.new(invalid_attributes) }

        it "practice_recordが保存されない" do
          expect(practice_record_form.save).to eq false
        end
      end
    end
  end
end
