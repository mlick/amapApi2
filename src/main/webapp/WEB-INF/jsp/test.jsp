<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>

<html>
<head>
    <script src="https://code.jquery.com/jquery-1.11.1.min.js">
    </script>
    <script type="text/javascript">
        document.write("document Hello World!");
        var tryStr= "${arrStr}";
        alert(tryStr);

        var strs = tryStr.split(";");
        var arr = [];
        for (var i = 0; i < strs.length; i++) {
            var ss = strs[i].split(',');
            arr.push(ss);
        }
        alert(arr);
        var btnClick = function(){
            alert("onclick");
            $.post("/amapApi2/lxx/getPerson",{name:$("#name").val()},function(data){
                alert(data);
            });
        };

        $(function(){
            $("#btn").click(btnClick);
        });
    </script>
</head>

<body>
<h2>${pageContext.request.contextPath}</h2>
<h2>${str}</h2>
<h2><%=request.getContextPath()%></h2>
<input id="name" type="text"/>
<button type="button" id="btn">发送到后台</button>
</body>
</html>