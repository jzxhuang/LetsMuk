class CreateIdMappings < ActiveRecord::Migration[6.0]
  def change
    create_table :id_mappings do |t|
      t.string :agora_uid, null: false
      t.string :google_uid, null: false

      t.timestamps
    end
  end
end
