class StaticPagesController < ApplicationController
  def home
    @forums = Forum.all
    @user = User.all
  end

  def help
  end
  
  def about
  end
end
