# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
# FURIMADB設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false|
|password|string|null: false|
|name|string|null: false|
|name_kana|string|null: false|
|birthday|date|null: false|
### Association
- has_many :items
- has_many :orders
- has_one :pay
- has_one :address
# - has_many :likes
# - has_many :items, through: :likes
# - has_many :comments
# - has_many :items, through: :comments


## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foreign_key: true|
|prefecture_id|reference|null: false, foreign_key: true|
|destination_name|string|null: false|
|destination_name_kana|string|null: false|
|postal_code|int(7)|null: false|
|municipality|string|null: false|
|address|string|null: false|
|building_name|string||
|phone_number|int||
### Association
- belongs_to :user
- belongs_to_active_hash :prefecture



## paysテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foreign_key: true|
|card_number|int|null: false|
|exp_year|int|null: false|
|exp_month|int|null: false|
|security_number|int|null: false|
### Association
- belongs_to :user


## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foreign_key: true|
|category_id|reference|null: false, foreign_key: true|
|size_id|reference|null: false, foreign_key: true|
|brand_id|reference|null: false, foreign_key: true|
|prefecture_id|reference|null: false, foreign_key: true|
|condition_id|reference|null: false, foreign_key: true|
|shipping_moneys_id|reference|null: false, foreign_key: true|
|shipping_days_id|reference|null: false, foreign_key: true|
|name|string|null: false|
|price|int|null: false|
|explanation|text|null: false|
|sold_day|date|null: false|
### Association
- belongs_to :user
- belongs_to :category
- belongs_to :size
- belongs_to :brand
- belongs_to :condition
- belongs_to :shipping_moneys
- belongs_to :shipping_days
- has_many :images
- has_one :order
- belongs_to_active_hash :prefecture
## - has_many :likes
## - has_many :users, through: :likes
## - has_many :comments
## - has_many :users, through: :comments

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|category|string|null: false|
### Association
- has_many :items

## sizesテーブル
|Column|Type|Options|
|------|----|-------|
|size|string|null: false|
### Association
- has_many :items

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|brand|string|null: false|
### Association
- has_many :items

## conditionsテーブル
|Column|Type|Options|
|------|----|-------|
|condition|string|null: false|
### Association
- has_many :items

## shipping_moneysテーブル
|Column|Type|Options|
|------|----|-------|
|shipping_money|string|null: false|
### Association
- has_many :items

## shipping_daysテーブル
|Column|Type|Options|
|------|----|-------|
|shipping_day|string|null: false|
### Association
- has_many :items


## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item_id|reference|null: false, foreign_key: true|
### Association
- belongs_to :item

## ordersテーブル
|Column|Type|Options|
|------|----|-------|
|item_id|reference|null: false, foreign_key: true|
|prefecture_id|reference|null: false, foreign_key: true|
|buyer|reference|null: false, foreign_key: true|
|seller|reference|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item
- belongs_to :prefecture
- belongs_to_active_hash :prefecture
