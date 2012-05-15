# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

user_weicool, user_queeny, user_mccord = User.create([
  {:alias => 'weicool'},
  {:alias => 'queeny'},
  {:alias => 'mccord'},
])

tags = Tag.create([
  {:tag => 'vegas'},
  {:tag => 'poker'},
  {:tag => 'sales'},
  {:tag => 'life'},
])

protips = Protip.create([
  {:protip => 'Never fold pocket rockets pre-flop', :user => user_weicool},
  {:protip => 'Always be closing', :user => user_queeny},
  {:protip => 'Results - expectations = happiness', :user => user_weicool},
])

protips[0].tags = [tags[0], tags[1]]
protips[1].tags = [tags[2]]
protips[2].tags = [tags[3]]

protips[0].favorited_users = [user_weicool, user_queeny, user_mccord];
protips[1].favorited_users = [user_weicool];
