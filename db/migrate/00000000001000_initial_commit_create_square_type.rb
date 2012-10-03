class InitialCommitCreateSquareType < ActiveRecord::Migration

  def change
    create_table :square_types do |t|
      t.string  :identifier, unique: true
      t.string  :name
      t.text    :details
      t.string  :as_string
      t.string  :as_string_color
      t.integer :cost
    end
  end
end
