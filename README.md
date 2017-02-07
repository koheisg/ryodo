<<<<<<< HEAD
# Ryodo

Ryodoは、 ~~ 投稿後にgithub pagesにコミットしてくれる ~~ Railsブログアプリケーションです。

## ライセンス

MITライセンス（予定）

## 使い方

このアプリケーションを動かす場合は、まずはリポジトリを手元にクローンしてください。
次に、次のコマンドで必要になる Ruby Gems をインストールします。

```
$ bundle install --without production
```

その後、データベースへのマイグレーションを実行します。

```
$ rails db:migrate
```

最後に、テストを実行してうまく動いているかどうか確認してください。

```
$ rails test
```

テストが無事に通ったら、Railsサーバーを立ち上げる準備が整っているはずです。

```
$ rails server
```
=======
# ryodo

Ryodo is deploy tool for static page.
>>>>>>> origin/master
