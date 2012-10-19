# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

Driver.create([
    {name: '夏亚'},
    {name: '阿姆罗'},
    {name: '黑色三连星'},
    {name: '爱微'},
    {name: '米哈伊尔·卡明斯基'},
    {name: '爱丽斯'},
    {name: '西罗.亚玛达'},
    {name: '麦克白'},
    {name: '西蒙'},
    {name: '卡多'}
  ])
p "Driver done"

types = Type.create([
    {name: '陆战用ms'},
    {name: '水下战用ms'},
    {name: '母舰'},
    {name: '地球圈战用ms'},
    {name: '宇宙战用ms'}
  ])
p "Type done"

periods = Period.create([
    {year: '79', name: ''},
    {year: '80', name: ''},
    {year: '83', name: ''},
    {year: '87', name: 'z'},
    {year: '88', name: 'zz'},
    {year: '92', name: ''},
    {year: '93', name: ''},
    {year: '99', name: ''},
    {year: '123', name: ''}
  ])
p "Period done"

if types.first.id && periods.first.id
  Gundam.create([
      { model: 'F71', name: 'G-GANNON', name_chs: 'G加农', period: periods.first ,type: types.first},
      { model: 'MS-05B', name: 'ZAKU I', name_chs: '扎古I后期型', period: periods.first ,type: types.first},
      { model: 'MS-05S', name: 'ZAKU I', name_chs: '扎古I指挥官用型', period: periods.first ,type: types.first},
      { model: 'MS-06F/J', name: 'ZAKU II F/J', name_chs: '扎古II F', period: periods.first ,type: types.first},
      { model: 'MS-06S', name: 'ZAKU II COMMANDER TYPE', name_chs: '扎古II指挥官用型', period: periods.first ,type: types.first},
      { model: 'MS-07B', name: 'GOUF', name_chs: '老虎', period: periods.first ,type: types.first},
      { model: 'MS-09', name: 'DOM', name_chs: '大魔', period: periods.first ,type: types.first},
      { model: 'MSM-03', name: 'GOGG', name_chs: '战蟹', period: periods.first ,type: types.first},
      { model: 'RX-75', name: 'GUNTANK', name_chs: '钢坦克', period: periods.first ,type: types.first},
      { model: 'RX-77-2', name: 'GUNGANNON', name_chs: '钢加农', period: periods.first ,type: types.first},
      { model: 'RX-78-1', name: 'GUNDAM', name_chs: '高达原型机', period: periods.first ,type: types.first},
      { model: 'RX-78-2', name: 'GUNDAM', name_chs: '高达', period: periods.first ,type: types.first},
      { model: 'RX-78-3', name: 'GUNDAM G3', name_chs: 'G3高达', period: periods.first ,type: types.first},
      { model: 'RX-78-4', name: '4TH GUNDAM', name_chs: '高达4号机', period: periods.first ,type: types.first},
      { model: 'RX-78-5', name: '5TH GUNDAM', name_chs: '高达5号机', period: periods.first ,type: types.first},
      { model: 'MS-18E', name: 'KAMPFER', name_chs: '京宝樊', period: periods[1] ,type: types.first},
      { model: 'MSM-03C', name: 'HYGOGG', name_chs: '高战蟹', period: periods[1] ,type: types.first},
      { model: 'MSM-07', name: 'Z\'GOK', name_chs: '魔蟹', period: periods[1] ,type: types.first},
      { model: 'RGM-79C', name: 'GM KAI', name_chs: '吉姆改', period: periods[1] ,type: types.first},
      { model: 'RGM-79G', name: 'GM', name_chs: '吉姆', period: periods[1] ,type: types.first},
      { model: 'RX-77D', name: 'Guncannon Mass Production', name_chs: '量产型钢加农', period: periods[1] ,type: types.first},
      { model: 'RX-78NT1', name: 'GUNDAM G-4 ALEX', name_chs: '爱利克斯高达', period: periods[1] ,type: types.first},
      { model: 'RX-79[G]', name: '', name_chs: '陆战高达先行量产型', period: periods[1] ,type: types.first},
      { model: 'RX-79[G]EZ-8', name: 'GUNDAM EZ8', name_chs: '高达EZ8', period: periods[1] ,type: types.first},
      { model: 'YMS-15', name: 'GANN', name_chs: '强人', period: periods[1] ,type: types.first},
      { model: 'AGX-04', name: 'GERBERA-TETRA', name_chs: '红色角马', period: periods[2] ,type: types.first},
      { model: 'AMX-002', name: 'NEUE ZIEL', name_chs: '露维.吉露', period: periods[2] ,type: types.first},
      { model: 'EX-16', name: 'ALBION', name_chs: '阿鲁比昂', period: periods[2] ,type: types.first},
      { model: 'MA-06', name: 'VAL-WALO', name_chs: '瓦尔.瓦罗', period: periods[2] ,type: types.first},
      { model: 'MS-06F2', name: 'ZAKU II F2', name_chs: '联邦用扎古II', period: periods[2] ,type: types.first},
      { model: 'MS-14A', name: 'GELGOOG', name_chs: '量产型格罗古古', period: periods[2] ,type: types.first},
      { model: 'MSN-00100', name: 'HYAKU SHIKI', name_chs: '百式', period: periods[2] ,type: types.first},
      { model: 'MSN-02', name: 'ZEONG', name_chs: '吉恩号', period: periods[2] ,type: types.first},
      { model: 'RMS-106', name: 'HI-ZAKU', name_chs: '高扎古', period: periods[2] ,type: types.first},
      { model: 'RX-178', name: 'GUNDAM MK-II', name_chs: '高达MK-II', period: periods[2] ,type: types.first},
      { model: 'RX-78 GP01', name: 'GUNDAM ZEPHYRANTHES', name_chs: '高达试作一号机', period: periods[2] ,type: types.first},
      { model: 'RX-78 GP01-FB', name: 'ZEPHYRANTHES FULL-VERNIAN', name_chs: '高达试作一号机', period: periods[2] ,type: types.first},
      { model: 'RX-78 GP02A', name: 'GUNDAM PHYSALIS', name_chs: '高达试作二号机', period: periods[2] ,type: types.first},
      { model: 'RX-78 GP03D', name: 'GUNDAM DENDROBIUM', name_chs: '高达试作三号机', period: periods[2] ,type: types.first},
      { model: 'RMS-141', name: 'XEKU-EINS', name_chs: '扎克艾因', period: periods[2] ,type: types.first},
      { model: 'AMX-004', name: 'QUBELEY', name_chs: '卡碧尼', period: periods[3] ,type: types.first},
      { model: 'EX-18', name: 'ARGAMA', name_chs: '亚迦玛', period: periods[3] ,type: types.first},
      { model: 'MSZ-006', name: 'ZETA GUNDAM', name_chs: 'Z高达', period: periods[3] ,type: types.first},
      { model: 'PMX-003', name: 'THE.O', name_chs: '铁奥', period: periods[3] ,type: types.first},
      { model: 'AMX-011', name: 'ZAKU III', name_chs: '扎古III', period: periods[4] ,type: types.first},
      { model: 'AMX-011S', name: 'ZAKU III CUSTOM', name_chs: '扎古III改', period: periods[4] ,type: types.first},
      { model: 'AMX-107', name: 'BAWOO', name_chs: '龙飞', period: periods[4] ,type: types.first},
      { model: 'FA-010-A', name: 'FULL ARMOR ZZ GUNDAM A', name_chs: '全装备ZZ高达A型', period: periods[4] ,type: types.first},
      { model: 'FA-010-S', name: 'FULL ARMOR ZZ GUNDAM S', name_chs: '全装甲ZZ高达S型', period: periods[4] ,type: types.first},
      { model: 'MSA-0011', name: 'SUPERIOR GUNDAM', name_chs: 'S高达', period: periods[4] ,type: types.first},
      { model: 'MSA-0011[EXT]', name: 'EXTRAORDINARILY SUPERIOR GUNDAM', name_chs: 'EX-S高达', period: periods[4] ,type: types.first},
      { model: 'MSA-099', name: 'RICK DIAS', name_chs: '利克迪亚斯', period: periods[4] ,type: types.first},
      { model: 'MSZ-008', name: 'Z II', name_chs: '', period: periods[4] ,type: types.first},
      { model: 'MSZ-010', name: 'ZZ GUNDAM', name_chs: 'ZZ高达', period: periods[4] ,type: types.first},
      { model: 'ORX-005', name: 'GAPLANT', name_chs: '贾普兰', period: periods[4] ,type: types.first},
      { model: 'RGZ-91', name: 'RE-GZ', name_chs: '灵格斯', period: periods[5] ,type: types.first},
      { model: 'MSN-04', name: 'SAZABI', name_chs: '沙扎比', period: periods[6] ,type: types.first},
      { model: 'RX-93', name: 'νGUNDAM', name_chs: 'v高达', period: periods[6] ,type: types.first},
      { model: 'RX-93-ν2', name: 'HI-νGUNDAM', name_chs: '海牛高达', period: periods[6] ,type: types.first},
      { model: 'MSN-06S', name: 'SINANJU', name_chs: '新安洲', period: periods[7] ,type: types.first},
      { model: 'NZ-666', name: 'kashatriya', name_chs: '剎帝利', period: periods[7] ,type: types.first},
      { model: 'RX-0', name: 'Unicorn Gundam', name_chs: '独角兽', period: periods[7] ,type: types.first},
      { model: 'RGM-109', name: 'HEAVYGUN', name_chs: '赫维刚', period: periods[8] ,type: types.first},
      { model: 'RX-F91', name: 'Gundam F91', name_chs: '高达 F91', period: periods[8] ,type: types.first},
      { model: 'RXR-44', name: 'GUNTANK R-44', name_chs: '钢坦克R-44', period: periods[8] ,type: types.first},
      { model: 'XM-01', name: 'DEN AN ZON', name_chs: '德南.佐恩', period: periods[8] ,type: types.first},
      { model: 'XM-05', name: 'BERGA GIROS', name_chs: '贝尔格.基罗斯', period: periods[8] ,type: types.first},
      { model: 'XM-06', name: 'DAHGI IRIS', name_chs: '达基.伊里斯', period: periods[8] ,type: types.first},
      { model: 'XM-07', name: 'VIGNA GHINA', name_chs: '比基那.基那', period: periods[8] ,type: types.first},
      { model: 'XM-X2', name: 'CROSS BONE GUNDAM X2', name_chs: '十字先锋高达二号机', period: periods[8] ,type: types.first}
    ])
  p "Gundam done"
end

p "all done!"