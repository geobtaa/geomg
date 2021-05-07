# frozen_string_literal: true

# UsersController
class UsersController < ApplicationController
  def index
    @users = User.all
  end
end
