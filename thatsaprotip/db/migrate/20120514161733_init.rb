class Init < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :alias, :null => false
      t.string :last_name
      t.string :first_name
      t.string :email
      t.integer :fbid
      t.timestamps
    end

    create_table :protips do |t|
      t.text :protip, :null => false
      t.belongs_to :user
      t.timestamps
    end

    create_table :tags do |t|
      t.string :tag, :limit => 20
    end

    create_table :protips_tags, :id => false do |t|
      t.belongs_to :protip
      t.belongs_to :tag
    end

    create_table :favorites do |t|
      t.belongs_to :user
      t.belongs_to :protip
      t.timestamps
    end

    create_table :protip_favorites_total_counts do |t|
      t.belongs_to :protip
      t.integer :count
      t.timestamps
    end
  end

  def down
    drop_table :users
    drop_table :protips
    drop_table :tags
    drop_table :protips_tags
    drop_table :favorites
    drop_table :protip_favorites_total_counts
  end
end
