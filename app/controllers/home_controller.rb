class HomeController < ApplicationController
  def index
  end

  def message
    # if there is no message redirect to root
    redirect_to root_url unless flash[:notice]
  end
end
