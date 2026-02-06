class AddUpdatedAtToYears < ActiveRecord::Migration[8.1]
  def change
    add_column :years, :updated_at, :datetime, null: false, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
