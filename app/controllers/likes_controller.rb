class LikesController < ApplicationController

  def index

  end

  def create
    @practice_record = PracticeRecord.find(params[:practice_record_id])
    like = Like.new(user: current_user, practice_record: @practice_record)

    if like.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "like_button_#{@practice_record.id}",
            partial: "shared/like_button",
            locals: { practice_record: @practice_record, liked: true }
          )
        end
      end
    else
      flash[:alert] = "いいねに失敗しました"
      redirect_to @practice_record
    end

  end

  def destroy

  end
end
