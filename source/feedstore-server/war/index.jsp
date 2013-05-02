<%@page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript" src="scripts/mxframework-debug.js"></script>
</head>

<body>
<div id="fsa">
    <div id="header">
        <div id="appTitle"><h1>FeedStore</h1></div>
        <div id="appToolBarContainer"></div>
    </div>
    <div id="body">
        <div id="navigationPannel">
            <ul id="navigationBar" class="NavigationBar">
                <li>
                    <span>文件夹</span>
                    <ul>
                        <li class="selected"><span>频道</span></li>
                        <li><span>订阅</span></li>
                        <li><span>新闻</span></li>
                    </ul>
                </li>
                
                <li>
                    <span>系统</span>
                    <ul>
                        <li><span>设置</span></li>
                    </ul>
                </li>
            </ul>
        </div>
        
        <div id="contentPannel"></div>
    </div>
</div>
</body>

<script>
$import("fsa.App");

mx.whenReady(function(){
    fsa.app = new fsa.App({ $element: $("#fsa") });
    fsa.app.run();
});
</script>

</html> 