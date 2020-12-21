require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:user) { create(:user) }
  let!(:admin_user) { create(:user, :admin) }
  let!(:other_user) { create(:user) }
  let!(:live_companion) { create(:live_companion, user: user) }
  let!(:other_live_companion) { create(:live_companion, user: other_user) }

  describe "ユーザー一覧ページ" do
    context "管理者ユーザーの場合" do
      it "ぺージネーション、自分以外のユーザー削除ボタンが表示されること" do
        create_list(:user, 30)
        login_for_system(admin_user)
        visit users_path
        expect(page).to have_css "div.pagination"
        User.paginate(page: 1).each do |u|
          expect(page).to have_link u.name, href: user_path(u)
          expect(page).to have_content "#{u.name} | 削除" unless u == admin_user
        end
      end
    end

    context "管理者ユーザー以外の場合" do
      it "ぺージネーション、自分のアカウントのみ削除ボタンが表示されること" do
        create_list(:user, 30)
        login_for_system(user)
        visit users_path
        expect(page).to have_css "div.pagination"
        User.paginate(page: 1).each do |u|
          expect(page).to have_link u.name, href: user_path(u)
          if u == user
            expect(page).to have_content "#{u.name} | 削除"
          else
            expect(page).not_to have_content "#{u.name} | 削除"
          end
        end
      end
    end
  end

  describe "ユーザー登録ページ" do
    before do
      visit signup_path
    end

    context "ページレイアウト" do
      it "「ユーザー登録」の文字列が存在することを確認" do
        expect(page).to have_content 'ユーザー登録'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('ユーザー登録')
      end
    end

    context "ユーザー登録処理" do
      it "有効なユーザーでユーザー登録を行うとユーザー登録成功のフラッシュが表示されること" do
        fill_in "ユーザー名", with: "Example User"
        fill_in "メールアドレス", with: "user@example.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード(確認)", with: "password"
        click_button "登録する"
        expect(page).to have_content "music_snsへようこそ！"
      end

      it "無効なユーザーでユーザー登録を行うとユーザー登録失敗のフラッシュが表示されること" do
        fill_in "ユーザー名", with: ""
        fill_in "メールアドレス", with: "user@example.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード(確認)", with: "pass"
        click_button "登録する"
        expect(page).to have_content "ユーザー名を入力してください"
        expect(page).to have_content "パスワード(確認)とパスワードの入力が一致しません"
      end
    end
  end

  describe "プロフィール編集ページ" do
    before do
      login_for_system(user)
      visit edit_user_path(user)
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('プロフィール編集')
      end
    end

    context "アカウント削除処理", js: true do
      it "正しく削除できること" do
        click_link "アカウントを削除する"
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "自分のアカウントを削除しました"
      end
    end

    it "有効なプロフィール更新を行うと、更新成功のフラッシュが表示されること" do
      fill_in "ユーザー名", with: "Edit Example User"
      fill_in "メールアドレス", with: "edit-user@example.com"
      fill_in "自己紹介", with: "編集：初めまして"
      fill_in "性別", with: "編集：男性"
      click_button "更新する"
      expect(page).to have_content "プロフィールが更新されました！"
      expect(user.reload.name).to eq "Edit Example User"
      expect(user.reload.email).to eq "edit-user@example.com"
      expect(user.reload.introduction).to eq "編集：初めまして"
      expect(user.reload.sex).to eq "編集：男性"
    end

    it "無効なプロフィール更新をしようとすると、適切なエラーメッセージが表示されること" do
      fill_in "ユーザー名", with: ""
      fill_in "メールアドレス", with: ""
      click_button "更新する"
      expect(page).to have_content 'ユーザー名を入力してください'
      expect(page).to have_content 'メールアドレスを入力してください'
      expect(page).to have_content 'メールアドレスは不正な値です'
      expect(user.reload.email).not_to eq ""
    end
  end

  describe "プロフィールページ" do
    context "ページレイアウト" do
      before do
        login_for_system(user)
        create_list(:live_companion, 10, user: user)
        visit user_path(user)
      end

      it "「プロフィール」の文字列が存在することを確認" do
        expect(page).to have_content 'プロフィール'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('プロフィール')
      end

      it "ユーザー情報が表示されることを確認" do
        expect(page).to have_content user.name
        expect(page).to have_content user.introduction
        expect(page).to have_content user.sex
      end

      it "投稿の件数が表示されていることを確認" do
        expect(page).to have_content "ライブ同行者募集 (#{user.live_companions.count})"
      end

      it "投稿の情報が表示されていることを確認" do
        LiveCompanion.take(5).each do |live_companion|
          expect(page).to have_link live_companion.artist_name
          expect(page).to have_content live_companion.live_name
          expect(page).to have_content live_companion.live_memo
          expect(page).to have_content live_companion.user.name
        end
      end

      it "投稿のページネーションが表示されていることを確認" do
        expect(page).to have_css "div.pagination"
      end
    end

    context "ユーザーのフォロー/アンフォロー処理", js: true do
      it "ユーザーのフォロー/アンフォローができること" do
        login_for_system(user)
        visit user_path(other_user)
        expect(page).to have_button 'フォローする'
        click_button 'フォローする'
        expect(page).to have_button 'フォロー中'
        click_button 'フォロー中'
        expect(page).to have_button 'フォローする'
      end
    end

    context "気になる登録/解除" do
      before do
        login_for_system(user)
      end

      it "ライブ同行者募集投稿の気になる登録/解除ができること" do
        expect(user.favorite?(live_companion)).to be_falsey
        user.favorite(live_companion)
        expect(user.favorite?(live_companion)).to be_truthy
        user.unfavorite(live_companion)
        expect(user.favorite?(live_companion)).to be_falsey
      end

      it "トップページから気になる登録/解除ができること", js: true do
        visit root_path
        link = find('.like')
        expect(link[:href]).to include "/favorites/#{live_companion.id}/create"
        link.click
        link = find('.unlike')
        expect(link[:href]).to include "/favorites/#{live_companion.id}/destroy"
        link.click
        link = find('.like')
        expect(link[:href]).to include "/favorites/#{live_companion.id}/create"
      end

      it "ユーザー個別ページから気になる登録/解除ができること", js: true do
        visit user_path(user)
        link = find('.like')
        expect(link[:href]).to include "/favorites/#{live_companion.id}/create"
        link.click
        link = find('.unlike')
        expect(link[:href]).to include "/favorites/#{live_companion.id}/destroy"
        link.click
        link = find('.like')
        expect(link[:href]).to include "/favorites/#{live_companion.id}/create"
      end

      it "投稿個別ページから気になる登録/解除ができること", js: true do
        visit live_companion_path(live_companion)
        link = find('.like')
        expect(link[:href]).to include "/favorites/#{live_companion.id}/create"
        link.click
        link = find('.unlike')
        expect(link[:href]).to include "/favorites/#{live_companion.id}/destroy"
        link.click
        link = find('.like')
        expect(link[:href]).to include "/favorites/#{live_companion.id}/create"
      end

      it "気になる一覧ページが期待通り表示されること" do
        visit favorites_path
        expect(page).not_to have_css ".favorite-live_companion"
        user.favorite(live_companion)
        user.favorite(other_live_companion)
        visit favorites_path
        expect(page).to have_css ".favorite-live_companion", count: 2
        expect(page).to have_content live_companion.artist_name
        expect(page).to have_content live_companion.live_name
        expect(page).to have_content live_companion.live_memo
        expect(page).to have_content "投稿者 #{user.name}"
        expect(page).to have_link user.name, href: user_path(user)
        expect(page).to have_content live_companion.artist_name
        expect(page).to have_content live_companion.live_name
        expect(page).to have_content live_companion.live_memo
        expect(page).to have_content "投稿者 #{user.name}"
        expect(page).to have_link other_user.name, href: user_path(other_user)
        user.unfavorite(other_live_companion)
        visit favorites_path
        expect(page).to have_css ".favorite-live_companion", count: 1
        expect(page).to have_content live_companion.artist_name
        expect(page).to have_content live_companion.live_name
        expect(page).to have_content live_companion.live_memo
        expect(page).to have_content "投稿者 #{user.name}"
      end
    end

    context "通知生成" do
      before do
        login_for_system(user)
      end

      context "自分以外のユーザーの投稿に対して" do
        before do
          visit live_companion_path(other_live_companion)
        end

        it "気になる登録によって通知が作成されること" do
          find('.like').click
          visit live_companion_path(other_live_companion)
          expect(page).to have_css 'li.no_notification'
          logout
          login_for_system(other_user)
          expect(page).to have_css 'li.new_notification'
          visit notifications_path
          expect(page).to have_css 'li.no_notification'
          expect(page).to have_content "あなたの投稿が#{user.name}さんに気になる登録されました。"
          expect(page).to have_content other_live_companion.artist_name
          expect(page).to have_content other_live_companion.live_name
          expect(page).to have_content other_live_companion.live_memo
          expect(page).to have_content other_live_companion.created_at.strftime("%Y/%m/%d(%a) %H:%M")
        end

        it "コメントによって通知が作成されること" do
          fill_in "comment_content", with: "コメントしました"
          click_button "コメント"
          expect(page).to have_css 'li.no_notification'
          logout
          login_for_system(other_user)
          expect(page).to have_css 'li.new_notification'
          visit notifications_path
          expect(page).to have_css 'li.no_notification'
          expect(page).to have_content "あなたの投稿に#{user.name}さんがコメントしました。"
          expect(page).to have_content '「コメントしました」'
          expect(page).to have_content other_live_companion.artist_name
          expect(page).to have_content other_live_companion.live_name
          expect(page).to have_content other_live_companion.live_memo
          expect(page).to have_content other_live_companion.created_at.strftime("%Y/%m/%d(%a) %H:%M")
        end
      end

      context "自分の投稿に対して" do
        before do
          visit live_companion_path(live_companion)
        end

        it "気になる登録によって通知が作成されないこと" do
          find('.like').click
          visit live_companion_path(live_companion)
          expect(page).to have_css 'li.no_notification'
          visit notifications_path
          expect(page).not_to have_content '気になるに登録されました。'
          expect(page).not_to have_content live_companion.artist_name
          expect(page).not_to have_content live_companion.live_name
          expect(page).not_to have_content live_companion.live_memo
          expect(page).not_to have_content live_companion.created_at
        end

        it "コメントによって通知が作成されないこと" do
          fill_in "comment_content", with: "自分でコメント"
          click_button "コメント"
          expect(page).to have_css 'li.no_notification'
          visit notifications_path
          expect(page).not_to have_content 'コメントしました。'
          expect(page).not_to have_content '自分でコメント'
          expect(page).not_to have_content other_live_companion.artist_name
          expect(page).not_to have_content other_live_companion.live_name
          expect(page).not_to have_content other_live_companion.live_memo
          expect(page).not_to have_content other_live_companion.created_at
        end
      end
    end
  end

  context "リスト登録/解除" do
    before do
      login_for_system(user)
    end

    it "投稿のライブ予定リスト登録ができること" do
      user.live_list(live_companion)
      expect(user.live_list?(live_companion)).to be_truthy
    end

    it "投稿のライブ予定リスト解除ができること" do
      user.unlive_list(live_companion)
      expect(user.live_list?(live_companion)).to be_falsey
    end

    it "トップページからライブ予定リストの登録/解除ができること", js: true do
      visit root_path
      link = find('.live_list')
      expect(link[:href]).to include "/live_lists/#{live_companion.id}/create"
      link.click
      link = find('.unlive_list')
      expect(link[:href]).to include "/live_lists/#{LiveCompanion.second.id}/destroy"
      link.click
      link = find('.live_list')
      expect(link[:href]).to include "/live_lists/#{live_companion.id}/create"
    end

    it "ユーザー個別ページからライブ予定リストの登録ができること", js: true do
      visit user_path(user)
      link = find('.live_list')
      expect(link[:href]).to include "/live_lists/#{live_companion.id}/create"
      link.click
      link = find('.unlive_list')
      expect(link[:href]).to include "/live_lists/#{LiveCompanion.second.id}/destroy"
      link.click
      link = find('.live_list')
      expect(link[:href]).to include "/live_lists/#{live_companion.id}/create"
    end

    it "投稿個別ページからライブ予定リスト登録/解除ができること", js: true do
      link = find('.live_list')
      expect(link[:href]).to include "/live_lists/#{live_companion.id}/create"
      link.click
      link = find('.unlive_list')
      expect(link[:href]).to include "/live_lists/#{LiveCompanion.second.id}/destroy"
      link.click
      link = find('.live_list')
      expect(link[:href]).to include "/live_lists/#{live_companion.id}/create"
    end

    it "ライブ予定リスト一覧ページが期待通り表示され、ライブ予定リストから削除することもできること" do
      visit live_lists_path
      expect(page).not_to have_css ".live_list-live_companion"
      user.live_list(live_companion)
      live_companion_2 = create(:live_companion, user: user)
      other_user.live_list(live_companion_2)
      visit live_lists_path
      expect(page).to have_css ".live_list-live_companion", count: 2
      expect(page).to have_content live_companion.artist_name
      expect(page).to have_content live_companion.live_memo
      expect(page).to have_content LiveCompanion.last.created_at.strftime("%Y/%m/%d(%a) %H:%M")
      expect(page).to have_content "この投稿をライブ予定リストに追加しました。"
      expect(page).to have_content live_companion_2.artist_name
      expect(page).to have_content live_companion_2.live_memo
      expect(page).to have_content LiveCompanion.first.created_at.strftime("%Y/%m/%d(%a) %H:%M")
      expect(page).to have_content "#{other_user.name}さんがこのライブに一緒に行きたい！リクエストをしました。"
      expect(page).to have_link other_user.name, href: user_path(other_user)
      user.unlive_list(LiveCompanion.first)
      visit live_lists_path
      expect(page).to have_css ".live_list-live_companion", count: 1
      expect(page).to have_content live_companion.artist_name
      find('.unlive_list').click
      visit live_lists_path
      expect(page).not_to have_css ".live_list-live_companion"
    end
  end
end
