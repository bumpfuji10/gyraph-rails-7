class PracticeRecordForm
  # ActiveModel::Modelをincludeすることで、バリデーションやエラーメッセージの機能を使えるようになる
  include ActiveModel::Model

  attr_accessor :user, :title, :practiced_date, :practice_record_details_attributes

  validates :title, presence: true
  validates :practiced_date, presence: true
  validates :practice_record_details_attributes, presence: true

  # MEMO
  # attributes = {
  #   user: User.first,
  #   title: "New Practice Record",
  #   practiced_date: Date.today,
  #   practice_record_details_attributes: [
  #     { activity_title: "Running", content: "5 km" },
  #     { activity_title: "Swimming", content: "1 km" }
  #   ]
  # }
  def initialize(attributes = {})
    # attributesにはフォームから送信されたデータが入る

    @user = attributes[:user]
    @title = attributes[:title]
    @practiced_date = attributes[:practiced_date]
    @practice_record_details_attributes = attributes[:practice_record_details_attributes]
  end

  def save
    return false if invalid?
    practice_record = PracticeRecord.new(
      user: user,
      title: title,
      practiced_date: practiced_date
    )

    practice_record_details_attributes.each do |detail_attributes|
      practice_record.practice_record_details.build(
        activity_title: detail_attributes[:activity_title],
        content: detail_attributes[:content]
      )
    end

    practice_record.save
  end
end
