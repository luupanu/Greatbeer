class ChangeBeerStyleToOldStyle < ActiveRecord::Migration[5.2]
  def up
    rename_column :beers, :style, :old_style
  end

  def down
    rename_column :beers, :old_style, :style
  end
end
