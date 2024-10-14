require 'rails_helper'

RSpec.describe "PracticeRecords", type: :request do
  describe "index" do
    let(:request) { get("/practice_records") }
    let(:user) { FactoryBot.create(:user) }

    before do
      post '/login', params: { email: user.email, password: 'password' }
    end

    it "ステータスコード200" do
      request
      expect(response.status).to eq 200
    end
  end

  describe "new" do
    let(:user) { FactoryBot.create(:user) }

    context "ログインしている場合" do
      before { post '/login', params: { email: user.email, password: 'password' } }

      it "ステータスコード200" do
        get("/practice_records/new")
        expect(response.status).to eq 200
      end
    end

    context "ログインしていない場合" do

      it "ステータスコード302" do
        get("/practice_records/new")
        expect(response.status).to eq 302
      end
    end
  end

  describe "GET /practice_records/:id" do
    let(:user) { FactoryBot.create(:user) }
    let(:practice_record) { FactoryBot.create(:practice_record, user: user) }

    context "ログインしている場合" do
      before { post '/login', params: { email: user.email, password: 'password' } }

      it "ステータスコード200" do
        get("/practice_records/#{practice_record.id}")
        expect(response.status).to eq 200
      end
    end

    context "ログインしていない場合" do

      it "ステータスコード302" do
        get("/practice_records/#{practice_record.id}")
        expect(response.status).to eq 302
      end
    end
  end

  describe "POST /practice_records" do
    let(:user) { FactoryBot.create(:user) }

    context "ログインしている場合" do
      before { post '/login', params: { email: user.email, password: 'password' } }

      context "適切なパラメータの場合" do
        let(:params) {
          {
            practice_record: {
              title: "今日の日誌",
              practiced_date: Date.today,
            }
          }
        }

        it "ステータスコード302" do
          post("/practice_records", params: params)
          expect(response.status).to eq 302
        end

        it "practice_recordインスタンスが一つ作成されていること" do
          expect { post("/practice_records", params: params) }.to change { PracticeRecord.count }.by(1)
        end

        it "params通りに作成されていること" do
          post("/practice_records", params: params)
          expect(PracticeRecord.last.title).to eq params[:practice_record][:title]
          expect(PracticeRecord.last.practiced_date).to eq params[:practice_record][:practiced_date]
        end
      end

      context "不適切なパラメータの場合" do
        let(:params) {
          {
            practice_record: {
              title: nil,
              practiced_date: nil,
            }
          }
        }

        it "ステータスコード422" do
          post("/practice_records", params: params)
          expect(response.status).to eq 422
        end

        it "practice_recordインスタンスが作成されていないこと" do
          expect {
            post("/practice_records", params: params)
          }.to_not change { PracticeRecord.count }
        end
      end
    end

    context "ログインしていない場合" do
      let(:params) {
        {
          practice_record: {
            title: "今日の日誌",
            practiced_date: Date.today
          }
        }
      }

      it "ステータスコード302" do
        post("/practice_records", params: params)
        response.status.should eq 302
      end

      it "practice_recordインスタンスが作成されていないこと" do
        expect {
          post("/practice_records", params: params)
        }.to_not change { PracticeRecord.count }
      end
    end
  end

  describe "GET /practice_records/:id/edit" do
    let(:user) { FactoryBot.create(:user) }
    let(:practice_record) { FactoryBot.create(:practice_record, user: user) }

    context "ログインしている場合" do
      before { post '/login', params: { email: user.email, password: 'password' } }

      it "ステータスコード200" do
        get("/practice_records/#{practice_record.id}/edit")
        expect(response.status).to eq 200
      end
    end

    context "ログインしていない場合" do

      it "ステータスコード302" do
        get("/practice_records/#{practice_record.id}/edit")
        expect(response.status).to eq 302
      end
    end
  end

  describe "PATCH /practice_records/:id" do
    let(:user) { FactoryBot.create(:user) }
    let(:practice_record) { FactoryBot.create(:practice_record, user: user) }

    context "ログインしている場合" do
      before { post '/login', params: { email: user.email, password: 'password' } }

      context "適切なパラメータの場合" do
        let(:params) {
          {
            practice_record: {
              title: "今日の日誌",
              practiced_date: Date.today + 1.day
            }
          }
        }

        it "ステータスコード302" do
          patch("/practice_records/#{practice_record.id}", params: params)
          expect(response.status).to eq 302
        end

        it "practice_recordインスタンスが更新されていること" do
          patch("/practice_records/#{practice_record.id}", params: params)
          practice_record.reload

          expect(practice_record.title).to eq params[:practice_record][:title]
          expect(practice_record.practiced_date).to eq params[:practice_record][:practiced_date]
        end
      end

      context "不適切なパラメータの場合" do
        let(:params) {
          {
            practice_record: {
              title: nil,
              practiced_date: nil
            }
          }
        }

        it "ステータスコード422" do
          patch("/practice_records/#{practice_record.id}", params: params)
          expect(response.status).to eq 422
        end

        it "practice_recordインスタンスが更新されていないこと" do
          patch("/practice_records/#{practice_record.id}", params: params)
          practice_record.reload

          expect(practice_record.title).not_to eq nil
          expect(practice_record.practiced_date).not_to eq nil
        end
      end
    end

    context "ログインしていない場合" do

      it "ステータスコード302" do
        patch("/practice_records/#{practice_record.id}")
        expect(response.status).to eq 302
      end
    end
  end

  describe "DELETE /practice_records/:id" do
    let(:user) { FactoryBot.create(:user) }
    let!(:practice_record) { FactoryBot.create(:practice_record, user: user) }

    context "ログインしている場合" do
      before { post '/login', params: { email: user.email, password: 'password' } }

      it "ステータスコード302" do
        delete("/practice_records/#{practice_record.id}")
        expect(response.status).to eq 302
      end

      it "practice_recordインスタンスが削除されていること" do
        expect {
          delete("/practice_records/#{practice_record.id}")
        }.to change { PracticeRecord.count }.by(-1)
      end
    end

    context "ログインしていない場合" do

      it "ステータスコード302" do
        delete("/practice_records/#{practice_record.id}")
        expect(response.status).to eq 302
      end

      it "practice_recordインスタンスが削除されていないこと" do
        expect {
          delete("/practice_records/#{practice_record.id}")
        }.not_to change { PracticeRecord.count }
      end
    end
  end
end
