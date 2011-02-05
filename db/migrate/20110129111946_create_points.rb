class CreatePoints < ActiveRecord::Migration
  def self.up
    create_table :points do |t|
      t.string :address
      t.integer :visit_number

      t.timestamps
    end
  end

  def self.down
    drop_table :points
  end
end
