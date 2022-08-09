# frozen_string_literal: true

class HomeController < ApplicationController
  def index
  end

  def plants
  end

  def people
    @users= User.order(username: :asc).with_attached_avatar
  end
end
