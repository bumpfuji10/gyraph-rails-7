class PracticeRecordsController < ApplicationController

  def index
    @practice_records = PracticeRecord.all.order(id: :desc)
  end

  def show
    @practice_record = PracticeRecord.find(params[:id])
  end

  def new
    @practice_record = PracticeRecord.new
    @practice_record.practice_record_details.build
  end

  def create
    @practice_record = current_user.practice_records.new(practice_record_params)
    if @practice_record.save
      flash[:success] = "#{@practice_record.practiced_date.strftime("%Y年%m月%d日")}の練習日誌を公開しました"
      redirect_to(practice_records_path)
    else
      flash.now[:alert] = "練習日誌の公開に失敗しました"
      flash.now[:alert_detail] = @practice_record.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  private

  def practice_record_params
    params.require(:practice_record).permit(:title, :practiced_date,
      practice_record_details_attributes: [
        :activity_title,
        :content
      ]
    )
  end
end
