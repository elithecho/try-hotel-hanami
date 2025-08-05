# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :hotels do
      primary_key :id

      column :pub_id, String, null: false
      column :destination_id, Integer, null: false

      column :name, String, null: false

      column :description, String, null: false
      column :location_data, "text", null: false
      column :image_data, "text"

      column :created_at, DateTime, default: Sequel::CURRENT_TIMESTAMP
      column :updated_at, DateTime, default: Sequel::CURRENT_TIMESTAMP

      index :pub_id, unique: true
      index :destination_id, unique: false
    end
  end
end
