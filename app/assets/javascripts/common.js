// ----------------------- ext构件 --------------------------------

Ext.define('dimensionDSModel', {
    extend: 'Ext.data.Model',
    fields: [{
        name: 'id'
    },{
        name: 'name'
    }]
});

Ext.define('typeDSModel', {
    extend: 'Ext.data.Model',
    fields: [{
        name: 'id'
    },{
        name: 'name'
    }]
});

Ext.define('periodDSModel', {
    extend: 'Ext.data.Model',
    fields: [{
        name: 'id'
    },{
        name: 'year'
    },{
        name: 'name'
    }]
});

// ----------------------------- 公共变量 --------------------------------------

var common = {
    editWin                 : null,
    reasonWin               : null,
    list_num                : 20,
    listDS                  : null,
    dimensionDS : Ext.create('Ext.data.Store', {
        model: 'dimensionDSModel',
        remoteGroup: true,
        proxy: {
            type: 'ajax',
            url: '/dimensions/all_data',
            reader: {
                root: 'root',
                totalProperty: 'totalProperty'
            },
            autoLoad:true
        }
    }),
    periodDS : Ext.create('Ext.data.Store', {
        model: 'periodDSModel',
        remoteGroup: true,
        proxy: {
            type: 'ajax',
            url: '/periods/all_data',
            reader: {
                root: 'root',
                totalProperty: 'totalProperty'
            },
            autoLoad:true
        }
    }),
    typeDS : Ext.create('Ext.data.Store', {
        model: 'typeDSModel',
        remoteGroup: true,
        proxy: {
            type: 'ajax',
            url: '/types/all_data',
            reader: {
                root: 'root',
                totalProperty: 'totalProperty'
            },
            autoLoad:true
        }
    })
};


// ----------------------------- 公共方法 --------------------------------------

// 返回对象的值或者返回“未设置”
function getAttr(obj,attr){
    if(obj){
        return obj[attr]
    }else{
        return '未设置'
    }
}

// 将string型转换为int类型
function str2IntRender(str){
    return parseInt(str);
}

// 将int型转换为string类型
function int2StrRender(str){
    return str + "";
}

// int类型的时间转换为date_time类型的样式
function int2DateRender(str){
    var d = new Date();
    if(str){
        d.setTime(parseInt(str*1000));
    }else{
        d = null;
    }
    return d;
}

function booleanRender(str){
    var result
    switch(str){
        case true:
            result = '是'
            break;
        case 1:
            result = '是'
            break;
        case false:
            result = '否'
            break;
        case 0:
            result = '否'
            break;
    }
    return result;
}

function boolToIntRender(str){
    var result
    switch(str){
        case true:
            result = 1
            break;
        case false:
            result = 0
            break;
    }
    return result;
}

function redpacketSlotRender(str){
    var result
    switch(parseInt(str)){
        case 0:
            result = "未设置"
            break;
        case 1:
            result = "左"
            break;
        case 2:
            result = "右"
            break;
    }
    return result;
}

function genderConvert(val){
    var result
    switch(val){
        case true:
            result = "男"
            break;
        case false:
            result = "女"
            break;
        case 1:
            result = "男"
            break;
        case 0:
            result = "女"
            break;
    }
    return result;
}


// ----------------------------- 弹窗定义 --------------------------------------

// 普通弹窗
function openWindow(id,title,url,width,height,reloadDs){
    var win = Ext.get(id)
    if (win) {
        win.close();
        return;
    }
    win = new Ext.Window({
        id:id,
        title:title,
        layout:'fit',
        width:width+12,
        height:height+32,
        closeAction:'destroy',
        plain: false,
        modal: true,
        resizable: false,
        autoLoad: {
            url: url,
            scripts: true
        }
    });
    win.on("destroy",function(){
        reloadDs.load();
    });
    win.show();
}

// 带滚动条弹窗
function openScrollWindow(id,title,url,width,height,reloadDs){
    var win = Ext.get(id)
    if (win) {
        win.close();
        return;
    }
    win = new Ext.Window({
        id:id,
        title:title,
        layout:'fit',
        width:width+31,
        height:height,
        closeAction:'destroy',
        plain: false,
        autoScroll: true,
        modal: true,
        resizable: false,
        autoLoad: {
            url: url,
            scripts: true
        }
    });
    win.on("destroy",function(){
        reloadDs.load();
    });
    win.show();
}