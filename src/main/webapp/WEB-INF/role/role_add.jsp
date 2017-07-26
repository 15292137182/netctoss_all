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
        
        	function save(){
        		checkRole();
        		var timer=setInterval(function(){
        			if(flag!=null){
        				clearInterval(timer);
        				if(flag & getModuleIds() ){
        					var param=$("#roleAddForm").serialize();
        					//alert(param);
        					$.ajax({
        						url:"save.do",
        						type:"post",
        						dataType:"json",
        						data:param,
        						success:function(data){
        							if(data){
        								location.href="findRole.do";
        							}
        						},
        						error:function(){alert("角色添加功能升级中...");}
        					});
        				}
        			}else{
        				alert("请检查输入是否完毕!");
        			}
        		},300);
        	}
        
        	function getModuleIds(){
        		
        		var moduleIds = $(":checkbox[name='moduleIds']:checked");
            	//alert(moduleIds.length);
            	//alert(moduleIds);
            	if(moduleIds.length==0){
            		$("#choose_msg").text("请至少选择一项").addClass("error_msg");
            		return false;
            	}
            	var ids=new Array();
            	for(var i=0;i<moduleIds.length;i++){
            		//alert("+++++++++++");
            		ids.push($(moduleIds[i]).val());
            	}
            	return true;
            	//alert(ids);
        	}
        	
        	var flag;
            function checkRole(){
            	flag=null;
            	var name=$("#name").val().trim();
            	var regName=/^(?!_)(?![0-9])(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]{2,20}$/;
            	if(!regName.test(name)){
            		$("#name_msg").text("2~20以内的汉字,字母,数字及下划线组成,不能以数字,下划线开头及下划线结尾").addClass("error_msg");
            		flag=false;
            		return;
            	}
            	$.ajax({
            		url:"findByRoleName.do",
            		type:"post",
            		dataType:"json",
            		data:{"name":name},
            		success:function(data){
            			if(data.status==false){
            				$("#name_msg").text(data.msg).addClass("error_msg");
            				flag=false;
            				return;
            			}
            			if(data.status){
            				$("#name_msg").text(data.msg).removeClass("error_msg");
            				flag=true;
            				return;
            			}
            		},
            		error:function(){alert("查询服务升级中...");}
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
            <div id="save_result_info" class="save_success">保存成功！</div><!--保存失败，角色名称重复！-->
            <form id="roleAddForm" class="main_form">
                <div class="text_info clearfix"><span>角色名称：</span></div>
                <div class="input_info">
                    <input type="text" id="name" name="name" onblur="checkRole();" onfocus="clearMsg('name_msg');" class="width200" />
                    <span class="required">*</span>
                    <div class="validate_msg_medium" id="name_msg"></div>
                </div>                    
                <div class="text_info clearfix"><span>设置权限：</span></div>
                <div class="input_info_high">
                    <div class="input_info_scroll">
                        <ul>
                        	<c:forEach  items="${modules }" var="m">
                           		 <li><input onfocus="clearMsg('choose_msg')" type="checkbox" name="moduleIds" value="${m.module_id }"/>${m.name }</li>
                            </c:forEach>
                        </ul>
                    </div>
                    <span class="required">*</span>
                    <div class="validate_msg_tiny" id="choose_msg"></div>
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
