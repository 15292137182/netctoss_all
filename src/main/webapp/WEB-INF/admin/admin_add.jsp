<%@page pageEncoding="utf-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>达内－NetCTOSS</title>
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global_color.css" />
        <script type="text/javascript" src="../js/jquery-1.11.3.js"></script>
        <script type="text/javascript" src="../js/clearMsg.js"></script>
        <script language="javascript" type="text/javascript">
        	
        	var flag;
        	function checkName(){
        		flag=null;
        		var nickName=$("#name").val().trim();
        		var regAC=/^(?!_)(?![0-9])(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]{2,20}$/;
        		if(!regAC.test(nickName)){
        			$("#name_msg").text("2~20以内的汉字,字母,数字及下划线组成,不能以数字,下划线开头及下划线结尾").addClass("error_msg");
        			flag=false;
        			return;
        		}
        		$.ajax({
        			url:"findByName.do",
        			type:"post",
        			dataType:"json",
        			data:{"name":nickName},
        			success:function(data){
        				if(data.status==1){
        					$("#name_msg").text(data.msg).addClass("error_msg");
        					flag=false;
        					return;
        				}
        				if(data.status==0){
        					$("#name_msg").text(data.msg).removeClass("error_msg");
        					flag=true;
        					return;
        				}
        			},
        			error:function(){alert("查询服务升级中...");}
        		});
        	}
        	
        	function checkFormat(){
        		var realName=$("#admin_code").val().trim();
        		var regAC=/^(?!_)(?![0-9])(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]{2,20}$/;
        		if(!regAC.test(realName)){
        			$("#admin_code_msg").text("2~20以内的汉字,字母,数字及下划线组成,不能以数字,下划线开头及下划线结尾").addClass("error_msg");
        			return false;
        		}
        		var pwd=$("#password").val().trim();
        		var regPwd=/^[a-zA-Z]\w{5,17}$/;
        		if(!regPwd.test(pwd)){
        			$("#password_msg").text("由6~18以内的字母,数字,下划线组成,由字母开头").addClass("error_msg");
        			return false;
        		}
        		var confirmPwd=$("#confirm_pwd").val().trim();
        		if(pwd!=confirmPwd){
        			$("#confirm_pwd_msg").text("两次密码输入不一致").addClass("error_msg");
        			return false;
        		}
        		var tel=$("#telephone").val().trim();
        		var reg_tel = /^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/;
				var reg_t = /(0511-4405222、021-87888822)：\d{3}-\d{8}|\d{4}-\d{7}/;
				if (!reg_tel.test(tel) && !reg_t.test(tel)) {
					$("#telephone_msg").text("手机/固话号码无效").addClass("error_msg");
					return false;
        		}
        		var email=$("#email").val().trim();
        		var regEmail=/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
        		if(!regEmail.test(email)){
        			$("#email_msg").text("email输入有误").addClass("error_msg");
        			return false;
        		}
        		var idsBox=$(":checkbox[name='roleIds']:checked");
        		if(idsBox.length==0){
        			$("#roleIds_msg").text("请至少选择一项").addClass("error_msg");
        			return false;
        		}
            	var ids=new Array();
            	for(var i=0;i<idsBox.length;i++){
            		//alert("+++++++++++");
            		ids.push($(idsBox[i]).val());
            		//alert(ids);
            	}
            	return true;
        	}
        
        	function save(){
				checkFormat();
				var timer=setInterval(function (){
					if(flag!=null){
						clearInterval(timer);
						if(checkFormat() & flag){
							//alert($("#adminAddForm").serialize());
			        		//alert("++++");
			        		$.ajax({
			        			url:"save.do",
			        			type:"post",
			        			dataType:"json",
			        			data:$("#adminAddForm").serialize(),
			        			success:function(data){
			        				//alert("++++++++++");
			        				if(data){
			        					location.href="findAdmin.do";
			        				}
			        			},
			        			error:function(){alert("admin新增功能升级中...");}
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
        <!--主要区域开始-->
        <div id="main">            
            <div id="save_result_info" class="save_success">保存成功！</div>
            <form id="adminAddForm" class="main_form">
                    <div class="text_info clearfix"><span>姓名：</span></div>
                    <div class="input_info">
                        <input type="text" name="admin_code" id="admin_code" onfocus="clearMsg('admin_code_msg')"/>
                        <span class="required">*</span>
                        <div class="validate_msg_long" id="admin_code_msg"></div>
                    </div>
                    <div class="text_info clearfix"><span>管理员账号：</span></div>
                    <div class="input_info">
                        <input onblur="checkName();" type="text"  name="name" id="name" onfocus="clearMsg('name_msg')"/>
                        <span class="required">*</span>
                        <div class="validate_msg_long" id="name_msg"></div>
                    </div>
                    <div class="text_info clearfix"><span>密码：</span></div>
                    <div class="input_info">
                        <input type="password"  name="password" id="password" onfocus="clearMsg('password_msg')"/>
                        <span class="required">*</span>
                        <div class="validate_msg_long error_msg" id="password_msg"></div>
                    </div>
                    <div class="text_info clearfix"><span>重复密码：</span></div>
                    <div class="input_info">
                        <input type="password"  id="confirm_pwd" onfocus="clearMsg('confirm_pwd_msg')"/>
                        <span class="required">*</span>
                        <div class="validate_msg_long error_msg" id="confirm_pwd_msg"></div>
                    </div>      
                    <div class="text_info clearfix"><span>电话：</span></div>
                    <div class="input_info">
                        <input type="text" class="width200" name="telephone" id="telephone" onfocus="clearMsg('telephone_msg')"/>
                        <span class="required">*</span>
                        <div class="validate_msg_medium error_msg" id="telephone_msg"></div>
                    </div>
                    <div class="text_info clearfix"><span>Email：</span></div>
                    <div class="input_info">
                        <input type="text" class="width200" id="email" name="email" onfocus="clearMsg('email_msg')"/>
                        <span class="required">*</span>
                        <div class="validate_msg_medium error_msg" id="email_msg"></div>
                    </div>
                    <div class="text_info clearfix"><span>角色：</span></div>
                    <div class="input_info_high">
                        <div class="input_info_scroll">
                            <ul>
                            	<c:forEach items="${roles }" var="r">
                               	 <li><input name="roleIds" value="${r.role_id }" onfocus="clearMsg('roleIds_msg')" type="checkbox"  />${r.name }</li>
                                </c:forEach>
                            </ul>
                        </div>
                        <span class="required">*</span>
                        <div class="validate_msg_tiny error_msg" id="roleIds_msg"></div>
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
