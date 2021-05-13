# require '/home/toshi32/workspace/GroupWork/vending-copy.rb'
# vm = VendingMachine.new
# vm.slot_money(100)


class Drink
  attr_reader :name, :price

  def self.add_stocks(drink)
    if drink == "cola"
      self.new 120, :cola
    elsif drink == "redbull"
      self.new 200, :redbull
    elsif drink == "redbull"
      self.new 100, :water
    end
  end

  def self.cola
    self.new 120, :cola
  end

  def initialize price, name
    @name = name
    @price = price
  end
end

class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze

  def initialize
    @slot_money = 0
    @sold_amount = 0
    @drinks = []
    5.times do
      @drinks << Drink.cola
    end
    @drinks.each do |d|
      puts d.name
      puts d.price
    end
  end

  def add_stocks
    puts "在庫を増やしたい商品を選んで入力して下さい。やめる時は「stop」と入力して下さい。"
    puts ["cola", "redbull", "water"]
    add_drink = gets.chomp
    if add_drink == "cola" || add_drink == "redbull" || add_drink == "water"     #以下 水 までgetsの取得値を元にdrinkの配列を作成
      5.times do                                  #drinkを５個在庫に追加する
        @drinks << Drink.add_stocks(add_drink)
      end
      puts "#{add_drink} を5本追加しました。"
      @drinks.pop
      puts @drinksname
    elsif
      puts "在庫追加を取りやめました"
      return
    else
      puts "#{add_drink}は在庫にありませんでした。"
    end
  end

  def stock_status
    @drinks
  end

  def remove_stock(drink)
    @drinks.remove_instance_variable(:"#{drink}")
  end


  def slot_money(money)
    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    return puts "#{money}円のお釣りです。" unless MONEY.include?(money)
    # 自動販売機にお金を入れる
    @slot_money += money
    puts "#{money}円入金しました。"
  end

  def current_slot_money
    # 自動販売機に入っているお金を表示する
    puts "残金 : #{@slot_money}円"
  end

  def return_money
    slot_money = @slot_money
    # 返すお金の金額を表示する
    puts "おつり : #{slot_money}円"
    # 自動販売機に入っているお金を0円に戻す
    @slot_money = 0
  end
end

# drink_name = @buttons.find(|button| puts button[:name] == drink.name)

# def store(drink)
#   nil.tap do
#     @drink_table[drink.name] ={ price: drink.price,drinks: [] } unless @drink_table.has_key? drink.name
#     @drink_table[drink.name][:drinks] << drink
#   end
# end