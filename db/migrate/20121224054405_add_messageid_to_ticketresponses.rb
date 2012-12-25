class AddMessageidToTicketresponses < ActiveRecord::Migration
  def change
    add_column :ticket_responses, :messageid, :string
  end
end
