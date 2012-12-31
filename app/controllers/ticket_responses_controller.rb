class TicketResponsesController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @ticketresponse = TicketResponse.new(params[:ticket_response])
    @ticketresponse.user_id = current_user.id
    
    respond_to do |format|
      if @ticketresponse.save
        format.html { redirect_to @ticketresponse.ticket, notice: 'Response was sent.' }
        format.json { render json: @ticketresponse, status: :created, location: @ticket }
      else
        format.html { redirect_to @ticketresponse.ticket, notice: 'Error sending response.'  }
        format.json { render json: @ticketresponse.errors, status: :unprocessable_entity }
      end
    end
  end
  
end
