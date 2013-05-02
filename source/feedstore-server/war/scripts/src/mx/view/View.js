$ns("mx.view");

mx.view.View = function()
{
    var me = $extend(MXComponent);
    var base = {};
    
    me.id = null;
    me.$element = null;
    me.$container = null;
    me.elementTag = "div";
    me.elementClass = null;
    me.elementStyle = null;
    
    me.frame = null;
    
    me.parentView = null;
    me.subviews = [];
    
    base._ = me._;
    me._ = function(p_options)
    {
        if (me.frame != null && p_options != null && p_options.frame != null)
        {
            p_options.frame = $.extend(me.frame, p_options.frame);
        }
        base._(p_options);
    };
    
    base.init = me.init;
    me.init = function(p_options)
    {
        base.init(p_options);
        
        if (me.$element == null)
        {
            me.$element = $("<" + me.elementTag + "/>");
        }
        if (me.$container == null)
        {
            me.$container = me.$element;
        }
        
        if (notEmpty(me.$element.attr("id")) && isEmpty(me.id))
        {
            me.id = me.$element.attr("id");
        }
        
        if (isEmpty(me.id) && isEmpty(me.$element.attr("id")))
        {
            me.id = String.newGuid();
        }
        me.$element.attr("id", me.id);
        
        if (me.elementClass != null)
        {
            me.$element.addClass(me.elementClass);
        }
        
        if (isPlainObject(me.elementStyle))
        {
            me.css(me.elementStyle);
        }
        
        me.setFrame(me.frame);
    };
    
    me.setFrame = function(p_frame)
    {
        if (p_frame != null)
        {
            me.frame = p_frame;
            if (p_frame.left != null)
            {
                me.$element.css("left", p_frame.left);
            }
            if (p_frame.right != null)
            {
                me.$element.css("right", p_frame.right);
            }
            if (p_frame.top != null)
            {
                me.$element.css("top", p_frame.top);
            }
            if (p_frame.bottom != null)
            {
                me.$element.css("bottom", p_frame.bottom);
            }
            if (p_frame.width != null)
            {
                me.$element.css("width", p_frame.width);
            }
            if (p_frame.height != null)
            {
                me.$element.css("height", p_frame.height);
            }
            if (p_frame.left != null || p_frame.right != null || p_frame.top != null || p_frame.bottom != null)
            {
                me.$element.css("position", "absolute");
            }
        }
    };
    
    me.addSubview = function(p_view, $p_element)
    {
    	if (typeof($p_element) == "undefined")
		{
    		$p_element = me.$container;
		}
    	
        if ($instanceOf(p_view, mx.view.View))
        {
            if (p_view.parentView == me)
            {
                return;
            }
            
            if (p_view.parentView != null)
            {
                p_view.parentView.removeSubview(p_view);
            }
            
            if ($p_element != null)
        	{
            	$p_element.append(p_view.$element);
        	}
            me.subviews.add(p_view);
            
            if (p_view.id != null)
            {
                me.subviews[p_view.id] = p_view;
            }
            p_view.parentView = me;
        }
    };
    
    me.removeSubview = function(p_view)
    {
        if ($instanceOf(p_view, mx.view.View))
        {
            p_view.$element.detach();
            me.subviews.remove(p_view);
            if (p_view.id != null)
            {
                me.subviews[p_view.id] = null;
                delete me.subviews[p_view.id];
            }
            p_view.parentView = null;
            p_view = null;
        }
    };
    
    me.clearSubviews = function()
    {
        while (me.subviews.length > 0)
        {
            me.removeSubview(me.subviews[0]);
        }
    };
    
    
    
    me.css = function(p_attrName, p_attrValue)
    {
        if (arguments.length == 1)
        {
            return me.$element.css(p_attrName);
        }
        else if (arguments.length >= 2)
        {
            return me.$element.css(p_attrName, p_attrValue);
        }
    };
    
    me.show = function(p_options)
    {
        me.$element.show(p_options);
    };
    

    me.hide = function(p_options)
    {
        me.$element.hide(p_options);
    };
    
    
    me.toString = function()
    {
        return "View[" + me.id + "]";
    };
    
    return me.endOfClass(arguments);
};