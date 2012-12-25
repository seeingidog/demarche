class CreateTicketResponses < ActiveRecord::Migration
  def change
    create_table :ticket_responses do |t|
      t.text :body
      t.integer :requester_id
      t.integer :user_id
      t.integer :ticket_id

      t.timestamps
    end
  end
end
