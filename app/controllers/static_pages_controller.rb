class StaticPagesController < ApplicationController
  def home
    @random_number = 1+rand(10)
  end

  def help
  end

  def about
  end

  def contact
  end
end
