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
        <script language="javascript" type="text/javascript">
        	
        	function page_search_submit(){
        		var page=$("#search_page").val().trim();
        		//alert(page);
        		var reg=/^\d{0,3}$/;
        		$("#search_page_msg").text("");
        		if(!reg.test(page)){
        			$("#search_page_msg").val("输入有误");
        			return;
        		}
        		if(page=="" || page==0){
        			page=1;
        		}
        		location.href="findRole.do?currentPage="+page;
        	}
        
            function deleteRole(id) {
                var r = window.confirm("确定要删除此角色吗？");
                //document.getElementById("operate_result_info").style.display = "block";
                if(r){
                	$.ajax({
                		url:"deleteRole.do",
                		type:"post",
                		dataType:"json",
                		data:{"id":id},
                		success:function(data){
                			if(data.status==1){
                				document.getElementById("operate_result_info").style.display = "block";
                				$("#operate_result_info").text(data.msg);
                				setTimeout(function(){
                					location.href="findRole.do";
                				},3000);
                			}
                			if(data.status==0){
                				document.getElementById("operate_result_info").style.display = "block";
                				$("#operate_result_info").text(data.msg);
                				setTimeout(function(){
                					location.href="findRole.do";
                				},3000);
                			}
                		},
                		error:function(){alert("删除功能升级中..");}
                	});
                }
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
            <form action="" method="">
                <!--查询-->
                <div class="search_add">
                    <input type="button" value="增加" class="btn_add" onclick="location.href='toAdd.do';" />
                </div>  
                <!--删除的操作提示-->
                <div id="operate_result_info" class="operate_success">
                    <img src="../images/close.png" onclick="this.parentNode.style.display='none';" />
                </div> <!--删除错误！该角色被使用，不能删除。-->
                <!--数据区域：用表格展示数据-->     
                <div id="data">                      
                    <table id="datalist">
                        <tr>                            
                            <th>角色 ID</th>
                            <th>角色名称</th>
                            <th class="width600">拥有的权限</th>
                            <th class="td_modi"></th>
                        </tr>    
                        <c:forEach items="${roles }" var="r">              
                        <tr>
                            <td>${r.role_id }</td>
                            <td>${r.name }</td>
                            <td>
                            	<c:forEach items="${r.modules }" var="m" varStatus="s">
                            		<c:choose>
                            			<c:when test="${s.last }">
                            				${m.name }
                            			</c:when>
                            			<c:otherwise>${m.name },</c:otherwise>
                            		</c:choose>
                            	
                            	</c:forEach>
                            </td>
                            <td>
                                <input type="button" value="修改" class="btn_modify" onclick="location.href='toModify.do?id=${r.role_id}';"/>
                                <input type="button" value="删除" class="btn_delete" onclick="deleteRole('${r.role_id}');" />
                            </td>
                        </tr>
                        </c:forEach>    
                    </table>
                </div> 
                <!--分页-->
                <div id="pages">
                   	<a href="findRole.do?currentPage=1">首页</a>
                	<c:choose>
                		<c:when test="${rolePage.currentPage==1 }">
                			<a href="#">上一页</a>
                		</c:when>
                		<c:otherwise>
                			<a href="findRole.do?currentPage=${rolePage.currentPage-1 }">上一页</a>
                		</c:otherwise>
                	</c:choose>
        	        <c:forEach begin="1" end="${rolePage.totalPage }" var="i">
        	        	<c:choose>
        	        		<c:when test="${rolePage.currentPage==i }">
        	        			<a href="findRole.do?currentPage=${i }" class="current_page">${i }</a>
        	        		</c:when>
        	        		<c:otherwise>
        	        			<a href="findRole.do?currentPage=${i }">${i }</a>
        	        		</c:otherwise>
        	        	</c:choose>
                   	</c:forEach>
                   <c:choose>
                		<c:when test="${rolePage.currentPage==rolePage.totalPage }">
                			<a href="#">下一页</a>
                		</c:when>
                		<c:otherwise>
                			<a href="findRole.do?currentPage=${rolePage.currentPage+1 }">下一页</a>
                		</c:otherwise>
                	</c:choose>
                	<a href="findRole.do?currentPage=${rolePage.totalPage }">末页</a>
                	<input id="search_page" type="text" style="width: 50px;height: 25px;"/>
                	<input type="button" onclick="page_search_submit();" style="width: 50px;height: 25px;color: red;" value="search"/>
                	<input id="search_page_msg" value="共 ${rolePage.totalPage } 页" 
                		type="text" style="width: 50px;height: 25px;color: red;" readonly="readonly"/>
                </div>                    
            </form>
        </div>
        <!--主要区域结束-->
         <div id="footer">
            <jsp:include page="/WEB-INF/menu/footer.jsp" />  
        </div>
    </body>
</html>
