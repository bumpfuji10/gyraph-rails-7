module PracticeRecordsHelper

  def practiced_date_format_ja(date)
    date.strftime("%Y/%m/%d")
  end

  def format_with_line_breaks(text)
    text.gsub(/\r\n|\r|\n/, "<br />").html_safe
  end
end
