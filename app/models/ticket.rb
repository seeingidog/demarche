class Ticket < ActiveRecord::Base
  resourcify
  
  has_many :ticket_responses
  belongs_to :requester
  belongs_to :user
  attr_accessible :body, :requester_id, :subject, :messageid, :state
  
  validates_presence_of :requester_id, :messageid, :body
  validates_uniqueness_of :messageid
  
  before_validation :ensure_messageid
  after_create :send_initial
  
  state_machine :initial => :new do
    after_transition all => :closed, :do => :send_closed
    
    event :user_receive do
      transition :new => :answered
    end
    event :requester_receive do
      transition :answered => :need_response
    end
    event :close_ticket do
      transition all => :closed
    end

  end
  
  def send_initial
    TicketMailer.initial_response(self.requester, self).deliver
  end
  
  def send_closed
    TicketMailer.send_closed(self.requester, self).deliver
  end
  
  def ensure_messageid
    require 'digest'
    if self.messageid == nil
      self.messageid = Digest::SHA1.hexdigest(self.body+self.requester.email_address+Time.now.to_s)
    end
  end
      
  def self.import
    require 'digest'
    imap = Net::IMAP.new('ruby-code.com')
    imap.authenticate('LOGIN', 'support@ruby-code.com', 'Iemoo')
    imap.examine('INBOX')
    imap.search(["UNSEEN"]).each do |message_id|
      msg = imap.fetch(message_id, "(ENVELOPE BODY[TEXT])")[0]
      envelope = msg.attr["ENVELOPE"]
      body = msg.attr["BODY[TEXT]"]
      subject = envelope.subject
      name = envelope.from[0].name
      from_email = envelope.from[0].mailbox + '@' + envelope.from[0].host
      tn = envelope.to.select {|v| v.mailbox[0..3] == 'ian+'}
      if tn != []
        ticket_number = tn.first.mailbox.split('+').last
      end
      requester = Requester.find_or_create(:email_address => from_email, :name => name)
      messageid = envelope.message_id || Digest::SHA1.hexdigest(body+from_email+envelope.date)
      if Ticket.exists?(ticket_number)
        Ticket.find(ticket_number).requester_receive
        TicketResponse.create(:ticket_id => ticket_number, :body => body, :requester_id => requester.id, :messageid => messageid)
      else
        self.create(:subject => subject, :body => body, :requester_id => requester.id, :messageid => messageid)
      end
    end
    imap.logout
    imap.disconnect
  end
end
