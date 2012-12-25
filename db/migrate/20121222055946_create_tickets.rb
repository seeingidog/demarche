class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :subject
      t.text :body
      t.integer :requester_id

      t.timestamps
    end
  end
end
