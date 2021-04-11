# require './work/sample.rb'
# （↑のパスは、自動販売機ファイルが入っているパスを指定する）
# 初期設定（自動販売機インスタンスを作成して、vmという変数に代入する）
# vm = VendingMachine.new
# 作成した自動販売機に100円を入れる
# vm.slot_money (100)
# 作成した自動販売機に入れたお金がいくらかを確認する（表示する)
# vm.current_slot_money
# 作成した自動販売機に入れたお金を返してもらう
# vm.return_money
class VendingMachine
  # ステップ０ お金の投入と払い戻しの例コード
  # ステップ１ 扱えないお金の例コード
  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  MONEY = [10, 50, 100, 500, 1000].freeze
  # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する)
  def initialize
    # 最初の自動販売機に入っている金額は0円
    @slot_money = 0
        #最初の在庫としてインスタンス変数@drinkにコーラを５個持たせる
    @drinks = []
    5.times do
      @drinks << ["コーラ", 120]
    end
  end
  # 投入金額の総計を取得できる。
  def current_slot_money
    # 自動販売機に入っているお金を表示する
    @slot_money
  end
  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  def slot_money(money)
    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    return false unless MONEY.include?(money)
    # 自動販売機にお金を入れる
    @slot_money += money
  end

  def can_buy_list    #買えるものをリストに選別し、購入する意思があれば stock_adjust メソッドを呼び出す
    drinks = @drinks      #drinks << [["コーラ", 120], ["コーラ", 120], ["コーラ", 120], ["コーラ", 120], ["コーラ", 120]]
    drink_kind = drinks.uniq    #重複する値の排除    drink_kind = [["コーラ", 120]]
    can_buy_drinks = []
    drink_kind.each do |d|    #drink_kindの値をそれぞれ個別に処理する
      i = 0                   #can_buy_drinks用のインデックス番号作成
      if d[1].to_i < @slot_money   #drink_kindの値がそれぞれ投入金額より高ければ、下の処理でcan_buy_drinkに追加する
        can_buy_drinks << ["#{i}", "#{d[0]}", "#{d[1]}円"]
        i += 1        #can_buy_drinksに飲み物を加えるたびにインデックス番号を１つずつ増やす
      end
      can_buy_drinks << ["#{i}", "購入しない"]  #can_buy_drinksの最後行に、購入しない選択肢を追加
    end
    while true
      if can_buy_drinks[1]    #can_buy_drinksに値が2つ以上あれば、購入ステップへ移行する。最後行に購入しない選択肢を追加している為、購入できる飲み物が０種類であれば値は１つになる。
        puts "購入したい飲み物の数字を選んでください。"
        can_buy_drinks.each do |d|    #購入可能な飲み物リストを１行ずつ表示
          print d
          puts "\n"                   #1行ずつ改行を入れる
        end
        confirm_buy = gets    #購入する飲み物のインデックス番号で入力してもらう
        if confirm_buy =~ /^[0-9]+$/ #文字列の0~9にマッチする場合のみ処理を続ける。=~で右辺左辺の一致を確認。 ^は直後の文字が行の先頭にあるのを確認。$は直前の文字が行の末尾にあるのを確認。つまり、数字以外の入力を排除しているということ。ジャンケンゲームの課題より引用。
          if confirm_buy != can_buy_drinks.last[0]    #入力した値がcan_buy_drinksの最後のレコード「購入しない」のインデックス番号でなければ処理を続ける。
            confirm_buy = confirm_buy.to_i         #can_buy_drinksのインデックス番号を文字列で管理している為、文字列から数字に変換し、配列のインデックス番号として下の行で使用。
            can_buy_drinks[confirm_buy][2] = can_buy_drinks[confirm_buy][2].delete("円").to_i   #can_buy_drinks["#{i}", "#{d[0]}", "#{d[1]}円"]内の "#{d[1]}円" を価格のみにして数値に変更
            argument = [can_buy_drinks[confirm_buy][1], can_buy_drinks[confirm_buy][2]]    #can_buy_drinksの記述方法をdrinksに戻す。["#{i}", "#{d[0]}", "{d[1].to_i}"] => ["コーラ", 120]
            p argument
            stock_adjust(argument)   #在庫数管理のメソッドを呼び出し、引数に在庫を減らしたい配列を渡す。["コーラ", 120]
            return
          else
            puts "入力した値が飲み物の番号と一致しませんでした"
          end
        else
          puts "数字で番号を入力してください"
        end
      else
        puts "購入できる飲み物がありませんでした。"
        break
      end
    end
  end

  def stock_adjust(drink_kinds_index)
    drinks = @drinks  #drinks << [["コーラ", 120], ["コーラ", 120], ["コーラ", 120], ["コーラ", 120], ["コーラ", 120]]
    i = 0              #drinksのインデックス番号を扱う変数
    drinks.each do |d|  #drinksの各値を引数と比較していく
      if d == drink_kinds_index   # ["コーラ", 120] と drink_kinds_index が同じか？
        drinks.delete_at i        # 同じであればdrinksのインデックス番号 i を削除する
        p drinks
        return
      end
    i += 1
    end
  end

  def status      #drinkの名前、価格、本数をそれぞれ出力する
    drinks = @drinks        #drinks << [["コーラ", 120], ["コーラ", 120], ["コーラ", 120], ["コーラ", 120], ["コーラ", 120]]
    drink_kind = drinks.uniq  #重複する値の排除    drink_kind = [["コーラ", 120]]                      itself = 自分自身
    stocks = drinks.group_by(&:itself).map do |key, value|  #値ごとにまとめてグループ化  drinks.group_by(&:itself) => {["コーラ", 120]: [["コーラ", 120], ["コーラ", 120], ["コーラ", 120], ["コーラ", 120]}
                                                            #     .map do |key, value|  =>                             key       :               value   5個
      "#{value.count}"                                      #     stocks = 5 [5]
    end
    i = 0                     #drink_kindの配列に、drinkが複数ある場合のインデックス番号
    drink_kind.each do |d|    #drinkの名前、価格、本数をそれぞれ出力する
      puts "ジュース名: #{d[0]}, 価格: #{d[1]}円, 在庫: #{stocks[i]}本"
      i += 1
    end
  end

  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
  def return_money
    # 返すお金の金額を表示する
    puts @slot_money
    # 自動販売機に入っているお金を0円に戻す
    @slot_money = 0
  end
end
