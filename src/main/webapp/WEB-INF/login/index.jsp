<%@page pageEncoding="utf-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>－NetCTOSS</title>
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global_color.css" /> 
        <script type="text/javascript" src="../js/jquery-1.11.3.js"></script>
        <script type="text/javascript" src="../js/dateTime.js"></script>
    </head>
    <body class="index">
        <!--导航区域开始-->
        <marquee width=1180 scrollamount="5">
			 <input type="text" id="systime" style=" font-size:20px; height:60px; width:300px;border:897px; background:897px; 
		 		color: yellow;font-style: italic;" disabled="disabled" value=" 欢迎: +++ 登录在线~~~"/>
		 </marquee>
        <div id="index_navi">
           <jsp:include page="/WEB-INF/menu/menu_list.jsp" />
        </div>
    </body>
</html>
