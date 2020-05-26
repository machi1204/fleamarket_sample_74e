require 'rails_helper'

describe User do
  describe '#create' do
    # 1. ユーザー登録の必須項目（nickname,email,password,password_confirmation,first_name,first_name_kana,last_name,last_name_kana,birthdate_year,birthdate_month,birthdate_day）が存在すれば 登録できること
    it "is valid with a nickname, email, password, password_confirmation" do
      user = build(:user)
      expect(user).to be_valid
    end

    # 2. nicknameが空では登録できないこと
    it "is invalid without a nickname" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    # 3. emailが空では登録できないこと
    it "is invalid without a email" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    # 4. first_nameが空、漢字ひらがな以外では登録できないこと
    it "is invalid without a first_name" do
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("を入力してください", "は漢字、ひらがなで入力してください。")
    end

    # 5. last_nameが空、漢字ひらがな以外では登録できないこと
    it "is invalid without a last_name" do
      user = build(:user, last_name: nil)
      user.valid?
      expect(user.errors[:last_name]).to include("を入力してください", "は漢字、ひらがなで入力してください。")
    end

    # 6. birthdate_yearが空では登録できないこと
    it "is invalid without a birthdate_year" do
      user = build(:user, birthdate_year: nil)
      user.valid?
      expect(user.errors[:birthdate_year]).to include("を選択してくださいしてください。")
    end

    # 7. birthdate_monthが空では登録できないこと
    it "is invalid without a birthdate_month" do
      user = build(:user, birthdate_month: nil)
      user.valid?
      expect(user.errors[:birthdate_month]).to include("を選択してくださいしてください。")
    end

    # 8. birthdate_dayが空では登録できないこと
    it "is invalid without a birthdate_day" do
      user = build(:user, birthdate_day: nil)
      user.valid?
      expect(user.errors[:birthdate_day]).to include("を選択してくださいしてください。")
    end

    # 9. last_name_kanaが空では登録できないこと
    it "is invalid without a last_name_kana" do
      user = build(:user, last_name_kana: nil)
      user.valid?
      expect(user.errors[:last_name_kana]).to include("を入力してください")
    end

    # 10. first_name_kanaが空では登録できないこと
    it "is invalid without a first_name_kana" do
      user = build(:user, first_name_kana: nil)
      user.valid?
      expect(user.errors[:first_name_kana]).to include("を入力してください")
    end

    # 11. passwordが空の場合n英数字以外では登録できないこと
    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください", "は英数字で入力してください。")
    end

    # 12. passwordが存在してもpassword_confirmationが空では登録できないこと
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    # 13. 重複したemailが存在する場合登録できないこと
    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    # 14. emailのフォーマットを検証
      it "Correct format" do
        user = build(:user, email: 'kkk')
        user.valid?
        expect(user.errors[:email]).to include("は不正な値です", "の後に@,ドメインを含ませてください")
      end
      

    # 15. passwordが7文字以上であれば登録できること
    it "is valid with a password that has more than 7 characters " do
      user = build(:user, password: "0000000", password_confirmation: "0000000")
      user.valid?
      expect(user).to be_valid
    end

    # 16. passwordが6文字以下であれば登録できないこと
    it "is invalid with a password that has less than 6 characters " do
      user = build(:user, password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end
  end

    # 17. passwordが16文字以上であれば登録できないこと
  it "is valid with a password that has more than 15 characters " do
    user = build(:user, password: "0000000000000000", password_confirmation: "0000000000000000")
    user.valid?
    expect(user.errors[:password]).to include("は15文字以内で入力してください")
  end

  # 18. last_name_kanaがカタカナでないと登録できないこと
  describe '#katakana' do
    it 'last_name_kanaがカタカナで返ること' do
      user = build(:user, last_name_kana: "kana")
      user.valid?
      expect(user.errors[:last_name_kana]).to include("はカナで入力してください。")
    end

    # 19. first_name_kanaがカタカナでないと登録できないこと    
    it 'first_name_kanaがカタカナで返ること' do
      user = build(:user, first_name_kana: "kana")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("はカナで入力してください。")
    end
  end
end