class TicketResponseMailer < ActionMailer::Base

  def response(body, requester, ticket, user)
    @user = user
    @body = body
    @ticket = ticket
    mail(:from => "support+#{ticket.id}@ruby-code.com", :to => requester.email_address, :subject => "[Ticket ##{ticket.id}] #{ticket.subject}")
  end

end
