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
        <script language="javascript" type="text/javascript">
        	$(function(){
        		//alert("+++");
        		var adminId=$("#admin_id").val().trim();
        		//alert("id: "+adminId);
        		$.ajax({
        			url:"findRole.do",
        			type:"post",
        			dataType:"json",
        			data:{"id":adminId},
        			success:function(data){
        				if(data.status==true){
        					//alert(data.data);
        					$("#adminOfRoles").val(data.data);
        				}
        			},
        			error:function(){alert("用户信息系统维护中..");}
        		});
        	});
        	
        	function save(){
        		var name=$("#name").val().trim();
        		var regName=/^(?!_)(?![0-9])(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]{2,20}$/;
        		if(!regName.test(name)){
        			$("#name_msg").text("2~20以内的汉字,字母,数字及下划线组成,不能以数字,下划线开头及下划线结尾").addClass("error_msg");
        			return;
        		}
        		var telephone=$("#telephone").val().trim();
            	var reg_tel = /^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/;
				var reg_t = /(0511-4405222、021-87888822)：\d{3}-\d{8}|\d{4}-\d{7}/;
				if (!reg_tel.test(telephone) && !reg_t.test(telephone)) {
					$("#telephone_msg").text("手机/固话号码无效").addClass("error_msg");
					return;
            	}
            	var email=$("#email").val().trim();
            	var regEmail=/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
            	if(!regEmail.test(email)){
            		$("#email_msg").text("email格式无效").addClass("error_msg");
            		return;
            	}
            	//alert($("#userForm").serialize());
            	$.ajax({
            		url:"updateAdmin.do",
            		type:"post",
            		dataType:"json",
            		data:$("#userForm").serialize(),
            		success:function(data){
            			if(data){
            				$("#save_result_info").text("个人信息更新成功~");
            				$("#save_result_info").show();
            				setTimeout(function(){
            					$("#save_result_info").hide();
            					location.href="findUserInfo.do";
            				},3000);
            			}
            		},
            		error:function(){alert("用户信息更新失败..");}
            	});
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
        <!--主要区域开始-->
        <div id="main">            
            <!--保存操作后的提示信息：成功或者失败-->
            <div id="save_result_info" class="save_success">保存成功！</div><!--保存失败，数据并发错误！-->
            <form id="userForm"  class="main_form">
            	<input id="admin_id" name="admin_id" type="hidden" value="${currentAdmin.admin_id }"/>
                <div class="text_info clearfix"><span>管理员账号：</span></div>
                <div class="input_info"><input type="text" readonly="readonly" class="readonly" value="${currentAdmin.admin_code }" /></div>
                <div class="text_info clearfix"><span>角色：</span></div>
                <div class="input_info">
                    <input id="adminOfRoles" type="text" readonly="readonly" class="readonly width400"  />
                </div>
                <div class="text_info clearfix"><span>姓名：</span></div>
                <div class="input_info">
                    <input id="name" name="name" onfocus="clearMsg('name_msg')" type="text" value="${currentAdmin.name }" />
                    <span class="required">*</span>
                    <div class="validate_msg_long error_msg" id="name_msg"></div>
                </div>
                <div class="text_info clearfix"><span>电话：</span></div>
                <div class="input_info">
                    <input id="telephone" onfocus="clearMsg('telephone_msg');" name="telephone" type="text" class="width200" value="${currentAdmin.telephone }" />
                    <div class="validate_msg_medium" id="telephone_msg"></div>
                </div>
                <div class="text_info clearfix"><span>Email：</span></div>
                <div class="input_info">
                    <input id="email" onfocus="clearMsg('email_msg');" name="email" type="text" class="width200" value="${currentAdmin.email }" />
                    <div class="validate_msg_medium" id="email_msg"></div>
                </div>
                <div class="text_info clearfix"><span>创建时间：</span></div>
                <div class="input_info"><input type="text" readonly="readonly" class="readonly" 
                
                value="<fmt:formatDate value="${currentAdmin.enrolldate }" pattern="yyyy-MM-dd hh:mm:ss" />"/></div>
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

