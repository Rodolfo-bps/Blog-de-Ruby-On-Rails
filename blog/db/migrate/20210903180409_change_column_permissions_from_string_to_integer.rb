class ChangeColumnPermissionsFromStringToInteger < ActiveRecord::Migration[5.2]
  def chenge
    remove_column :users,:permission_level
  
    add_column :users,:permission_level, :integer, default: 1
  end
end
