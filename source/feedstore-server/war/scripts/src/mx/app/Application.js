$ns("mx.app");

$include("mt.res.app-mobile.css");

mx.app.Application = function()
{
    var me = $extend(mx.view.View);
    me.isFullScreen = true;
    var base = {};
    
    me.$element = null;
    
    me.appId = null;
    me.appDisplayName = null;

    base.init = me.init;
    me.init = function(p_options)
    {
        if (me.$element == null)
        {
            me.$element = $(document.body);
        }
        
        if (me.id == null)
        {
            me.id = me.appId;
        }
        base.init(p_options);
        if (me.appDisplayName != null)
        {
            document.title = me.appDisplayName;
        }
        
        me.frame = {
            width: me.$element.width(),
            height: me.$element.height()
        };
        
        mx.app.Application.singleton = me;
    };
    
    me.run = function(p_options)
    {
        
    };
    
    return me.endOfClass(arguments);
};

mx.app.Application.singleton = null;