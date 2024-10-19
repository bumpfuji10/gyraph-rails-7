require "rails_helper"

RSpec.describe LikesController, type: :request do
  describe "POST /practice_records/:id/likes" do

    context "ログインしている場合" do
      let(:user) { FactoryBot.create(:user, email: "hoge@user.com") }
      let(:practice_record) { FactoryBot.create(:practice_record) }

      before { post '/login', params: { email: user.email, password: 'password' } }

      it "レスポンス200" do
        post("/practice_records/#{practice_record.id}/likes", headers: { "ACCEPT" => "text/vnd.turbo-stream.html" })
        expect(response.status).to eq 200
      end

      it "likeの数が1増加" do
        expect {
          post("/practice_records/#{practice_record.id}/likes", headers: { "ACCEPT" => "text/vnd.turbo-stream.html" })
        }.to change(Like, :count).by(1)
      end

      context "すでにlikeしている場合" do
        let!(:like) { FactoryBot.create(:like, user: user, practice_record: practice_record) }

        it "raise ActiveRecord::RecordNotUnique" do
          expect {
            post("/practice_records/#{practice_record.id}/likes", headers: { "ACCEPT" => "text/vnd.turbo-stream.html" })
          }.to raise_error(ActiveRecord::RecordNotUnique)
        end
      end
    end

    context "ログインしていない場合" do
      let(:user) { FactoryBot.create(:user, email: "hoge@user.com") }
      let(:practice_record) { FactoryBot.create(:practice_record) }

      it "likeの作成に失敗" do
        post("/practice_records/#{practice_record.id}/likes", headers: { "ACCEPT" => "text/vnd.turbo-stream.html" })
        expect(response.status).to eq 302
      end

      it "likeの数が変化しない" do
        expect {
          post("/practice_records/#{practice_record.id}/likes", headers: { "ACCEPT" => "text/vnd.turbo-stream.html" })
        }.to_not change(Like, :count)
      end

      it "flash表示" do
        post("/practice_records/#{practice_record.id}/likes", headers: { "ACCEPT" => "text/vnd.turbo-stream.html" })
        expect(flash[:alert]).to eq "ログインしてください"
      end
    end
  end

  describe "DELETE /practice_records/:id/likes/:id" do

    context "ログインしている場合" do
      let(:user) { FactoryBot.create(:user, email: "hoge@user.com") }
      before { post '/login', params: { email: user.email, password: 'password' } }

      let(:practice_record) { FactoryBot.create(:practice_record) }
      let!(:like) { FactoryBot.create(:like, user: user, practice_record: practice_record) }

      it "レスポンス200" do
        delete("/practice_records/#{practice_record.id}/likes/#{like.id}", headers: { "ACCEPT" => "text/vnd.turbo-stream.html" })
        expect(response.status).to eq 200
      end

      it "likeの数が1減少" do
        expect {
          delete("/practice_records/#{practice_record.id}/likes/#{like.id}", headers: { "ACCEPT" => "text/vnd.turbo-stream.html" })
        }.to change(Like, :count).by(-1)
      end
    end

    context "ログインしていない場合" do
      let(:user) { FactoryBot.create(:user, email: "hoge@user.com") }
      let(:practice_record) { FactoryBot.create(:practice_record) }

      it "レスポンス302" do
        delete("/practice_records/#{practice_record.id}/likes/1", headers: { "ACCEPT" => "text/vnd.turbo-stream.html" })
        expect(response.status).to eq 302
      end

      it "likeの数が変化しない" do
        expect {
          delete("/practice_records/#{practice_record.id}/likes/1", headers: { "ACCEPT" => "text/vnd.turbo-stream.html" })
        }.to_not change(Like, :count)
      end
    end


  end
end
