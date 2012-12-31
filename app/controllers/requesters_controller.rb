class RequestersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @requesters = Requester.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tickets }
    end
  end
  
end
