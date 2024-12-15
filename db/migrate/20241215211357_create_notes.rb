class CreateNotes < ActiveRecord::Migration[8.0]
  def change
    create_table :notes do |t|
      t.text :body
      t.datetime :published_at

      t.timestamps
    end
  end
end
