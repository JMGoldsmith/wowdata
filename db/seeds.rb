# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# 109118,72092,109119,2772,23424,109693,113588
Item.delete_all
Item.get_item_id_and_name('109118')
Item.get_item_id_and_name('72092') 
Item.get_item_id_and_name('109119')
Item.get_item_id_and_name('2772')
Item.get_item_id_and_name('23424')
Item.get_item_id_and_name('109693')
Item.get_item_id_and_name('113588') 





 
 
  
  
  
 
