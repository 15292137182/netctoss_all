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
        		location.href="findAdmin.do?currentPage="+page;
        	}
        
        
            //显示角色详细信息
            function showDetail(flag, a) {
                var detailDiv = a.parentNode.getElementsByTagName("div")[0];
                if (flag) {
                    detailDiv.style.display = "block";
                }
                else
                    detailDiv.style.display = "none";
            }
            //重置密码
            function resetPwd() {
            	var r=window.confirm("确定要重置密码吗?");
            	if(r){
            		var chboxObjs=$(":checkbox[name='all_admin_checkbox']:checked");
            		//alert(chboxObjs.length);
            		if(chboxObjs.length==0){
            			alert("请至少选择一条数据！");
            			return;
            		}
            		var ids=new Array();
            		for(var i=0;i<chboxObjs.length;i++){
            			var chboxObj=$(chboxObjs[i]);
            			var trObj=chboxObj.parent().parent();
            			var thObj=trObj.children().eq(1);
            			var id=thObj.text();
            			//alert(id);
            			ids.push(id);
            		}
            		//alert(ids);
            		$.ajax({
            			url:"updatePwd.do",
            			type:"post",
            			dataType:"json",
            			data:{"ids":ids.toString()},
            			success:function(data){
            				if(data.status==0){
            					$("#operate_msg").text(data.msg);
            					//alert(data.msg);
            					$("#operate_result_info").show();
            					setTimeout(function(){
            						$("#operate_result_info").hide();
            						location.href="findAdmin.do";
            					},2000);
            				}
            			},
            			error:function(){alert("重置密码功能升级中...");}
            		});
            	}
            }
            //删除
            function deleteAdmin(id) {
                var r = window.confirm("确定要删除此管理员吗？");
                //document.getElementById("operate_result_info").style.display = "block";
                if(r){
                	$.ajax({
                		url:"deleteAdmin.do",
                		type:"post",
                		dataTpe:"json",
                		data:{"id":id},
                		success:function(data){
                			if(data){
                				$("#operate_msg").text("删除成功!");
                				$("#operate_result_info").show();
                				setTimeout(function(){
                					$("#operate_result_info").hide();
                					location.href="findAdmin.do";
                				},2000);
                			}
                		},
                		error:function(){
                			alert("删除服务升级中...");
                		}
                	});
                }
            }
            //全选
            function selectAdmins(inputObj) {
                var inputArray = document.getElementById("datalist").getElementsByTagName("input");
                for (var i = 1; i < inputArray.length; i++) {
                    if (inputArray[i].type == "checkbox") {
                        inputArray[i].checked = inputObj.checked;
                    }
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
            <form action="findAdmin.do?currentPage=1" method="post">
                <!--查询-->
                <div class="search_add">
                    <div>
                        模块：
                        <select name="moduleId" id="selModules" class="select_search">
                            <option value="-1">全部</option>
                            <c:forEach items="${modules }" var="m">
                            	
                           		 <option value="${m.module_id }" 
                           		 	<c:if test="${m.module_id==adminPage.moduleId }">selected</c:if>
                           		 	>${m.name }</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div>角色：<input type="text" name="roleName" value="${adminPage.roleName }" class="text_search width200" /></div>
                    <div><input type="submit" value="搜索" class="btn_search"/></div>
                    <input type="button" value="密码重置" class="btn_add" onclick="resetPwd();" />
                    <input type="button" value="增加" class="btn_add" onclick="location.href='toAdd.do';" />
                </div>
                <!--删除和密码重置的操作提示-->
                <div id="operate_result_info" class="operate_success">
                    <img src="../images/close.png" onclick="this.parentNode.style.display='none';" />
                    <span id="operate_msg"></span><!--密码重置失败！数据并发错误。-->
                </div> 
                <!--数据区域：用表格展示数据-->     
                <div id="data">            
                    <table id="datalist">
                        <tr>
                            <th class="th_select_all">
                                <input type="checkbox" onclick="selectAdmins(this);" />
                                <span>全选</span>
                            </th>
                            <th>管理员ID</th>
                            <th>姓名</th>
                            <th>登录名</th>
                            <th>电话</th>
                            <th>电子邮件</th>
                            <th>授权日期</th>
                            <th class="width100">拥有角色</th>
                            <th></th>
                        </tr>    
                        <c:forEach items="${admins }"  var="a">                  
                        <tr>
                            <td><input name="all_admin_checkbox" type="checkbox" /></td>
                            <td>${a.admin_id }</td>
                            <td>${a.admin_code }</td>
                            <td>${a.name }</td>
                            <td>${a.telephone }</td>
                            <td>${a.email }</td>
                            <td>
                            	<fmt:formatDate value="${a.enrolldate }" pattern="yyyy-MM-dd hh:mm:ss" />
                            </td>
                            <td>
                                <a class="summary"  onmouseover="showDetail(true,this);" onmouseout="showDetail(false,this);">
                                	<c:forEach items="${a.roles }" var="r" varStatus="s">
                                		<c:choose>
                                			<c:when test="${s.first}">${r.name }</c:when>
                                			<c:when test="${s.index==1 }">...</c:when>
                                		</c:choose>
                                	</c:forEach>
                                </a>
                                <!--浮动的详细信息-->
                                <div class="detail_info">
                                   <c:forEach items="${a.roles }" var="r" varStatus="s">
                                		<c:choose>
                                			<c:when test="${s.last}">${r.name }</c:when>
                                			<c:otherwise>${r.name },</c:otherwise>
                                		</c:choose>
                                	</c:forEach>
                                </div>
                            </td>
                            <td class="td_modi">
                                <input type="button" value="修改" class="btn_modify" onclick="location.href='toModify.do?id=${a.admin_id}';" />
                                <input type="button" value="删除" class="btn_delete" onclick="deleteAdmin('${a.admin_id}');" />
                            </td>
                        </tr>
						</c:forEach>
                    </table>
                </div>
                <!--分页-->
                <div id="pages">
                	<a href="findAdmin.do?currentPage=1">首页</a>
                	<c:choose>
                		<c:when test="${adminPage.currentPage==1 }">
                			<a href="#">上一页</a>
                		</c:when>
                		<c:otherwise>
                			<a href="findAdmin.do?currentPage=${adminPage.currentPage-1 }">上一页</a>
                		</c:otherwise>
                	</c:choose>
        	        <c:forEach begin="1" end="${adminPage.totalPage }" var="i">
        	        	<c:choose>
        	        		<c:when test="${adminPage.currentPage==i }">
        	        			<a href="findAdmin.do?currentPage=${i }" class="current_page">${i }</a>
        	        		</c:when>
        	        		<c:otherwise>
        	        			<a href="findAdmin.do?currentPage=${i }">${i }</a>
        	        		</c:otherwise>
        	        	</c:choose>
                   	</c:forEach>
                   <c:choose>
                		<c:when test="${adminPage.currentPage==adminPage.totalPage }">
                			<a href="#">下一页</a>
                		</c:when>
                		<c:otherwise>
                			<a href="findAdmin.do?currentPage=${adminPage.currentPage+1 }">下一页</a>
                		</c:otherwise>
                	</c:choose>
                	<a href="findAdmin.do?currentPage=${adminPage.totalPage }">末页</a>
                	<input id="search_page" type="text" style="width: 50px;height: 25px;"/>
                	<input type="button" onclick="page_search_submit();" style="width: 50px;height: 25px;color: red;" value="search"/>
                	<input id="search_page_msg" value="共 ${adminPage.totalPage } 页" 
                		type="text" style="width: 50px;height: 25px;color: red;"  readonly="readonly"/>
                </div>                    
            </form>
        </div>
        <!--主要区域结束-->
         <div id="footer">
            <jsp:include page="/WEB-INF/menu/footer.jsp" />  
        </div>
    </body>
</html>
