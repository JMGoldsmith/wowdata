# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# 109118,72092,109119,2772,23424,109693,113588
ItemData.delete_all
ItemData.get_item_id_and_name('109118')
ItemData.get_item_id_and_name('72092') 
ItemData.get_item_id_and_name('109119')
ItemData.get_item_id_and_name('2772')
ItemData.get_item_id_and_name('23424')
ItemData.get_item_id_and_name('109693')
ItemData.get_item_id_and_name('113588') 





 
 
  
  
  
 
