<%@page pageEncoding="utf-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>－NetCTOSS</title>
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global_color.css" /> 
        <script type="text/javascript" src="../js/jquery-1.11.3.js"></script>
        <script type="text/javascript" src="../js/dateTime.js"></script>
        <script type="text/javascript" src="../js/clearMsg.js"></script>
        <script type="text/javascript" src="../js/login.js"></script>
    </head>
    <body class="index">
    	<br />
    	<br />
    	<marquee width=1180 scrollamount="5">
			 <input type="text" id="systime" style=" font-size:20px; height:60px; width:300px;border:897px; background:897px; 
		 		color: yellow;font-style: italic;" disabled="disabled" value=" 欢迎: +++ 登录在线~~~"/>
		 </marquee>
    
        <div class="login_box">
        	<form id="login_form">
            <table align="right">
                <tr>
                    <td class="login_info">账号：</td>
                    <td colspan="2"><input name="name" id="name" onfocus="clearMsg('name_msg');" type="text" class="width150" /></td>
                    
                    <td class="login_error_info"><span id="name_msg" class="required"></span></td>
                </tr>
                <tr>
                    <td class="login_info">密码：</td>
                    <td colspan="2"><input name="pwd" id="pwd" onfocus="clearMsg('pwd_msg');" type="password" class="width150" /></td>
                    <td><span class="required" id="pwd_msg"></span></td>
                </tr>
                <tr>
                    <td class="login_info">验证码：</td>
                    <td class="width70"><input name="verification" id="verification" onfocus="clearMsg('verification_msg')" type="text" class="width70" /></td>
                    <td><img id="change_image" src="getImageCode.do" onclick="changeImage();" alt="验证码" title="点击更换" /></td>  
                    <td><span class="required" id="verification_msg"></span></td>              
                </tr>            
                <tr>
                    <td></td>
                    <td class="login_button" colspan="2">
                        <a href="javascript:checkLogin();"><img src="../images/login_btn.png" /></a>
                    </td>    
                    <td><span class="required" id="login_msg"></span></td>                
                </tr>
            </table>
            </form>
        </div>
    </body>
</html>
























