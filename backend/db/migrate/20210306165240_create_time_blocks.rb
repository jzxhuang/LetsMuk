class CreateTimeBlocks < ActiveRecord::Migration[6.0]
  def change
    create_table :time_blocks do |t|
      t.datetime :start, null: false
      t.datetime :end, null: false
      t.string :title, null: false
      t.string :user_id, null: false
      t.string :status, default: 'scheduled'

      t.timestamps
    end
  end
end
