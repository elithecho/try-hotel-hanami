# frozen_string_literal: true

ROM::SQL.migration do
  # Add your migration here.
  #
  # See https://guides.hanamirb.org/v2.2/database/migrations/ for details.
  change do
    alter_table :hotels do
      add_column :booking_conditions, :text, default: '{}'
      add_column :amenities_data, :text, default: '{}'
      set_column_default :location_data, '{}'
      set_column_not_null :location_data
    end
  end
end
