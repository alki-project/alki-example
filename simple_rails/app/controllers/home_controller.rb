class HomeController < ApplicationController
  def show
    @msg = home_message
  end
end
