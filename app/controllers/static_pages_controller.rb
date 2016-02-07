class StaticPagesController < ApplicationController
  def home
    @forums = Forum.all
  end

  def help
  end
  
  def about
  end
end
