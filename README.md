## 概要
「CAMP BOX」はキャンプ用品のシェアリングサービスです。

使用していないキャンプ用品を貸すことや、使ってみたいキャンプ用品を借りることができます。

## URL
http://campbox.site/

ゲストユーザーとしてログインすることができます。

## アプリを開発した背景

私はキャンプが好きでよくキャンプに行くのですが、キャンプ用品は高くて気軽に買えないことが多いです。

それにキャンプ用品は高額な割に使っていない期間の方が長く、もったいないと思っていました。

そこで、使っていない期間にキャンプ用品を貸すことができるアプリケーションがあればいいなと思い、「CAMP BOX」を開発しました。

このアプリケーションを使用することで、あまりキャンプに行かない人は安くキャンプに行くことができ、高額なキャンプ用品を買いたい人は、買うハードルが下がると思います。

もっと気軽にみんながキャンプに行けるようになれるサービスを目指しています。

## アプリを使うことでのメリット

【キャンプ用品を貸したい人】
* 使っていないキャンプ用品を貸すことで、利益を出せる。
* キャンプ用品を買うときに貸すという選択肢が増えるため、買うハードルが下がる。

【キャンプ用品を借りたい人】
* あまり行かない人は借りることで、安くキャンプに行ける。
* 欲しいキャンプ用品を一度試しに使ってみることができる。

## 機能一覧

* ユーザー管理機能
* キャンプ用品登録機能
* タグ付機能
* ページネーション機能
* クレジットカードでの支払い機能
* 検索機能
* いいね機能
* 通知機能
* ダイレクトメッセージ機能
* レスポンシブデザイン


## 環境・使用技術

* マークアップ：html、CSS
* フロントエンド：JavaScript
* バックエンド：Ruby（Ruby on Rails）
    * テスト：RSpec
    * 静的コード解析：Rubocop
* データベース：MySQL
* インフラ：AWS（VPC | ALB | EC2 | S3 | Route53 | ACM）
* ソースコード管理：GitHub
* Webサーバ：Nginx
* アプリケーションサーバ：Unicorn

# データベース設計

[![Image from Gyazo](https://i.gyazo.com/90455321bdc2c1d87edc9fb541975326.png)](https://gyazo.com/90455321bdc2c1d87edc9fb541975326)

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| family_name        | string | null: false |
| first_name         | string | null: false |
| family_name_kana   | string | null: false |
| first_name_kana    | string | null: false |
| birth_date         | date   | null: false |

### Association

- has_many :items
- has_many :orders
- has_many :comments

## items テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| name             | string     | null: false                    |
| price            | integer    | null: false                    |
| description      | text       | null: false                    |
| precaution       | text       | null: false                    |
| rental_limit_id  | integer    | null: false                    |
| condition_id     | integer    | null: false                    |
| cost_id          | integer    | null: false                    |
| prefecture_id    | integer    | null: false                    |
| delivery_time_id | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :orders
- has_many :comments
- has_many :item_tag_relations
- has_many :tags, through: :item_tag_relations

## orders テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| item      | references | null: false, foreign_key: true |
| user      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| post_code     | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| house_number  | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | string     | null: false                    |
| order         | references | null: false, foreign_key: true |

### Association

- belongs_to :order

## comments テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| text      | text       | null: false                    |
| item      | references | null: false, foreign_key: true |
| user      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## tags テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| tag_name  | string     | null: false, uniqueness: true  |

### Association

- has_many :item_tag_relations
- has_many :items, through: :item_tag_relations

## item_tag_relations テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| item      | references | null: false, foreign_key: true |
| tag       | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :tag