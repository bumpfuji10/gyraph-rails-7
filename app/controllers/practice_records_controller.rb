class PracticeRecordsController < ApplicationController
  before_action :set_user

  def index
    @practice_records = PracticeRecord.all
  end

  def show
    @practice_record = PracticeRecord.find(params[:id])
  end

  def new
    @practice_record = PracticeRecord.new
    @practice_record.practice_record_details.build
  end

  def create
    @practice_record = @user.practice_records.new(practice_record_params)
    if @practice_record.save
      redirect_to(practice_records_path, notice: "練習記録を作成しました")
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  private

  def set_user
    @user = current_user
  end

  def practice_record_params
    params.require(:practice_record).permit(
      :title,
      :practiced_date,
      practice_record_details_attributes: [:id, :activity_title, :content, :_destroy]
    )
  end
end
