require 'rubygems'
require File.expand_path('./config/environment')

require 'clockwork'
include Clockwork
 
handler do |job|
  CheckMailWorker.perform_async
end
 
every(1.minute, 'CheckMailWorker')