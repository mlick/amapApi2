<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <title>鼠标绘制点线面</title>
    <link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css"/>
    <style>
        html,body{ margin:0px; padding:0px; height: 100%; }
        .headbg{ background: black; color: white; height:48px; }
        .userManagerAll{ height: 100%; width: 100%; }
        .left{ float:left;height: 100%; width: 200px; margin: 0px; overflow-y:auto;}
        .right{ float:right; height: 100%; width:100%; align:right;}
    </style>
    <script src="http://webapi.amap.com/maps?v=1.3&key=您申请的key值&plugin=AMap.MouseTool,AMap.PolyEditor"></script>
    <script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
    <script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
</head>
<body>
<div class="left"></div>
<div id="container" class="right"></div>
<div id="tip">
    鼠标在地图上点击绘制多边形时，双击左键或单击右键结束操作
</div>
<div class="button-group">
    <input type="button" class="button" value="开始编辑多边形" onClick="editor.startEditPolygon()"/>
    <input type="button" class="button" value="结束编辑多边形" onClick="editor.closeEditPolygon()"/>
    <input type="button" class="button" value="鼠标绘制面" id="polygon"/>
    <input id="calc" type="button" class="button" value="计算点是否在多边形内"/>
</div>
<script>


    var map = new AMap.Map("container", {
        resizeEnable: true,
        center: [116.403322, 39.900255],//地图中心点
        zoom: 13 //地图显示的缩放级别
    });

    new AMap.Marker({
        map: map,
        position: [116.368904, 39.923423]
    });
    //在地图上绘制折线
    var editor = {};
//    var arr = [ //构建多边形经纬度坐标数组
//        [116.403322, 39.920255],
//        [116.410703, 39.897555],
//        [116.402292, 39.892353],
//        [116.389846, 39.891365]
//    ];
    var tryStr= "${arrStr}";
    alert(tryStr);

    var strs = tryStr.split(";");
    var arr = [];
    for (var i = 0; i < strs.length; i++) {
        var ss = strs[i].split(',');
        arr.push(ss);
    }

    var btnClick = function () {
        alert("onclick");
        $.post("/amapApi2/lxx/getPerson", {name: arr.toString()}, function (data) {
            alert(data);
        });
    };
    var polygon = new AMap.Polygon({
        map: map,
        path: arr,
        strokeColor: "#0000ff",
        strokeOpacity: 1,
        strokeWeight: 3,
        fillColor: "#f5deb3",
        fillOpacity: 0.35
    });
    editor._polygon = polygon;
    map.setFitView();
    editor._polygonEditor = new AMap.PolyEditor(map, editor._polygon);
    editor.startEditPolygon = function () {
        editor._polygonEditor.open();
    }
    editor.closeEditPolygon = function () {
        editor._polygonEditor.close();
        btnClick();
    }

    //在地图中添加MouseTool插件
    var mouseTool = new AMap.MouseTool(map);
    AMap.event.addDomListener(document.getElementById('polygon'), 'click', function () {
        editor._polygonEditor.close();
        mouseTool.polygon();
    }, false);

    AMap.event.addListener(mouseTool, "draw", function callback(e) {
        mouseTool.close(true);
        var eObject = e.obj + "";//obj属性就是鼠标事件完成所绘制的覆盖物对象。
        //alert("obj>> " + eObject);
        var strs = eObject.split(";");
        arr = [];
        for (i = 0; i < strs.length; i++) {
            var ss = strs[i].split(',');
            arr.push(ss);
        }
        alert(arr);
        polygon = new AMap.Polygon({
            map: map,
            path: arr,
            strokeColor: "#0000ff",
            strokeOpacity: 1,
            strokeWeight: 3,
            fillColor: "#f5deb3",
            fillOpacity: 0.35
        });
        editor._polygon = polygon;
        map.setFitView();
        editor._polygonEditor = new AMap.PolyEditor(map, editor._polygon);
        btnClick();
    });

    AMap.event.addDomListener(document.getElementById('calc'), 'click', function () {
        alert('点是否在多边形内：' + polygon.contains([116.368904, 39.923423]));
    });

</script>
</body>
</html>