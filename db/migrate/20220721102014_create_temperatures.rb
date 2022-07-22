class CreateTemperatures < ActiveRecord::Migration[6.1]
  def change
    create_table :temperatures do |t|
      t.float :value

      t.timestamps
    end
  end
end
