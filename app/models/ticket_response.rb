class TicketResponse < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
  belongs_to :requester
  
  attr_accessible :body, :requester_id, :ticket_id, :user_id, :messageid
  
  validates_uniqueness_of :messageid
  validates_presence_of :body
  
  before_validation :ensure_messageid
  after_save :send_response
  
  def ensure_messageid
    require 'digest'
    if self.messageid == nil
      self.messageid = Digest::SHA1.hexdigest(self.body+self.user.email+Time.now.to_s)
    end
  end
  
  def send_response
    if self.user
      self.ticket.user_receive
      TicketResponseMailer.response(self.body, self.requester, self.ticket, self.user).deliver
    end
  end
  
end
