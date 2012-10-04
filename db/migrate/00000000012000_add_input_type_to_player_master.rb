class AddInputTypeToPlayerMaster < ActiveRecord::Migration

  def change
    add_column :player_masters, :input_type, :string
  end
end
