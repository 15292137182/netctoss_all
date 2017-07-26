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
            	var ids=$(":checkbox[name='roleIds']:checked");
            	if(ids.length==0){
            		$("#roleIds_msg").text("请至少选择一项").addClass("error_msg");
            		return;
            	}
            	var idsArr=new Array();
            	for(var i=0;i<ids.length;i++){
            		var id=$(ids[i]).val();
            		idsArr.push(id);
            	}
            	//alert(idsArr);
            	//alert($("#adminModifyForm").serialize());
            	$.ajax({
            		url:"updateAdmin.do",
            		type:"post",
            		dataType:"json",
            		data:$("#adminModifyForm").serialize(),
            		success:function(data){
            			if(data){
            				location.href="findAdmin.do";
            			}
            		},
            		error:function(){alert("admin修改功能升级中...");}
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
            <div id="save_result_info" class="save_success">保存成功！</div>
            <form id="adminModifyForm" class="main_form">
            		<input type="hidden" name="admin_id" value="${admin.admin_id }"/> 
                    <div class="text_info clearfix"><span>姓名：</span></div>
                    <div class="input_info">
                        <input type="text" name="name" id="name" onfocus="clearMsg('name_msg')" value="${admin.name }" />
                        <span class="required">*</span>
                        <div class="validate_msg_long error_msg" id="name_msg"></div>
                    </div>
                    <div class="text_info clearfix"><span>管理员账号：</span></div>
                    <div class="input_info"><input type="text" readonly="readonly" class="readonly" value="${admin.admin_code }"  /></div>
                    <div class="text_info clearfix"><span>电话：</span></div>
                    <div class="input_info">
                        <input id="telephone" name="telephone" onfocus="clearMsg('telephone_msg')" type="text" value="${admin.telephone }"  />
                        <span class="required">*</span>
                        <div class="validate_msg_long error_msg" id="telephone_msg"></div>
                    </div>
                    <div class="text_info clearfix"><span>Email：</span></div>
                    <div class="input_info">
                        <input id="email" name="email" onfocus="clearMsg('email_msg')" type="text" class="width200" value="${admin.email }"/>
                        <span class="required">*</span>
                        <div class="validate_msg_medium error_msg" id="email_msg"></div>
                    </div>
                    <div class="text_info clearfix"><span>角色：</span></div>
                    <div class="input_info_high">
                        <div class="input_info_scroll">
                            <ul>
                            	<c:forEach items="${roles }" var="r">
                               		 <li><input id="roleIds" name="roleIds" value="${r.role_id }" onfocus="clearMsg('roleIds_msg')" type="checkbox" 
                               		 	<c:forEach items="${rolesOfAdmin }" var="ar">
                            				<c:if test="${r.role_id==ar.role_id }">checked</c:if>
                            			</c:forEach>
                               		 />${r.name }</li>
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
        <!--主要区域结束-->
         <div id="footer">
            <jsp:include page="/WEB-INF/menu/footer.jsp" />  
        </div>
    </body>
</html>
