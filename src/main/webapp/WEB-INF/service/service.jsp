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
        		location.href="findService.do?currentPage="+page;
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
            
            function updateDelete(id) {
            	//alert("id: "+id);
                var r = window.confirm("确定要删除此业务账号吗?");
                if(r){
                	$.ajax({
                		url:"updateDelete.do",
                		dataType:"json",
                		type:"post",
                		data:{"id":id},
                		success:function(data){
                			if(data){
								$("#operate_result_info").text("删除此业务账号成功~");
								$("#operate_result_info").show();
                				setTimeout(function(){
                					$("#operate_result_info").hide();
                					location.href="findService.do";
                				},2000);
                			}
                		},
                		error:function(){alert("删除功能维护中..");}
                	});
                }
            }
            
            function updateStart(id) {
            	//alert("id: "+id);
                var r = window.confirm("确定要开通此业务账号吗?");
                if(r){
                	$.ajax({
                		url:"updateStart.do",
                		dataType:"json",
                		type:"post",
                		data:{"id":id},
                		success:function(data){
                			if(data.status==1){
								$("#operate_result_info").text(data.msg);
								$("#operate_result_info").show();
                				setTimeout(function(){
                					$("#operate_result_info").hide();
                					location.href="findService.do";
                				},2000);
                			}
                			if(data.status==0){
								$("#operate_result_info").text(data.msg);
								$("#operate_result_info").show();
                				setTimeout(function(){
                					$("#operate_result_info").hide();
                					location.href="findService.do";
                				},2000);
                			}
                		},
                		error:function(){alert("开通功能维护中..");}
                	});
                }
            }
            
            function updatePause(id) {
            	//alert("id: "+id);
                var r = window.confirm("确定要暂停此业务账号吗?");
                if(r){
                	$.ajax({
                		url:"updatePause.do",
                		dataType:"json",
                		type:"post",
                		data:{"id":id},
                		success:function(data){
                			if(data){
								$("#operate_result_info").text("暂停此业务账号成功~");
								$("#operate_result_info").show();
                				setTimeout(function(){
                					$("#operate_result_info").hide();
                					location.href="findService.do";
                				},2000);
                			}
                		},
                		error:function(){alert("暂停功能维护中..");}
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
            <form action="findService.do" method="post">
            	<input type="hidden" name="currentPage" value="1"/>
                <!--查询-->
                <div class="search_add">                        
                    <div>OS 账号：<input name="oSAccount" type="text" value="${servicePage.oSAccount }" class="width100 text_search" /></div>                            
                    <div>服务器 IP：<input name="unixHost" type="text" value="${servicePage.unixHost }" class="width100 text_search" /></div>
                    <div>身份证：<input name="identityCard" type="text"  value="${servicePage.identityCard }" class="text_search" /></div>
                    <div>状态：
                        <select class="select_search" name="status">
                            <option value="-1">全部</option>
                            <option value="0" <c:if test="${servicePage.status==0 }">selected</c:if>>开通</option>
                            <option value="1" <c:if test="${servicePage.status==1 }">selected</c:if>>暂停</option>
                            <option value="2" <c:if test="${servicePage.status==2 }">selected</c:if>>删除</option>
                        </select>
                    </div>
                    <div><input type="submit" value="搜索" class="btn_search" /></div>
                    <input type="button" value="增加" class="btn_add" onclick="location.href='toAdd.do';" />
                </div>  
                <!--删除的操作提示-->
                <div id="operate_result_info" class="operate_success">
                    <img src="../images/close.png" onclick="this.parentNode.style.display='none';" />
                </div>   
                <!--数据区域：用表格展示数据-->     
                <div id="data">            
                    <table id="datalist">
                    <tr>
                        <th class="width50">业务ID</th>
                        <th class="width70">账务账号ID</th>
                        <th class="width150">身份证</th>
                        <th class="width70">姓名</th>
                        <th>OS 账号</th>
                        <th class="width50">状态</th>
                        <th class="width100">服务器 IP</th>
                        <th class="width100">资费</th>                                                        
                        <th class="width200"></th>
                    </tr>
					<c:forEach items="${services }" var="s">
                    <tr>
                        <td><a style="color: blue;" href="findDetail.do?id=${s.SERVICE_ID }" title="查看明细">${s.SERVICE_ID }</a></td>
                        <td>${s.ACCOUNT_ID }</td>
                        <td>${s.IDCARD_NO }</td>
                        <td>${s.REAL_NAME }</td>
                        <td>${s.OS_USERNAME }</td>
                        <td>
                        	<c:if test="${s.STATUS==0 }">开通</c:if>
                        	<c:if test="${s.STATUS==1 }">暂停</c:if>
                        	<c:if test="${s.STATUS==2 }">删除</c:if>
                        </td>
                        <td>${s.UNIX_HOST }</td>
                        <td>
                            <a class="summary"  onmouseover="showDetail(true,this);" onmouseout="showDetail(false,this);">${s.NAME }</a>
                            <!--浮动的详细信息-->
                            <div class="detail_info">
                                ${s.DESCR }
                            </div>
                        </td>                            
                        <td class="td_modi">
                        	<c:if test="${s.STATUS==0 }">
                        		 <input type="button" value="暂停" class="btn_pause" onclick="updatePause('${s.SERVICE_ID}');" />
                           		 <input type="button" value="修改" class="btn_modify" onclick="location.href='toModify.do';" />
                           		 <input type="button" value="删除" class="btn_delete" onclick="updateDelete(${s.SERVICE_ID});" />
                        	</c:if>
                        	<c:if test="${s.STATUS==1 }">
                        		 <input type="button" value="开通" class="btn_start" onclick="updateStart('${s.SERVICE_ID}');" />
                           		 <input type="button" value="修改" class="btn_modify" onclick="location.href='toModify.do';" />
                           		 <input type="button" value="删除" class="btn_delete" onclick="updateDelete(${s.SERVICE_ID});" />
                        	</c:if>
                        </td>
                    </tr>     
                    </c:forEach>                                                           
                </table>                
                <p>业务说明：<br />
                1、创建即开通，记载创建时间；<br />
                2、暂停后，记载暂停时间；<br />
                3、重新开通后，删除暂停时间；<br />
                4、删除后，记载删除时间，标示为删除，不能再开通、修改、删除；<br />
                5、业务账号不设计修改密码功能，由用户自服务功能实现；<br />
                6、暂停和删除状态的账务账号下属的业务账号不能被开通。</p>
                </div>                    
               <!--分页-->
			<div id="pages">
				<a href="findService.do?currentPage=1">首页</a>
				<c:choose>
					<c:when test="${servicePage.currentPage==1 }">
						<a href="#">上一页</a>
					</c:when>
					<c:otherwise>
						<a href="findService.do?currentPage=${servicePage.currentPage-1 }">上一页</a>
					</c:otherwise>
				</c:choose>
				<c:forEach begin="1" end="${servicePage.totalPage }" var="i">
					<c:choose>
						<c:when test="${servicePage.currentPage==i }">
							<a href="findService.do?currentPage=${i }" class="current_page">${i}</a>
						</c:when>
						<c:otherwise>
							<a href="findService.do?currentPage=${i }">${i }</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:choose>
					<c:when test="${servicePage.currentPage==servicePage.totalPage }">
						<a href="#">下一页</a>
					</c:when>
					<c:otherwise>
						<a href="findService.do?currentPage=${servicePage.currentPage+1 }">下一页</a>
					</c:otherwise>
				</c:choose>
				<a href="findService.do?currentPage=${servicePage.totalPage }">末页</a> <input
					id="search_page" type="text" style="width: 50px;height: 25px;" />
				<input readonly="readonly" type="button" onclick="page_search_submit();" style="width: 50px;height: 25px;color: red;" value="search" />
				 <input	id="search_page_msg" value="共 ${servicePage.totalPage } 页" type="text"
					style="width: 50px;height: 25px;color: red;" readonly="readonly" />
			</div>  
            </form>
        </div>
        <!--主要区域结束-->
         <div id="footer">
            <jsp:include page="/WEB-INF/menu/footer.jsp" />  
        </div>
    </body>
</html>
