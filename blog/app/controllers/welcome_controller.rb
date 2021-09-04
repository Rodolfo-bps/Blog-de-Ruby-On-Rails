class WelcomeController < ApplicationController
  
  before_action :authenticate_admin!, only: [:dashboard]
  
  def index
  end

  def dashboard
    @articles = Article.all
  end

  def about_me
  end
end
