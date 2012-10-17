// ----------------------------- 公共变量 --------------------------------------

var common = {
    web_server_domain       : "http://www.darenhui.com",
    image_server_domain     : "http://image.darenhui.com",
    
    editWin                 : null,
    reasonWin               : null,

    listDS                  : null,
    
    list_num                : 20

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

// 将message类别序号翻译成中文
function messageCategoryRender(str){
    var result
    if(str == 3){
        result = '话题';
    }else if(str == 4){
        result = '问题';
    }
    return result;
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
        width:width+14,
        height:height+33,
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