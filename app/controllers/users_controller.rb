class UsersController < ApplicationController
  before_action :authenticate_user!
  if user_signed_in?
    #show the main page.
  end
end
