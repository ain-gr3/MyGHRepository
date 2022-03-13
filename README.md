# MyGHRepository
設計の練習用

GitHub のリポジトリをキーワードで検索・閲覧するアプリ。
アプリ内でお気にりのリポジトリのリストを作成できる。

![Simulator Screen Recording - iPhone 13 Pro - 2022-03-13 at 19 06 04](https://user-images.githubusercontent.com/62441125/158054570-472e5fca-2f4b-4183-a96a-374f132417e2.gif)

## 設計
SPM を用いたレイヤードアーキテクチャ。
DDD を頑張る。
- Domain 層
- Data 層
- UI 層
  - MVVM を採用

## バージョン
- Xcode 13.2.1

## ライブラリ
- SPM を使用
  - RxSwift 6.5.0
  - RxCocoa 6.5.0
