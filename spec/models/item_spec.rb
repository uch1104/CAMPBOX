require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'キャンプ用品出品機能のテスト' do
    before do
      @item = FactoryBot.build(:item)
    end

    context 'キャンプ用品の出品がうまくいくとき' do
      it '全ての項目が入力されていれば出品できる' do
        expect(@item).to be_valid
      end

      it '注意事項を入力しなくても出品できる' do
        @item.precaution = nil
        @item.valid?
        expect(@item).to be_valid
      end
    end

    context 'キャンプ用品の出品がうまくいかないとき' do
      it '品名がない場合は出品できない' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('品名を入力してください')
      end

      it '説明がない場合は出品できない' do
        @item.description = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('説明を入力してください')
      end

      it '状態を選択しない場合は出品できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('状態を選択してください')
      end

      it '発送元の地域を選択しない場合は出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域を選択してください')
      end

      it '配送方法を選択しない場合は出品できない' do
        @item.shipping_method_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('配送方法を選択してください')
      end

      it '配送料の負担を選択しない場合は出品できない' do
        @item.cost_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を選択してください')
      end

      it 'レンタル期間(開始日)が今日より前の場合は出品できない' do
        @item.start_date = Faker::Date.between(from: 10.days.ago, to: Date.today)
        @item.valid?
        expect(@item.errors.full_messages).to include('レンタル期間(開始日)は明日以降の日付を選択してください')
      end

      it 'レンタル期間(終了日)がレンタル期間(開始日)より前の場合は出品できない' do
        @item.start_date = '2020-11-11'
        @item.limit_date = '2020-11-10'
        @item.valid?
        expect(@item.errors.full_messages).to include('レンタル期間(終了日)は開始日より後の日付を選択してください')
      end

      it '価格が入力されていない場合は出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('価格を入力してください')
      end

      it '価格が¥500以下の場合は出品できない' do
        @item.price = 200
        @item.valid?
        expect(@item.errors.full_messages).to include('価格に正しい値を入力してください')
      end

      it '価格が¥100,000以上では出品できない' do
        @item.price = 100_100
        @item.valid?
        expect(@item.errors.full_messages).to include('価格に正しい値を入力してください')
      end

      it '価格が半角数字ではない場合は出品できない' do
        @item.price = '５０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格に正しい値を入力してください')
      end

      it '写真がない場合は出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('写真を入力してください')
      end
    end
  end
end