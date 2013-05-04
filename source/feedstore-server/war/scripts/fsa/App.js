$ns("fsa");

$import("lib.jquery.jquery-transit");

$import("fsa.biz.ChannelManager");
$import("fsa.scn.ChannelScene");

$include("fsa.res.app.css");
$include("fsa.res.NavigationBar.css");

fsa.App = function()
{
    var me = $extend(mx.app.Application);
    var base = {};
    
    me.appId = "fsa";
    me.appDisplayName = "FeedStore Manager";
    
    base.init = me.init;
    me.init = function(p_options)
    {
        base.init(p_options);
        
        me.scene = new fsa.scn.ChannelScene();
        me.addSubview(me.scene, me.$element.find("#body > #contentPannel"));
    };
    
    
    me.setLoading = function(p_loading)
    {
        if (p_loading == null)
        {
            p_loading = true;
        }
        me.$element.toggleClass("loading", p_loading);
    };
    
    me.run = function(p_options)
    {
        me.scene.activate({ reload: true });
    };
    
    return me.endOfClass(arguments);
};