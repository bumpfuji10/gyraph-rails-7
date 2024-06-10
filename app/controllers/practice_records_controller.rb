class PracticeRecordsController < ApplicationController

  def index
    @practice_records = PracticeRecord.all
  end

  def new

  end

  def create

  end
end
