desc "This task is called by the Heroku scheduler add-on"
task :ticket_import => :environment do
  puts "Fetching email..."
  Ticket.import
  puts "done."
end
