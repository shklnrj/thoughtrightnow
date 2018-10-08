class AuthenticatedController < ApplicationController
  def home
  end

  def suggested_follows
    @users = User.all    
  end
end
