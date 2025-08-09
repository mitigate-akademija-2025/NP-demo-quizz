class DropZinasanas < ActiveRecord::Migration[8.0]
  def change
    drop_table :zinasanas
  end
end
