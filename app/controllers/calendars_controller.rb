class CalendarsController < ApplicationController
  def show
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @practice_records = PracticeRecord.where(practiced_date: @date.all_month)

    respond_to do |format|
      format.html
      format.turbo_stream do
        render partial: "shared/calendar", locals: { date: @date, practice_records: @practice_records }
      end
    end
  end
end
