class StaticsController < ActionController::Base

  require 'typhoeus'
  require 'date'

  def index
    initial_date = Date.new(2009, 8, 7)
    final_date = Date.new(2011, 11, 17)

    hydra = Typhoeus::Hydra.new(max_concurrency: 5)

    i = 0
    requests = (initial_date .. final_date).map { |date|

      url = "http://api.fixer.io/#{date}?base=USD&symbols=BRL";
      request = Typhoeus::Request.new(url, followlocation: true)

      hydra.queue(request)

      puts date

      date, request
    }

    hydra.run

    requests.each do |date, request|
      puts request.response.body
      puts date
    end

    @exchange_rate = 27071997

    puts hydra

    # TODO mudar pra redirecionar pra outra página
    rescue SocketError
      @error = 'ERROR: No internet connection available'
  end

end
