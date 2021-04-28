# require './GroupWork/vending_machine.rb'
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
