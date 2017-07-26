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
        
        	function checkRole(){
        		var name=$("#name").val().trim();
            	var regName=/^(?!_)(?![0-9])(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]{2,20}$/;
            	if(!regName.test(name)){
            		$("#name_msg").text("2~20以内的汉字,字母,数字及下划线组成,不能以数字,下划线开头及下划线结尾").addClass("error_msg");
            		return;
            	}
        		$.ajax({
        			url:"findByRoleName.do",
        			type:"post",
        			dataType:"json",
        			data:{"name":name},
        			success:function(data){
        				if(data.status==false){
        					$("#name_msg").text("角色名无效").addClass("error_msg");
        					return;
        				}
        				if(data.status){
        					$("#name_msg").text("角色名有效").removeClass("error_msg");
        				}
        			},
        			error:function(){$("#name_msg").text("查询服务升级中..").addClass("error_msg");}
        		});
        	}
        	
            function updateRole(){
            	
            	var chboxObj=$(":checkbox[name='moduleIds']:checked");
            	//alert(chboxObj.length);
            	if(chboxObj.length==0){
            		$("#module_id_msg").text("请至少选择一项").addClass("error_msg");
            		return;
            	}
            	var idArr=new Array();
            	for(var i=0;i<chboxObj.length;i++){
            		var moduleId=$(chboxObj[i]);
            		var id=moduleId.val();
            		idArr.push(id);
            		//alert(id);
            	}
            	//alert(idArr);
            	//alert($("#roleForm").serialize());
            	$.ajax({
            		url:"updateRole.do",
            		type:"post",
            		dataType:"json",
            		data:$("#roleForm").serialize(),
            		success:function(data){
            			if(data){
            				location.href="findRole.do";
            			}
            		},
            		error:function(){$("module_id_msg").text("role新增功能升级中..").addClass("error_msg");}
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
            <div id="save_result_info" class="save_success">保存成功！</div>
            <form id="roleForm" class="main_form">
                <div class="text_info clearfix"><span>角色名称：</span></div>
                <div class="input_info">
                	<input type="hidden" name="role_id" value="${role.role_id }"/>
                    <input onblur="checkRole();" id="name" name="name" onfocus="clearMsg('name_msg');" type="text" class="width200" value="${role.name }" />
                    <span class="required">*</span>
                    <div class="validate_msg_medium error_msg" id="name_msg"></div>
                </div>                    
                <div class="text_info clearfix"><span>设置权限：</span></div>
                <div class="input_info_high">
                    <div class="input_info_scroll">
                        <ul>
                        <c:forEach items="${modules }" var="m">
                      	  	<li><input onfocus="clearMsg('module_id_msg');" type="checkbox" id="module_id" name="moduleIds" value="${m.module_id }"
                      	  		<c:forEach items="${modulesOfRole }" var="mr">
                        			<c:if test="${m.module_id==mr.module_id }"> checked</c:if>
                        		</c:forEach>
                      	  	/>${m.name }</li>
                           </c:forEach>
                        </ul>
                    </div>
                    <span class="required">*</span>
                    <div class="validate_msg_tiny" id="module_id_msg"></div>
                </div>
                <div class="button_info clearfix">
                    <input type="button" value="保存" class="btn_save" onclick="updateRole();" />
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
