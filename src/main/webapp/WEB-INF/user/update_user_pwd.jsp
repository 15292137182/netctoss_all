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
        <script type="text/javascript" src="../js/menuDateTime.js"></script>
        <script type="text/javascript" src="../js/clearMsg.js"></script>     
        <script type="text/javascript" >
        	var flag;
        	function checkOldPwd(){
        		flag=null;
				var pwd=$("#password").val().trim();
				var regPwd=/^[a-zA-Z]\w{5,17}$/;
				if(!regPwd.test(pwd)){
					$("#password_msg").text("6~18以内的字母,数字,下划线组成,由字母开头").addClass("error_msg");
					flag=false;
					return;
				}
				$.ajax({
					url:"checkOldPwd.do",
					type:"post",
					dataType:"json",
					data:{"pwd":pwd},
					success:function(data){
						if(data.status==1){
							//alert(data.msg);
							$("#password_msg").text(data.msg).addClass("error_msg");
							flag=false;
							return;
						}
						if(data.status==0){
							//alert(data.msg);
							$("#password_msg").text(data.msg).removeClass("error_msg");
							flag=true;
							return;
						}
					},
					error:function(){alert("系统异常..");}
				});
        	}
        	
        	function save(){
        		var newPwd=$("#newPwd").val().trim();
        		var regPwd=/^[a-zA-Z]\w{5,17}$/;
				if(!regPwd.test(newPwd)){
					$("#newPwd_msg").text("6~18以内的字母,数字,下划线组成,由字母开头").addClass("error_msg");
					return false;
				}
				var confirmPwd=$("#confirmPwd").val().trim();
				if(confirmPwd!=newPwd){
					$("#confirmPwd_msg").text("两次密码输入不一致!").addClass("error_msg");
					return false;
				}
				
				var timer=setInterval(function(){
					if(flag!=null){
						clearInterval(timer);
						if(flag){
							//alert("++++++");
							$.ajax({
								url:"updatePwd.do",
								type:"post",
								dataType:"json",
								data:{"newPwd":confirmPwd},
								success:function(data){
									if(data.status==0){
										//alert(data.msg);
										$("#save_result_info").text(data.msg);
										$("#save_result_info").show();
										setTimeout(function(){
											$("#save_result_info").hide();
										},3000);
									}
								},
								error:function(){alert("更新密码失败!");}
							});
						}
					}
				},500);
        	}
        </script>      
    </head>
    <body>
        <!--Logo区域开始-->
        <div id="header">
            	<jsp:include page="/WEB-INF/menu/logo.jsp" />        
        </div>
        <!--Logo区域结束-->
        <!--导航区域开始-->
        <div id="navi">
            <jsp:include page="/WEB-INF/menu/menu_list.jsp" />     
        </div>
        <!--导航区域结束-->
        <div id="main">      
            <!--保存操作后的提示信息：成功或者失败-->      
            <div id="save_result_info" class="save_success">保存成功！</div><!--保存失败，旧密码错误！-->
            <form class="main_form">
                <div class="text_info clearfix"><span>旧密码：</span></div>
                <div class="input_info">
                    <input id="password" onblur="checkOldPwd();"  onfocus="clearMsg('password_msg');" type="password" class="width200"  /><span class="required">*</span>
                    <div class="validate_msg_medium" id="password_msg"></div>
                </div>
                <div class="text_info clearfix"><span>新密码：</span></div>
                <div class="input_info">
                    <input type="password" id="newPwd"  onfocus="clearMsg('newPwd_msg')"  class="width200" /><span class="required">*</span>
                    <div class="validate_msg_medium" id="newPwd_msg"></div>
                </div>
                <div class="text_info clearfix"><span>重复新密码：</span></div>
                <div class="input_info">
                    <input id="confirmPwd" onfocus="clearMsg('confirmPwd_msg');" type="password" class="width200"  /><span class="required">*</span>
                    <div class="validate_msg_medium" id="confirmPwd_msg"></div>
                </div>
                <div class="button_info clearfix">
                    <input type="button" value="保存" class="btn_save" onclick="save();" />
                    <input type="button" value="取消" class="btn_save" onclick="history.back();"/>
                </div>
            </form>  
        </div>
        <!--主要区域结束-->
         <div id="footer">
            <jsp:include page="/WEB-INF/menu/footer.jsp" />  
        </div>
    </body>
</html>
