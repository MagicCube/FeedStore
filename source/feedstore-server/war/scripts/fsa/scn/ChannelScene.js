$ns("fsa.scn");

$import("fsa.view.ChannelGridView");

fsa.scn.ChannelScene = function()
{
    var me = $extend(mx.scn.Scene);
    me.autoFillParent = true;
    var base = {};
    
    me.gridView = null;
    
    base.init = me.init;
    me.init = function(p_options)
    {
        base.init(p_options);
        _initGridView();
    };
    
    base.activate = me.activate;
    me.activate = function(p_args)
    {
        base.activate(p_args);
        
        if (p_args != null)
        {
            if (p_args.reload)
            {
                me.gridView.load();
            }
        }
    };
    
    function _initGridView()
    {
        me.gridView = new fsa.view.ChannelGridView({
            id: "channelGridView",
            frame: { left: 15, top: 15, right: 15, bottom: 15 }
        });
        me.addSubview(me.gridView);
    }
    
    return me.endOfClass(arguments);
};