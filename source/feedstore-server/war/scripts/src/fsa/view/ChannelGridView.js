$ns("fsa.view");

$include("fsa.res.ChannelGridView.css");

fsa.view.ChannelGridView = function()
{
    var me = $extend(mx.view.View);
    me.elementClass = "ChannelGridView";
    var base = {};
    
    me.columns = [
        { id: "title", text: "标题" },
        { id: "lastPublishTime", text: "最后发布时间" },
        { id: "lastStoredTime", text: "最后存储时间" },
        { id: "lastUpdatedTime", text: "最后更新时间" }
    ];
    me.items = [];
    
    me.$headerRow = null;
    me.$tbody = null;
    
    base.init = me.init;
    me.init = function(p_options)
    {
        base.init(p_options);
        _initHeaderTable();
        _initBodyTable();
    };
    
    function _initHeaderTable()
    {
        var $table = $("<table id=header><tr></tr></table>");
        var $tr = $table.find("tr");
        for (var i = 0; i < me.columns.length; i++)
        {
            var column = me.columns[i];
            var $td = $("<td/>");
            $td.attr("id", column.id);
            $td.text(column.text);
            $tr.append($td);
        }
        $tr.on("click", "td", _cell_onclick);
        me.$headerRow = $tr;
        me.$element.append($table);
    }
    
    function _initBodyTable()
    {
        var $table = $("<table id=body><tbody></table>");
        var $tableContainer = $("<div id='bodyContainer'>");
        $tableContainer.append($table);
        me.$element.append($tableContainer);
        me.$tbody = $table.children("tbody");
    }
    
    me.appendItem = function(p_item)
    {
        var $tr = $("<tr>");
        for (var i = 0; i < me.columns.length; i++)
        {
            var column = me.columns[i];
            var $td = $("<td/>");
            $td.attr("id", column.id);
            me.formatCell($td, p_item[column.id], column);
            $tr.append($td);
        }
        me.$tbody.append($tr);
        me.items.add(p_item);
    };
    
    me.appendItems = function(p_items)
    {
        for (var i = 0; i < p_items.length; i++)
        {
            me.appendItem(p_items[i]);
        }
    };
    
    me.clearItems = function()
    {
        me.items = [];
        me.$tbody.children().remove();
    };
    
    me.setItems = function(p_items)
    {
        me.clearItems();
        me.appendItems(p_items);
    };
    
    me.load = function()
    {
        fsa.app.setLoading();
        $.ajax({
            url: $mappath("~/api/channel")
        }).done(function(p_result)
        {
            fsa.app.setLoading(false);
            me.setItems(p_result);
        });
    };
    
    
    
    
    _tomorrow = $format(Date.today.addDays(1), "yyyy年M月d日");
    _today = $format(Date.today, "yyyy年M月d日");
    _yesterday = $format(Date.today.addDays(-1), "yyyy年M月d日");
    _theDayBeforeYesterday = $format(Date.today.addDays(-2), "yyyy年M月d日");
    me.formatCell = function($p_cell, p_value, p_column)
    {
        var text = null;
        if (p_column.id == "title")
        {
            text =  p_value != null ? p_value : "";
        }
        else
        {
            if (p_value != null)
            {
                var date = new Date(p_value);
                var deltaSeconds = (new Date() - date) / 1000;
                if (deltaSeconds > 0 && deltaSeconds < 60 * 60)
                {
                    text = $format(date, "smart");
                }
                else
                {
                    text = $format(date, "yyyy年M月d日 HH:mm");
                    text = text.replace(_today, "今天");
                    text = text.replace(_yesterday, "昨天");
                    text = text.replace(_tomorrow, "明天");
                    text = text.replace(_theDayBeforeYesterday, "前天");
                    text = text.replace(Date.today.getFullYear() + "年", "");
                }
                $p_cell.attr("title", $format(date));
            }
            else
            {
                text = "";
            }
        }
        $p_cell.text(text);
    };
    
    
    me.sort = function(p_columnName)
    {
        var items = me.items.sort(function(p_a, p_b)
        {
            var a = p_a[p_columnName];
            var b = p_b[p_columnName];
            if (a == null)
            {
                if (b == null)
                {
                    return 0;
                }
                else
                {
                    return 1;
                }
            }
            else
            {
                if (isFunction(a.localeCompare))
                {
                    return a.localeCompare(b);
                }
                else
                {
                    return b - a;
                }
            }
        });
        me.setItems(items);
    };
    
    
    
    function _cell_onclick(e)
    {
        me.sort(e.target.id);
    }
    
    return me.endOfClass(arguments);
};