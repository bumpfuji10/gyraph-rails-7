class LikesController < ApplicationController
  before_action :set_practice_record, only: [:create, :destroy]
  before_action :redirect_if_not_logged_in, only: [:create, :destroy]

  def index

  end

  def create
    @like = current_user.likes.new(practice_record: @practice_record)

    if @like.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "like_button_#{@practice_record.id}",
            partial: "shared/like_button",
            locals: { practice_record: @practice_record, liked: true, like: @like }
          )
        end
      end
    else
      flash.now[:alert] = "いいねに失敗しました"
      flash.now[:alert_detail] = "時間をおいて再度お試しください"
      render "practice_records/show", status: :unprocessable_entity
    end
  end

  def destroy
    like = @practice_record.likes.find(params[:id])

    if like.destroy
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "like_button_#{@practice_record.id}",
            partial: "shared/like_button",
            locals: { practice_record: @practice_record, liked: false }
          )
        end
      end
    else
      redirect_to @practice_record, alert: "いいねの取り消しに失敗しました"
    end
  end

  private

  def set_practice_record
    @practice_record = PracticeRecord.find(params[:practice_record_id])
  end
end
