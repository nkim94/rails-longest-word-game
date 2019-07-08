require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('A'..'Z').to_a[rand(26)] }
    @start_time = Time.now
  end

  def score
    # byebug
    end_time = Time.now
    @start_time = Time.parse(params[:start_time])
    @attempt = params[:new]
    url = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
    json = URI.open(url).read
    word_list = JSON.parse(json)
    if (@attempt.upcase.split('') - params[:letters].split(' ')).empty?
      p word_list['found']
      if word_list['found'] == true
        total_score = @attempt.length / (end_time - @start_time)
        @result = "<strong>Congratulations!<strong> #{@attempt} is a valid english word! Your score is #{total_score}"
        # @result = { time: end_time - @start_time, score: total_score, message: 'well done' }
      else
        @result = "Sorry but <strong>#{@attempt}</strong> is not a valid english word..."
      end
    else
      @result = "Sorry but <strong>#{@attempt}</strong> can't be built out of #{params[:letters]}"
    end
    @result
  end
end
