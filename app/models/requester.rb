class Requester < ActiveRecord::Base
  has_many :tickets
  has_many :ticket_responses
  attr_accessible :email_address, :name, :organization_id

  def self.find_or_create(attributes)
    Requester.where(attributes).first || Requester.create(attributes)
  end

end
