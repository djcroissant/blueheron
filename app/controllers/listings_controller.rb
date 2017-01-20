class ListingsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user

  def new
    @listing = Listing.new
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def create
  end

  def edit
  end

  def update
  end

  def index
  end

  def destroy
  end
end
