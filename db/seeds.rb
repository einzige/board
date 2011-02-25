# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
puts 'EMPTY THE MONGODB DATABASE'
Mongoid.master.collections.reject { |c| c.name == 'system.indexes'}.each(&:drop)
puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'Zinin Serge', :email => 'szinin@gmail.com', :password => 'gfhjkmqe', 
                                                             :password_confirmation => 'gfhjkmqe'
puts 'New user created: ' << user.name

puts 'SEED CATEGORIES'
c1  = Category.create   :name => 'Недвижимость'
c   = Category.create   :name => 'Автомобили'
cc  = c.children.build  :name => 'Иномарки'
cc.save
cc2 = c.children.build  :name => 'Отечественные'
cc2.save
ccc = cc.children.build :name => 'Toyota'
ccc.save

ccc.lots.build
