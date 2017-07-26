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
	function updateDelete(id) {
		var r = window.confirm("确定要删除该账务账号吗?同时将删除其下属的所有业务账号!");
		if (r) {
			$.ajax({
				url : "updateDelete.do",
				dataType : "json",
				type : "post",
				data : {
					"id" : id
				},
				success : function(data) {
					if (data) {
						$("#operate_result_info").show();
						$("#operate_result_info").text("删除成功~");
						setTimeout(function() {
							$("#operate_result_info").hide();
							location.href = "findAccount.do";
						}, 2000);
					}
				},
				error : function() {
					alert("删除功能维护中...");
				}
			});
		}
	}

	function updateStart(id) {
		var r = window.confirm("确定要开通该账务账号吗?");
		if (r) {
			$.ajax({
				url : "updateStart.do",
				dataType : "json",
				type : "post",
				data : {
					"id" : id
				},
				success : function(data) {
					if (data) {
						$("#operate_result_info").show();
						$("#operate_result_info").text("开通成功~");
						setTimeout(function() {
							$("#operate_result_info").hide();
							location.href = "findAccount.do";
						}, 2000);
					}
				},
				error : function() {
					alert("开通功能维护中...");
				}
			});
		}
	}

	function updatePause(id) {
		var r = window.confirm("确定要暂停该账务账号吗?同时将暂停其下属的所有业务账号!");
		if (r) {
			$.ajax({
				url : "updatePause.do",
				dataType : "json",
				type : "post",
				data : {
					"id" : id
				},
				success : function(data) {
					if (data) {
						$("#operate_result_info").show();
						$("#operate_result_info").text("暂停成功~");
						setTimeout(function() {
							$("#operate_result_info").hide();
							location.href = "findAccount.do";
						}, 2000);
					}
				},
				error : function() {
					alert("暂停功能维护中...");
				}
			});
		}
	}

	function page_search_submit() {
		var page = $("#search_page").val().trim();
		//alert(page);
		var reg = /^\d{0,3}$/;
		$("#search_page_msg").text("");
		if (!reg.test(page)) {
			$("#search_page_msg").val("输入有误");
			return;
		}
		if (page == "" || page == 0) {
			page = 1;
		}
		location.href = "findAccount.do?currentPage=" + page;
	}

	//删除
	function deleteAccount() {
		var r = window.confirm("确定要删除此账务账号吗？\r\n删除后将不能恢复，且会删除其下属的所有业务账号。");
		document.getElementById("operate_result_info").style.display = "block";
	}
	//开通或暂停
	function setState() {
		var r = window.confirm("确定要开通此账务账号吗？");
		document.getElementById("operate_result_info").style.display = "block";
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
		<form action="findAccount.do?currentPage=1" method="post">
			<!--分页-->
			<div id="pages">
				<a href="findAccount.do?currentPage=1">首页</a>
				<c:choose>
					<c:when test="${accountPage.currentPage==1 }">
						<a href="#">上一页</a>
					</c:when>
					<c:otherwise>
						<a href="findAccount.do?currentPage=${accountPage.currentPage-1 }">上一页</a>
					</c:otherwise>
				</c:choose>
				<c:forEach begin="1" end="${accountPage.totalPage }" var="i">
					<c:choose>
						<c:when test="${accountPage.currentPage==i }">
							<a href="findAccount.do?currentPage=${i }" class="current_page">${i
								}</a>
						</c:when>
						<c:otherwise>
							<a href="findAccount.do?currentPage=${i }">${i }</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:choose>
					<c:when test="${accountPage.currentPage==accountPage.totalPage }">
						<a href="#">下一页</a>
					</c:when>
					<c:otherwise>
						<a href="findAccount.do?currentPage=${accountPage.currentPage+1 }">下一页</a>
					</c:otherwise>
				</c:choose>
				<a href="findAccount.do?currentPage=${accountPage.totalPage }">末页</a>
				<input id="search_page" type="text"
					style="width: 50px;height: 25px;" /> <input type="button"
					onclick="page_search_submit();"
					style="width: 50px;height: 25px;color: red;" value="search" /> <input
					id="search_page_msg" value="共 ${accountPage.totalPage } 页"
					type="text" style="width: 50px;height: 25px;color: red;"
					readonly="readonly" />
			</div>
			<input type="hidden" name="currentPage" value="1" />
			<!--查询-->
			<div class="search_add">
				<div>
					身份证：<input type="text" name="identityCard"
						value="${accountPage.identityCard }" class="text_search" />
				</div>
				<div>
					姓名：<input type="text" name="realName" class="width70 text_search"
						value="${accountPage.realName }" />
				</div>
				<div>
					登录名：<input type="text" name="nickname"
						value="${accountPage.nickname }" class="text_search" />
				</div>
				<div>
					状态： <select class="select_search" name="status">
						<option value="-1">全部</option>
						<option value="0"
							<c:if test="${accountPage.status==0 }">selected</c:if>>开通</option>
						<option value="1"
							<c:if test="${accountPage.status==1 }">selected</c:if>>暂停</option>
						<option value="2"
							<c:if test="${accountPage.status==2 }">selected</c:if>>删除</option>
					</select>
				</div>
				<div>
					<input type="submit" value="搜索" class="btn_search" />
				</div>
				<input type="button" value="增加" class="btn_add"
					onclick="location.href='toAdd.do';" />
			</div>
			<!--删除等的操作提示-->
			<div id="operate_result_info" class="operate_success">
				<img src="../images/close.png"
					onclick="this.parentNode.style.display='none';" />

			</div>
			<!--数据区域：用表格展示数据-->
			<div id="data">
				<table id="datalist">
					<tr>
						<th>账号ID</th>
						<th>姓名</th>
						<th class="width150">身份证</th>
						<th>登录名</th>
						<th>状态</th>
						<th class="width150">创建日期</th>
						<th class="width150">暂停日期</th>
						<th class="width200"></th>
					</tr>
					<c:forEach items="${accounts }" var="a">
						<tr>
							<td>${a.account_id }</td>
							<td><a style="color: blue;" href="findDetail.do?id=${a.account_id }">${a.real_name }</a></td>
							<td>${a.idcard_no }</td>
							<td>${a.login_name }</td>
							<td><c:if test="${a.status==0 }">开通</c:if> <c:if
									test="${a.status==1 }">暂停</c:if> <c:if test="${a.status==2 }">删除</c:if>
							</td>
							<td><fmt:formatDate value="${a.create_date }"
									pattern="yyyy-MM-dd hh:mm:ss" />
							</td>
							<td><fmt:formatDate value="${a.pause_date }"
									pattern="yyyy-MM-dd hh:mm:ss" />
							</td>
							<td class="td_modi"><c:if test="${a.status==0 }">
									<input type="button" value="暂停" class="btn_pause"
										onclick="updatePause('${a.account_id}');" />
									<input type="button" value="修改" class="btn_modify"
										onclick="location.href='toModify.do?id=${a.account_id}';" />
									<input type="button" value="删除" class="btn_delete"
										onclick="updateDelete('${a.account_id}');" />
								</c:if> <c:if test="${a.status==1 }">
									<input type="button" value="开通" class="btn_start"
										onclick="updateStart('${a.account_id}');" />
									<input type="button" value="修改" class="btn_modify"
										onclick="location.href='toModify.do?id=${a.account_id}';" />
									<input type="button" value="删除" class="btn_delete"
										onclick="updateDelete('${a.account_id}');" />
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</table>
				<p>
					业务说明：<br /> 1、创建则开通，记载创建时间；<br /> 2、暂停后，记载暂停时间；<br />
					3、重新开通后，删除暂停时间；<br /> 4、删除后，记载删除时间，标示为删除，不能再开通、修改、删除；<br />
					5、暂停账务账号，同时暂停下属的所有业务账号；<br />
					6、暂停后重新开通账务账号，并不同时开启下属的所有业务账号，需要在业务账号管理中单独开启；<br />
					7、删除账务账号，同时删除下属的所有业务账号。
				</p>
			</div>

		</form>
	</div>
	<!--主要区域结束-->
	<div id="footer">
		<jsp:include page="/WEB-INF/menu/footer.jsp" />
	</div>
</body>
</html>
