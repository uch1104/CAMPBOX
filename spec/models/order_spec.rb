require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'レンタル機能のテスト' do
    before do
      @item = FactoryBot.create(:item, start_date: '2020-12-12', limit_date: '2020-12-20')
      @order = FactoryBot.build(:order)
      @order.item_id = @item.id
    end

    context 'レンタルがうまくいくとき' do
      it '日付が正しく入力されていればレンタルできる' do
        expect(@order).to be_valid
      end
    end

    context 'レンタルがうまくいかないとき' do
      it 'レンタル開始日がレンタル可能期間内の日付でない場合はレンタルできない' do
        @order.rental_start_date = '2020-12-11'
        @order.valid?
        expect(@order.errors.full_messages).to include('レンタル開始日はレンタル可能期間内の日付を選択してください')
      end

      it 'レンタル終了日がレンタル開始日より前の日付ではレンタルできない' do
        @order.rental_limit_date = '2020-12-13'
        @order.valid?
        expect(@order.errors.full_messages).to include('レンタル終了日は開始日より後の日付を選択してください')
      end

      it 'レンタル終了日がレンタル可能期間内でない場合はレンタルできない' do
        @order.rental_limit_date = '2020-12-21'
        @order.valid?
        expect(@order.errors.full_messages).to include('レンタル終了日はレンタル可能期間内の日付を選択してください')
      end
    end
  end
end