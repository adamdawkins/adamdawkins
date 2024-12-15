class AdamController < ApplicationController
  # GET /adam/new
  def new
  end

  # POST /adam
  def create
    if params[:password] == Rails.application.credentials.password
      session[:adam] = true
      redirect_to root_url
    else
      render :new, status: :unauthorized
    end
  end
end
