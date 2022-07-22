class WelcomeController < ApplicationController
  def index 
    @temperatures = Temperature.all
  end
end
