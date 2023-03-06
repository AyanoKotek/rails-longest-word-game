require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(9)
  end

  def score
    # The word is valid according to the grid and is an English word
    if include? && word?
      @message = "Congratulations! #{params[:answer]} is a valid English word!"
    elsif include? && word? == false
      @message = "Sorry but  #{params[:answer]} does not seem to be a valid English word..."
    elsif word? && include? == false
      @message = "Sorry but  #{params[:answer]} can't be built out of #{params[:letters]}"
    end
  end

  private

  def include?
    params[:answer].chars.all? { |letter| params[:letters].include? letter}
  end

  # The word is valid according to the grid, but is not a valid English word
  def word?
    url = "https://wagon-dictionary.herokuapp.com/#{params[:answer]}"
    word = JSON.parse(URI.open(url).read)
    word["found"]
  end
  end
