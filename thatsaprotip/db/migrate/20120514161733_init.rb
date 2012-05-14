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
      t.references :user
      t.timestamps
    end

    create_table :tags do |t|
      t.string :tag, :limit => 20
    end

    create_table :user_favorites do |t|
      t.references :user
      t.references :protip
      t.timestamps
    end

    create_table :protip_favorites_total_counts do |t|
      t.references :protip
      t.integer :count
      t.timestamps
    end
  end

  def down
    drop_table :users
    drop_table :protips
    drop_table :tags
    drop_table :user_favorites
    drop_table :protip_favorites_total_counts
  end
end
