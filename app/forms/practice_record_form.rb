class PracticeRecordForm
  include ActiveModel::Model

  attr_accessor :user, :title, :practiced_date, :practice_record_details_attributes

  validates :title, presence: true
  validates :practiced_date, presence: true
  validates :practice_record_details_attributes, presence: true

  def initialize(attributes = {})
    @user = attributes[:user]
    @title = attributes[:title]
    @practiced_date = parse_date(attributes[:practiced_date])
    @practice_record_details_attributes = normalize_details_attributes(attributes[:practice_record_details_attributes])
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

    practice_record.save!
  end

  private

  # 文字列をDateオブジェクトに変換するメソッド
  def parse_date(date_string)
    Date.parse(date_string) rescue nil
  end

  # formではobjectの初期化によってattributesがArray渡ってくる
  def normalize_details_attributes(details)
    return details if details.is_a?(Array)

    details.to_unsafe_h.values
  end
end
