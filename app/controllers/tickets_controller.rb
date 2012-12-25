class TicketsController < ApplicationController
  before_filter :authenticate_user!
  
  def close
    @ticket = Ticket.find(params[:id])
    @ticket.close_ticket
    
    respond_to do |format|
      format.html { redirect_to @ticket, notice: 'Ticket was closed.' }
      format.json { render json: @ticket }
    end
  end
  
  def index
    @tickets = Ticket.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tickets }
    end
  end

  def show
    @ticket = Ticket.find(params[:id])
    @ticket_responses = @ticket.ticket_responses
    @ticket_response = TicketResponse.new
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ticket }
    end
  end

  def new
    @ticket = Ticket.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ticket }
    end
  end

  def create
    @ticket = Ticket.new(params[:ticket])
    @ticket.user_id = current_user.id

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render json: @ticket, status: :created, location: @ticket }
      else
        format.html { render action: "new" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to tickets_url }
      format.json { head :no_content }
    end
  end
end
