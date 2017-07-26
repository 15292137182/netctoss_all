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
        <script type="text/javascript" src="../js/menuDateTime.js"></script>
        <script type="text/javascript" src="../js/clearMsg.js"></script>
        <script language="javascript" type="text/javascript">
        	
        	var flagIdCard;
        	function getIdCard(){
        		flagIdCard=null;
        		$("#account").val("");
				$("#account_id").val("");
        		var idCard=$("#idCard").val().trim();
        		var reg_i=/^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{4}$/;
        		if(!reg_i.test(idCard)){
					$("#idCard_msg").text("身份证无效").addClass("error_msg");
					flagIdCard=false;
					return;
				}
				$.ajax({
					url:"findByIdentityCard.do",
					type:"post",
					dataType:"json",
					data:{"idCard":idCard},
					success:function(data){
						if(data.status==false){
							$("#idCard_msg").text("身份证未注册").addClass("error_msg");
							flagIdCard=false;
							return;
						}
						if(data.status){
							//alert(data.result.real_name);
							$("#idCard_msg").text("身份证有效").removeClass("error_msg");
							$("#account").val(data.result.real_name);
							$("#account_id").val(data.result.account_id);
							flagIdCard=true;
							return;
						}
					},
					error:function(){alert("查询服务升级中...");}
				});
			}
			
			function checkInfo(){
				var ip=$("#unix_host").val().trim();
        		var regIp=/\d+\.\d+\.\d+\.\d+/;
        		if(!regIp.test(ip)){
        			$("#unix_host_msg").text("IP输入有误").addClass("error_msg");
        			return false;
        		}
        		var osName=$("#os_username").val().trim();
        		var regName=/^(?!_)(?![0-9])(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]{2,10}$/;
        		if(!regName.test(osName)){
        			$("#os_username_msg").text("2~10以内的汉字,字母,数字及下划线组成,不能以数字,下划线开头及下划线结尾").addClass("error_msg");
        			return false;
        		}
        		var regPwd=/^[a-zA-Z]\w{5,17}$/;
        		var pwd=$("#login_passwd").val().trim();
        		if(!regPwd.test(pwd)){
        			$("#login_passwd_msg").text("6~18以内的字母,数字,下划线组成,由字母开头").addClass("error_msg");
        			return false;
        		}
        		var confirmPwd=$("#confirm_pwd").val().trim();
        		if(pwd!=confirmPwd){
        			$("#confirm_pwd_msg").text("两次密码不一致").addClass("error_msg");
        			return false;
        		}
        		return true;
			}
        
        	function save(){
        		getIdCard();
        		var timer=setInterval(function(){
        			if(flagIdCard!=null){
        				clearInterval(timer);
        				//alert(flagIdCard+"222");
        				//alert(checkInfo()+"3333");
        				if(checkInfo() & flagIdCard){
        					//alert("++++++++++++++++++++++++++");
        					//alert($("#addServiceForm").serialize());
        					$.ajax({
        						url:"save.do",
        						dataType:"json",
        						type:"post",
        						data:$("#addServiceForm").serialize(),
        						success:function(data){
        							if(data){
        								location.href="findService.do";
        							}
        						},
        						error:function(){alert("业务添加功能升级中...");}
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
            <!--保存操作的提示信息-->
            <div id="save_result_info" class="save_fail"></div>
            <form id="addServiceForm" class="main_form">
                <!--内容项-->
                <div class="text_info clearfix"><span>身份证：</span></div>
                <div class="input_info">
                    <input type="text" onblur="checkIdCard();" id="idCard" onfocus="clearMsg('idCard_msg')" class="width180" />
                    <input type="button" onclick="getIdCard();"  value="查询账务账号" class="btn_search_large" />
                    <span class="required">*</span>
                    <div class="validate_msg_short" id="idCard_msg"></div>
                </div>
                <div class="text_info clearfix"><span>账务账号：</span></div>
                <div class="input_info">
                	<input type="hidden" id="account_id" name="account_id"/>
                    <input type="text" style="color: red;"  readonly="readonly" id="account"  onkeyup="searchAccounts(this);" />
                    <span class="required"></span>
                    <div class="validate_msg_long" id="account_msg"></div>
                </div>
                <div class="text_info clearfix"><span>资费类型：</span></div>
                <div class="input_info">
                    <select name="cost_id">
                    	<c:forEach items="${costs }" var="c">
                        <option value="${c.cost_id }">${c.name }</option>
                        </c:forEach>
                    </select>                        
                </div> 
                <div class="text_info clearfix"><span>服务器 IP：</span></div>
                <div class="input_info">
                    <input type="text" id="unix_host" name="unix_host" onfocus="clearMsg('unix_host_msg')"  />
                    <span class="required">*</span>
                    <div class="validate_msg_long" id="unix_host_msg"></div>
                </div>                   
                <div class="text_info clearfix"><span>登录 OS 账号：</span></div>
                <div class="input_info">
                    <input type="text" id="os_username" name="os_username" onfocus="clearMsg('os_username_msg')" />
                    <span class="required">*</span>
                    <div class="validate_msg_long" id="os_username_msg"></div>
                </div>
                <div class="text_info clearfix"><span>密码：</span></div>
                <div class="input_info">
                    <input type="password"  id="login_passwd" name="login_passwd" onfocus="clearMsg('login_passwd_msg')"/>
                    <span class="required">*</span>
                    <div class="validate_msg_long" id="login_passwd_msg"></div>
                </div>
                <div class="text_info clearfix"><span>重复密码：</span></div>
                <div class="input_info">
                    <input type="password"  id="confirm_pwd" onfocus="clearMsg('confirm_pwd_msg')"/>
                    <span class="required">*</span>
                    <div class="validate_msg_long" id="confirm_pwd_msg"></div>
                </div>     
                <!--操作按钮-->
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
