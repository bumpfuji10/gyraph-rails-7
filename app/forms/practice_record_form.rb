class PracticeRecordForm
  # ActiveModel::Modelをincludeすることで、バリデーションやエラーメッセージの機能を使えるようになる
  include ActiveModel::Model

  attr_accessor :title, :practiced_date, :practice_record_details_attributes

  validates :title, presence: true
  validates :practiced_date, presence: true
  validates :practice_record_details_attributes, presence: true

  # MEMO
  # attributes = {
  #   title: "New Practice Record",
  #   practiced_date: Date.today,
  #   practice_record_details_attributes: [
  #     { activity_title: "Running", content: "5 km" },
  #     { activity_title: "Swimming", content: "1 km" }
  #   ]
  # }
  def initialize(attributes = {})
    # attributesにはフォームから送信されたデータが入る

    @title = attributes[:title]
    @practiced_date = attributes[:practiced_date]
    @practice_record_details_attributes = attributes[:practice_record_details_attributes]
  end
end
