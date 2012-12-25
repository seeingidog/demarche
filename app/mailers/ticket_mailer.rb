class TicketMailer < ActionMailer::Base
  
  def initial_response(requester, ticket)
    @ticket = ticket
    mail(:from => "support+#{ticket.id}@ruby-code.com", :to => requester.email_address, :subject => "[Ticket ##{ticket.id} opened] #{ticket.subject}")
  end
  
  def send_closed(requester, ticket)
    @ticket = ticket
    mail(:from => "support+#{ticket.id}@ruby-code.com", :to => requester.email_address, :subject => "[Ticket ##{ticket.id} closed] #{ticket.subject}")
  end
  

end
