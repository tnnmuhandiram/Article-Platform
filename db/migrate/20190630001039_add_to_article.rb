class AddToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :urlToImage, :text
    add_column :articles, :publishedAt, :string
    add_column :articles, :content, :text
  end
end
