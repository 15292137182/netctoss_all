<%@page pageEncoding="utf-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

 <img src="../images/master.gif" width="90px;" height="60px;" alt="logo" class="left"/>
 <img src="../images/master.gif" width="90px;" height="60px;" alt="logo" class="left"/>
 <img src="../images/master.gif" width="90px;" height="60px;" alt="logo" class="left"/>

 <marquee width=543 scrollamount="5">
 	<input type="text" style=" font-size:20px; height:60px; width:300px;border:897px; background:897px; 
 		color: yellow;font-style: italic;" disabled="disabled" value="欢迎: ${admin.name } 登录在线~~~"/>
 </marquee>
  <a href="../login/toLogin.do">[退出]</a>
 <marquee width="1050"  scrollamount="5">
	 <input type="text" id="systime" style=" font-size:20px; height:15px; width:300px;border:897px; background:897px; 
 		color: yellow;font-style: italic;" disabled="disabled" value="当前系统时间: ~~~"/>
 </marquee>

 