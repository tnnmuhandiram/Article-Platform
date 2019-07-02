class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :uuid
      t.string :source_id
      t.string :source_name
      t.string :author
      t.text :title
      t.text :description
      t.text :url

      t.timestamps
    end
  end
end
