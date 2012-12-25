class CheckMailWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"
  # sidekiq_options retry: false
  
  def perform
    Ticket.import
  end
  
end
