# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Driver.create([
    {name: '夏亚'},
    {name: '阿姆罗'}
  ])

types = Type.create([
    {name: '陆战用ms'},
    {name: '水下战用ms'}
  ])

periods = Period.create([{year: '79'},{year: '80'}])

Gundam.create([
    { model: 'F71', name: 'G-GANNON', name_chs: 'G加农', period: periods.first ,type: types.first},
    { model: 'MS-05B', name: 'ZAKU I', name_chs: '扎古I后期型', period: periods.first ,type: types.first},
    { model: 'MS-05S', name: 'ZAKU I', name_chs: '扎古I指挥官用型', period: periods.first ,type: types.first},
    { model: 'MS-06F/J', name: 'ZAKU II F/J', name_chs: '扎古II F', period: periods.first ,type: types.first},
    { model: 'MS-06S', name: 'ZAKU II COMMANDER TYPE', name_chs: '扎古II指挥官用型', period: periods.first ,type: types.first},
    { model: 'MS-07B', name: 'GOUF', name_chs: '老虎', period: periods.first ,type: types.first},
    { model: 'MS-09', name: 'DOM', name_chs: '大魔', period: periods.first ,type: types.first},
    { model: 'MSM-03', name: 'GOGG', name_chs: '战蟹', period: periods.first ,type: types.first}
  ])

