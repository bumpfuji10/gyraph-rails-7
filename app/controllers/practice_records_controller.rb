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
      flash[:success] = "#{@form.practiced_date.strftime("%Y年%m月%d日")}の練習日誌を公開しました"
      redirect_to(practice_records_path)
    else
      flash.now[:alert] = "練習日誌の公開に失敗しました"
      flash.now[:alert_detail] = @form.errors.full_messages.join("\n")
      pp flash
      render :new, status: :unprocessable_entity
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
