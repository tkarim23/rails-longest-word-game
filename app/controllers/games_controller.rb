require 'rest-client'

class GamesController < ApplicationController
  def new
    @letter = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    if params[:ask_score].chars.all? { |letter| params[:ask_score].count(letter) <= params[:words].downcase.count(letter) }
      if english_word?(params[:ask_score])
        @word = "doctor"
      else
        @word = "miel"
      end
    else
      @word = "not in grid"
    end
  end
  def english_word?(word)
    response = RestClient.get("https://wagon-dictionary.herokuapp.com/#{word}")
    # response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.body)

    return json['found']
  end
end
