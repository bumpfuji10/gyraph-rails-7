class CalendarsController < ApplicationController
  def show
    @date = params[:date].present? ? Date.parse(params[:date]) : Date.today
    @practice_records = PracticeRecord.where(practiced_date: @date.all_month)

    respond_to do |format|
      format.html do
        render partial: "shared/calendar", locals: { date: @date, practice_records: @practice_records }
      end
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('calendar', partial: "shared/calendar", locals: { date: @date, practice_records: @practice_records })
      end
    end
  end
end
