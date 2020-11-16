class DropUrsers < ActiveRecord::Migration
  def change
    drop_table(:ursers)
  end
end
