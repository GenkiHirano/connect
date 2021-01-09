require 'rails_helper'

RSpec.describe "LiveCompanions", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:live_companion) { create(:live_companion, :picture, user: user) }
  let!(:comment) { create(:comment, user_id: user.id, live_companion: live_companion) }

  describe "ライブ同行者募集投稿ページ" do
    before do
      login_for_system(user)
      visit new_live_companion_path
    end

    context "ページレイアウト" do
      it "「一緒にライブに行く人を募集する」の文字列が存在すること" do
        expect(page).to have_content '一緒にライブに行く人を募集する'
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('一緒にライブに行く人を募集する')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content 'アーティスト名'
        expect(page).to have_content 'ライブ名'
        expect(page).to have_content '日程'
        expect(page).to have_content '会場'
        expect(page).to have_content 'ライブメモ'
      end
    end

    context "ライブ同行者募集投稿処理" do
      it "有効な情報でライブ同行者募集投稿を行うと「ライブ同行者の募集が完了しました！」のフラッシュが表示されること" do
        fill_in "live_companion[artist_name]", with: "米津玄師"
        fill_in "live_companion[live_name]",   with: "米津玄師 2020 TOUR / HYPE"
        fill_in "live_companion[schedule]",    with: "2030-8-6"
        fill_in "live_companion[live_venue]", with: "埼玉スーパーアリーナ"
        fill_in "live_companion[live_memo]",   with: "誰か、米津玄師さんの一緒にライブ行きませんか...？"
        attach_file "live_companion[picture]", "#{Rails.root}/spec/fixtures/test_live_companion.jpg"
        click_button "登録する"
        expect(page).to have_content "ライブ同行者の募集が完了しました！"
      end

      it "画像無しで登録すると、デフォルト画像が割り当てられること" do
        fill_in "live_companion[artist_name]", with: "米津玄師"
        fill_in "live_companion[live_name]",   with: "米津玄師 2020 TOUR / HYPE"
        fill_in "live_companion[schedule]",    with: "2030-8-6"
        fill_in "live_companion[live_venue]", with: "埼玉スーパーアリーナ"
        fill_in "live_companion[live_memo]", with: "誰か、米津玄師さんの一緒にライブ行きませんか...？"
        click_button "登録する"
        expect(page).to have_link(href: live_companion_path(LiveCompanion.first))
      end

      it "無効な情報でライブ同行者募集投稿を行うと登録失敗のフラッシュが表示されること" do
        fill_in "live_companion[artist_name]", with: ""
        fill_in "live_companion[live_name]",   with: "米津玄師 2020 TOUR / HYPE"
        fill_in "live_companion[schedule]",    with: "2030-8-6"
        fill_in "live_companion[live_venue]", with: "埼玉スーパーアリーナ"
        fill_in "live_companion[live_memo]", with: "誰か、米津玄師さんの一緒にライブ行きませんか...？"
        click_button "登録する"
        expect(page).to have_content "アーティスト名を入力してください"
      end
    end
  end

  describe "投稿詳細ページ" do
    context "ページレイアウト" do
      before do
        login_for_system(user)
        visit live_companion_path(live_companion)
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title("#{live_companion.artist_name}")
      end

      it "ライブ情報が表示されること" do
        expect(page).to have_content live_companion.artist_name
        expect(page).to have_content live_companion.live_name
        expect(page).to have_content live_companion.schedule
        expect(page).to have_content live_companion.live_venue
        expect(page).to have_content live_companion.live_memo
        expect(page).to have_link nil, href: live_companion_path(live_companion), class: 'live_companion-picture'
      end
    end

    context "投稿の削除", js: true do
      it "削除成功のフラッシュが表示されること" do
        login_for_system(user)
        visit live_companion_path(live_companion)
        within find('.change-live_companion') do
          click_on :delete
        end
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '投稿が削除されました'
      end
    end

    context "コメントの登録＆削除" do
      it "自分の投稿に対するコメントの登録＆削除が正常に完了すること" do
        login_for_system(user)
        visit live_companion_path(live_companion)
        fill_in "comment_content", with: "誰か一緒に行きましょう！"
        click_button "コメント"
        within find("#comment-#{Comment.last.id}") do
          expect(page).to have_selector 'span', text: user.name
          expect(page).to have_selector 'span', text: '誰か一緒に行きましょう！'
        end
        expect(page).to have_content "コメントを追加しました！"
        click_link "削除", href: comment_path(Comment.last)
        expect(page).not_to have_selector 'span', text: '誰か一緒に行きましょう！'
        expect(page).to have_content "コメントを削除しました"
      end

      it "別ユーザーの投稿コメントには削除リンクが無いこと" do
        login_for_system(other_user)
        visit live_companion_path(live_companion)
        within find("#comment-#{comment.id}") do
          expect(page).to have_selector 'span', text: user.name
          expect(page).to have_selector 'span', text: comment.content
          expect(page).not_to have_link '削除', href: live_companion_path(live_companion)
        end
      end
    end

    context "検索機能" do
      context "ログインしている場合" do
        before do
          login_for_system(user)
          visit root_path
        end

        it "ログイン後の各ページに検索窓が表示されていること" do
          expect(page).to have_css 'form#live_companion_search'
          visit about_path
          expect(page).to have_css 'form#live_companion_search'
          visit users_path
          expect(page).to have_css 'form#live_companion_search'
          visit user_path(user)
          expect(page).to have_css 'form#live_companion_search'
          visit edit_user_path(user)
          expect(page).to have_css 'form#live_companion_search'
          visit following_user_path(user)
          expect(page).to have_css 'form#live_companion_search'
          visit followers_user_path(user)
          expect(page).to have_css 'form#live_companion_search'
          visit live_companions_path
          expect(page).to have_css 'form#live_companion_search'
          visit live_companion_path(live_companion)
          expect(page).to have_css 'form#live_companion_search'
          visit new_live_companion_path
          expect(page).to have_css 'form#live_companion_search'
          visit edit_live_companion_path(live_companion)
          expect(page).to have_css 'form#live_companion_search'
        end

        it "フィードの中から検索ワードに該当する結果が表示されること" do
          create(:live_companion, artist_name: 'YUI',  live_name: 'CHE.R.RY.ツアー tokyo',  user: user)
          create(:live_companion, artist_name: 'YUKI', live_name: 'CHE.R.RY.ツアー saga',   user: other_user)

          fill_in 'q[artist_name_or_live_name_cont]', with: 'YU'
          click_button '検索'
          expect(page).to have_css 'h3', text: "”YU”の検索結果：1件"
          within find('.live_companions') do
            expect(page).to have_css 'li', count: 1
          end

          fill_in 'q[artist_name_or_live_name_cont]', with: 'CHE.R.RY.ツアー'
          click_button '検索'
          expect(page).to have_css 'h3', text: "”CHE.R.RY.ツアー”の検索結果：1件"
          within find('.live_companions') do
            expect(page).to have_css 'li', count: 1
          end

          user.follow(other_user)
          fill_in 'q[artist_name_or_live_name_cont]', with: 'YU'
          click_button '検索'
          expect(page).to have_css 'h3', text: "”YU”の検索結果：2件"
          within find('.live_companions') do
            expect(page).to have_css 'li', count: 2
          end

          fill_in 'q[artist_name_or_live_name_cont]', with: 'CHE.R.RY.ツアー'
          click_button '検索'
          expect(page).to have_css 'h3', text: "”CHE.R.RY.ツアー”の検索結果：2件"
          within find('.live_companions') do
            expect(page).to have_css 'li', count: 2
          end
        end

        it "検索ワードを入れずに検索ボタンを押した場合、投稿一覧が表示されること" do
          fill_in 'q[artist_name_or_live_name_cont]', with: ''
          click_button '検索'
          expect(page).to have_css 'h3', text: "投稿一覧"
          within find('.live_companions') do
            expect(page).to have_css 'li', count: LiveCompanion.count
          end
        end
      end

      context "ログインしていない場合" do
        it "検索窓が表示されないこと" do
          visit root_path
          expect(page).not_to have_css 'form#live_companion_search'
        end
      end
    end
  end

  describe "投稿編集ページ" do
    before do
      login_for_system(user)
      visit live_companion_path(live_companion)
      click_link "編集"
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('投稿の編集')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content 'アーティスト名'
        expect(page).to have_content 'ライブ名'
        expect(page).to have_content '日程'
        expect(page).to have_content '会場'
        expect(page).to have_content 'ライブメモ'
      end

      context "投稿の削除処理", js: true do
        it "削除成功のフラッシュが表示されること" do
          click_on '削除'
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content '投稿が削除されました'
        end
      end
    end

    context "投稿の更新処理" do
      it "有効な更新" do
        fill_in "live_companion[artist_name]", with: "編集：米津玄師"
        fill_in "live_companion[live_name]",   with: "編集：米津玄師 2020 TOUR / HYPE"
        fill_in "live_companion[live_venue]", with: "編集：埼玉スーパーアリーナ"
        fill_in "live_companion[live_memo]",   with: "編集：誰か、米津玄師さんのライブ一緒に行きませんか...？"
        attach_file "live_companion[picture]", "#{Rails.root}/spec/fixtures/test_live_companion2.jpg"
        click_button "更新する"
        expect(page).to have_content "ライブ情報が更新されました！"
        expect(live_companion.reload.artist_name).to eq "編集：米津玄師"
        expect(live_companion.reload.live_name).to eq "編集：米津玄師 2020 TOUR / HYPE"
        expect(live_companion.reload.live_venue).to eq "編集：埼玉スーパーアリーナ"
        expect(live_companion.reload.live_memo).to eq "編集：誰か、米津玄師さんのライブ一緒に行きませんか...？"
        expect(live_companion.reload.picture.url).to include "test_live_companion2.jpg"
      end

      it "無効な更新" do
        fill_in "live_companion[artist_name]", with: ""
        click_button "更新する"
        expect(page).to have_content 'アーティスト名を入力してください'
        expect(live_companion.reload.artist_name).not_to eq ""
      end
    end
  end
end
