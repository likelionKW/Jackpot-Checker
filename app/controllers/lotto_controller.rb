require 'open-uri'
require 'json'
require 'awesome_print'

class LottoController < ApplicationController
  def index
  end

  def pick_and_check
    lotto = JSON.parse(open('http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=').read)
    drw_numbers = [lotto["drwtNo1"], lotto["drwtNo2"], lotto["drwtNo3"], lotto["drwtNo4"], lotto["drwtNo5"], lotto["drwtNo6"]]
    bonus_number = lotto["bnusNo"]

    my_numbers = [*1..45].sample(6).sort

    match_numbers = []
    for number in drw_numbers
      if my_numbers.include? number
        match_numbers.push(number)
      end
    end

    if match_numbers.count == 6
      grade = 1
    elsif match_numbers.count == 5
      if bonus_number.include? my_numbers
        grade = 2
      else
        grade = 3
      end
    elsif match_numbers.count == 4
      grade = 4
    elsif match_numbers.count == 5
      grade = 3
    else
      grade = 0
    end

    @my_numbers = my_numbers
    @drw_numbers = drw_numbers
    @bonus_number = bonus_number
    @match_numbers = match_numbers
    @grade = grade
  end
end
