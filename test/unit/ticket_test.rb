require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  
  test "should not save ticket without requester" do
    post = Ticket.new
    assert !post.save
  end
  
  test "should save ticket with requester and body" do
    post = Ticket.new(:requester_id => 1, :body => 'test')
    assert post.save
  end
  
  
  
end
