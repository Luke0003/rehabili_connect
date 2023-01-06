module UserFullName
   # 氏名をフルネームで返す
  def full_name
    last_name + " " + first_name
  end

   # 氏名(カタカナ)をフルネームで返す
  def full_name_kana
    last_name_kana + " " + first_name_kana
  end
end