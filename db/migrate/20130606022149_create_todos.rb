class CreateTodos < ActiveRecord::Migration
  def up
    create_table :todos do |t|
      t.string  :name
  end

  def down
    drop_table :todos
  end
end
