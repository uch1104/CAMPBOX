require 'rails_helper'

RSpec.describe Address, type: :model do
  describe '住所登録のテスト' do
    before do
      @address = FactoryBot.build(:address)
    end

    context '登録できるとき' do
      it '全ての項目が入力されていれば登録できる' do
        expect(@address).to be_valid
      end

      it '建物名は空でも登録できる' do
        @address.building_name = nil
        expect(@address).to be_valid
      end
    end

    context '登録できないとき' do
      it '郵便番号がない場合は登録できない' do
        @address.post_code = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("郵便番号を入力してください")
      end

      it '郵便番号が半角のハイフンを含んだ正しい形式でないと登録できない' do
        @address.post_code = '1234567'
        @address.valid?
        expect(@address.errors.full_messages).to include('郵便番号は不正な値です')
      end

      it '都道府県を選択していないと登録できない' do
        @address.prefecture_id = '1'
        @address.valid?
        expect(@address.errors.full_messages).to include('都道府県を選択してください')
      end

      it '市区町村がない場合は登録できない' do
        @address.city = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("市区町村を入力してください")
      end

      it '番地がない場合は登録できない' do
        @address.house_number = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("番地を入力してください")
      end

      it '電話番号がない場合は登録できない' do
        @address.phone_number = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("電話番号を入力してください")
      end

      it '電話番号が全角数字だと登録できない' do
        @address.phone_number = '０９０１２３４５６７８'
        @address.valid?
        expect(@address.errors.full_messages).to include('電話番号は不正な値です')
      end

      it '電話番号にハイフンがあると登録できない' do
        @address.phone_number = '090-1234-5678'
        @address.valid?
        expect(@address.errors.full_messages).to include('電話番号は不正な値です')
      end

      it '電話番号が12桁以上だと登録できない' do
        @address.phone_number = '090123456789'
        @address.valid?
        expect(@address.errors.full_messages).to include('電話番号は不正な値です')
      end
    end
  end
end