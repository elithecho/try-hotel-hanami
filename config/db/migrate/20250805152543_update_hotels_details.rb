# frozen_string_literal: true

ROM::SQL.migration do
  # Add your migration here.
  #
  # See https://guides.hanamirb.org/v2.2/database/migrations/ for details.
  change do
    alter_table :hotels do
      add_column :booking_conditions, :text, null: false, default: '{}'
      add_column :anemities_data, :text, null: false, default: '{}'
      set_column_default :location_data, '{}'
    end
  end
end
