require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    alphabets = ('a'..'z').to_a
    @letters = 10.times.map do
      alphabets.sample
    end
  end
  # .chars will give an array of letter of the word
  # .all will give us true or false (boolean)
  def score
    if check_word == true && params[:word].chars.all?.match?(params[:letters])
      @score = "Congratulations! #{params[:word]} is a valid English word"
    elsif check_word == true
      @score = "Sorry but #{params[:word]} can't be build out of #{params[:letters]}"
    else
      @score = "Sorry but #{params[:word]} is not an English word"
    end
  end

  def check_word
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
    json = JSON.parse(response.read)
    json['found']
  end
end
