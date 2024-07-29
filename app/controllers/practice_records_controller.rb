class PracticeRecordsController < ApplicationController
  before_action :redirect_if_logged_in

  def index
    @practice_records = PracticeRecord.all.order(id: :desc)
  end

  def show
    @practice_record = PracticeRecord.find(params[:id])
  end

  def new
    @form = PracticeRecordForm.new(
      practice_record_details_attributes: [{}]
    )
  end

  def create
    @form = PracticeRecordForm.new(practice_record_form_params.merge(user: current_user))
    if @form.save
      redirect_to(practice_records_path, notice: "練習記録を作成しました")
    else
      render :new
    end
  end

  private

  # def set_user
  #   @user = current_user
  # end

  def practice_record_form_params
    params.require(:practice_record_form).permit(
      :title,
      :practiced_date,
      practice_record_details_attributes: [
        :activity_title,
        :content
      ]
    )
  end
end
