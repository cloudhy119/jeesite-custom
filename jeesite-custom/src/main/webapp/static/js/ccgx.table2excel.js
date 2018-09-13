/**
 * 所有单页table通用
 * 将table转成json模拟表单提交给后台处理，利用POI生成excel返回给页面下载
 * 依赖：jquery
 * @author huangyun
 * @type {{}}
 */
var ccgx_table2excel = {};
ccgx_table2excel.exportExcel = function (opts){
    // Set options
    var defaults = {
        url: '', //后台服务url
        fileName: 'export-excel', //生成的excel文件名
        title: 'export-excel', //excel表格的标题
        tableId: '', //html中table的id
        excludeFirstCol: false //是否排除第一列（针对第一列为序号的情况。考虑到要适应行列合并，想要排除任意列逻辑复杂度太高，暂不实现）
    };
    opts = $.extend(defaults, opts);
    var tableJson = ccgx_table2excel.htmlTable2Json(opts.tableId, opts.excludeFirstCol);
    console.log(tableJson);
    var form = $("<form></form>").attr("action", opts.url).attr("method", "post");
    form.append($("<input/>").attr("type", "hidden").attr("name", "json").attr("value", tableJson));
    form.append($("<input/>").attr("type", "hidden").attr("name", "fileName").attr("value", opts.fileName));
    form.append($("<input/>").attr("type", "hidden").attr("name", "title").attr("value", opts.title));
    $('body').append(form);
    form.submit();
    form.remove();
}
/**
 *  无视行列合并，只记录colspan、rowspan值，交给后台处理
 */
ccgx_table2excel.htmlTable2Json = function (tableId, excludeFirstCol) {
    var jsondata = {};
    // table head
    var heads = [];
    $("#" + tableId + " thead tr").each(function(trindex, tr) {
        var trs = [];
        var columns = $(tr).find("th");
        if(columns.length == 0) {
            columns = $(tr).find("td");
        }
        columns.each(function(index, item) {
            if(excludeFirstCol && trindex == 0 && index == 0) {
                return true;
            }
            var th = {};
            th.text = $(item).text();
            if($(item).attr("rowspan") != undefined) {
                th.rowspan = $(item).attr("rowspan");
            } else {
                th.rowspan = "";
            }
            if($(item).attr("colspan") != undefined) {
                th.colspan = $(item).attr("colspan");
            } else {
                th.colspan = "";
            }
            trs.push(th);
        });
        heads.push(trs);
    });
    jsondata.heads = heads;
    var bodys = [];
    $("#" + tableId + " tbody tr").each(function(index, tr) {
        var trs = [];
        $(tr).find("td").each(function(index, item) {
            if(excludeFirstCol && index == 0) {
                return true;
            }
            var td = {};
            td.text = $(item).text();
            if($(item).attr("rowspan") != undefined) {
                td.rowspan = $(item).attr("rowspan");
            } else {
                td.rowspan = "";
            }
            if($(item).attr("colspan") != undefined) {
                td.colspan = $(item).attr("colspan");
            } else {
                td.colspan = "";
            }
            trs.push(td);

        });
        bodys.push(trs);
    });
    jsondata.bodys = bodys;
    var foots = [];
    $("#" + tableId + " tfoot tr").each(function(index, tr) {
        //兼容tfoot中列的写法
        var columns = $(tr).find("th");
        if(columns.length == 0) {
            columns = $(tr).find("td");
        }
        var trs = [];
        columns.each(function(index, item) {
            if(excludeFirstCol && index == 0) {
                return true;
            }
            var td = {};
            td.text = $(item).text();
            if($(item).attr("rowspan") != undefined) {
                td.rowspan = $(item).attr("rowspan");
            } else {
                td.rowspan = "";
            }
            if($(item).attr("colspan") != undefined) {
                td.colspan = $(item).attr("colspan");
            } else {
                td.colspan = "";
            }
            trs.push(td);
        });
        foots.push(trs);
    });
    jsondata.foots = foots;
    return JSON.stringify(jsondata);
}