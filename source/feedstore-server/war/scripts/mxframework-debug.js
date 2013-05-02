(function(){
    
var scripts = document.getElementsByTagName("script");
var src = scripts[scripts.length - 1].src;
var srcPath = src.substr(0, src.lastIndexOf("/") + 1);

include("lib/jquery/jQuery.js");
include("lib/jquery/jquery.transit.min.js");
include("src/mx/javascript-extensions.js");
include("src/mx/jquery-extensions.js");
include("src/mx/framework-base.js");
include("src/mx/framework-core.js");

function include(p_src)
{
    document.write("<script src='" + srcPath + p_src + "'></script>");
}

})();