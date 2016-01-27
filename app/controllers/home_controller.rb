class HomeController < ApplicationController
  def index
    @vars = ENV
  end
end
