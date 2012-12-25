class AddMessageidToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :messageid, :string
  end
end
