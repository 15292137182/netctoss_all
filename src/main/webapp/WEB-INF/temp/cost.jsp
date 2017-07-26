<%@page pageEncoding="utf-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>－NetCTOSS</title>
<link type="text/css" rel="stylesheet" media="all"
	href="../styles/global.css" />
<link type="text/css" rel="stylesheet" media="all"
	href="../styles/global_color.css" />
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
        		location.href="findCost.do?currentPage="+page;
        	}

            //启用
            function startFee(id) {
                var r = window.confirm("确定要启用此资费吗？资费启用后将不能修改和删除。");
                //alert("id: "+id);
                if(r){
                	$.ajax({
                		url:"updateStatus.do",
                		type:"post",
                		dataType:"json",
                		data:{"id":id},
                		success:function(data){
                			if(data){
                				$("#operate_result_info").text("启用成功~");
                				$("#operate_result_info").show();
                				setTimeout(function(){
                					$("#operate_result_info").hide();
                					location.href="findCost.do";
                				},2000);
                			}
                		},
                		error:function(){alert("资费启用功能升级中...");}
                	});
                }
            }
            //删除
            function deleteFee(id) {
                var r = window.confirm("确定要删除此资费吗？");
                if(r){
                	$.ajax({
                		url:"delete.do",
                		type:"post",
                		dataType:"json",
                		data:{"id":id},
                		success:function(data){
                			if(data){
                				$("#operate_result_info").text("删除成功~");
                				$("#operate_result_info").show();
                				setTimeout(function(){
                					$("#operate_result_info").hide();
                					location.href="findCost.do";
                				},2000);
                			}
                		},
                		error:function(){alert("资费删除功能升级中...");}
                	});
                }
            }
            
            //排序按钮的点击事件
            function sort(btnObj) {
                if (btnObj.className == "sort_desc") {
                    btnObj.className = "sort_asc";
                } else {
                    btnObj.className = "sort_desc";
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
		<form id="costForm" action="findCost.do" method="post">
			<!--排序-->
			<div class="search_add">
			 <div>
                 <!--<input type="button" value="月租" class="sort_asc" onclick="sort(this);" />-->
                 <input type="button" value="基费"  class="sort_asc" onclick="sort(this);" />
                 <input type="button" value="时长"  class="sort_asc" onclick="sort(this);" />
             </div>
				<input type="button" value="增加" class="btn_add"
					onclick="location.href='toAdd.do';" />
			</div>
			<!--启用操作的操作提示-->
			<div id="operate_result_info" class="operate_success">
				<img src="../images/close.png"
					onclick="this.parentNode.style.display='none';" /> 删除成功！
			</div>
			<!--数据区域：用表格展示数据-->
			<div id="data">
				<table id="datalist">
					<tr>
						<th>资费ID</th>
						<th class="width100">资费名称</th>
						<th>基本时长</th>
						<th>基本费用</th>
						<th>单位费用</th>
						<th>创建时间</th>
						<th>开通时间</th>
						<th class="width50">状态</th>
						<th class="width200"></th>
					</tr>
					<c:forEach items="${costs }" var="c">
						<tr>
							<td>${c.cost_id }</td>
							<td><a style="color: blue;" href="findCostDetail.do?id=${c.cost_id }">${c.name }</a>
							</td>
							<td>${c.base_duration }</td>
							<td>${c.base_cost }</td>
							<td>${c.unit_cost }</td>
							<td><fmt:formatDate value="${c.creatime }"
									pattern="yyyy-MM-dd hh:mm:ss" /></td>
							<td><fmt:formatDate value="${c.startime }"
									pattern="yyyy-MM-dd hh:mm:ss" /></td>
							<td>
							<c:if test="${c.status ==0}">暂停</c:if> 
							<c:if test="${c.status ==1}">开通</c:if>
							</td>
							<td><c:if test="${c.status==0 }">
									<input type="button" value="启用" class="btn_start"
										onclick="startFee(${c.cost_id});" />
									<input type="button" value="修改" class="btn_modify"
										onclick="location.href='toModify.do?id=${c.cost_id}';" />
									<input type="button" value="删除" class="btn_delete"
										onclick="deleteFee(${c.cost_id});" />
								</c:if></td>
						</tr>
					</c:forEach>
				</table>
				<p>
					业务说明：<br /> 1、创建资费时，状态为暂停，记载创建时间；<br /> 2、暂停状态下，可修改，可删除；<br />
					3、开通后，记载开通时间，且开通后不能修改、不能再停用、也不能删除；<br />
					4、业务账号修改资费时，在下月底统一触发，修改其关联的资费ID（此触发动作由程序处理）
				</p>
			</div>
			<!--分页-->
			<div id="pages">
				<a href="findCost.do?currentPage=1">首页</a>
				<c:choose>
					<c:when test="${costPage.currentPage==1 }">
						<a href="#">上一页</a>
					</c:when>
					<c:otherwise>
						<a href="findCost.do?currentPage=${costPage.currentPage-1 }">上一页</a>
					</c:otherwise>
				</c:choose>
				<c:forEach begin="1" end="${costPage.totalPage }" var="i">
					<c:choose>
						<c:when test="${costPage.currentPage==i }">
							<a href="findCost.do?currentPage=${i }" class="current_page">${i
								}</a>
						</c:when>
						<c:otherwise>
							<a href="findCost.do?currentPage=${i }">${i }</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:choose>
					<c:when test="${costPage.currentPage==costPage.totalPage }">
						<a href="#">下一页</a>
					</c:when>
					<c:otherwise>
						<a href="findCost.do?currentPage=${costPage.currentPage+1 }">下一页</a>
					</c:otherwise>
				</c:choose>
				<a href="findCost.do?currentPage=${costPage.totalPage }">末页</a> <input
					id="search_page" type="text" style="width: 50px;height: 25px;" />
				<input type="button" onclick="page_search_submit();" style="width: 50px;height: 25px;color: red;" value="search" /> <input
					id="search_page_msg" value="共 ${costPage.totalPage } 页" type="text"
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
