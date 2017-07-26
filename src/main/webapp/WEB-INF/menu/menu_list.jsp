<%@page pageEncoding="utf-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<ul id="menu">
	<c:if test="${currentModule==0 }">
		<li><a href="../login/toIndex.do" class="index_on"></a></li>
	</c:if>
	<c:if test="${currentModule!=0 }">
		<li><a href="../login/toIndex.do" class="index_off"></a></li>
	</c:if>
    <c:forEach items="${modulesOfAdmin }" var="m">
    	<c:if test="${currentModule==1 }">
    		<c:if test="${m.module_id==1 }">
	    		<li><a href="../role/findRole.do?currentPage=1" class="role_on"></a></li>
	    	</c:if>
    	</c:if>
    	<c:if test="${currentModule!=1 }">
    		<c:if test="${m.module_id==1 }">
	    		<li><a href="../role/findRole.do?currentPage=1" class="role_off"></a></li>
	   		 </c:if>
    	</c:if>
    	<c:if test="${currentModule==2 }">
    		<c:if test="${m.module_id==2 }">
	    		<li><a href="../admin/findAdmin.do?currentPage=1" class="admin_on"></a></li>
	   		 </c:if>
    	</c:if>
    	<c:if test="${currentModule!=2 }">
    		<c:if test="${m.module_id==2 }">
	    		<li><a href="../admin/findAdmin.do?currentPage=1" class="admin_off"></a></li>
	   		 </c:if>
    	</c:if>
    	<c:if test="${currentModule==3 }">
    		 <c:if test="${m.module_id==3 }">
	    	<li><a href="../cost/findCost.do?currentPage=1" class="fee_on"></a></li>
	    </c:if>
    	</c:if>
    	<c:if test="${currentModule!=3 }">
    		 <c:if test="${m.module_id==3 }">
	    	<li><a href="../cost/findCost.do?currentPage=1" class="fee_off"></a></li>
	    </c:if>
    	</c:if>
    	<c:if test="${currentModule==4 }">
    		 <c:if test="${m.module_id==4 }">
	    	<li><a href="../account/findAccount.do?currentPage=1" class="account_on"></a></li>
	    </c:if>
    	</c:if>
    	<c:if test="${currentModule!=4 }">
    		 <c:if test="${m.module_id==4 }">
	    	<li><a href="../account/findAccount.do?currentPage=1" class="account_off"></a></li>
	    </c:if>
    	</c:if>
    	<c:if test="${currentModule==5 }">
    		<c:if test="${m.module_id==5 }">
	    	<li><a href="../service/findService.do?currentPage=1" class="service_on"></a></li>
	    </c:if>
    	</c:if>
    	<c:if test="${currentModule!=5 }">
    		<c:if test="${m.module_id==5 }">
	    	<li><a href="../service/findService.do?currentPage=1" class="service_off"></a></li>
	    </c:if>
    	</c:if>
    	<!-- 
    	<c:if test="${currentModule==6 }">
    		 <c:if test="${m.module_id==6 }">
	    	<li><a href="../bill/findBill.do?currentPage=1" class="bill_on"></a></li>
	    </c:if>
    	</c:if>
    	
    	<c:if test="${currentModule!=6 }">
    		 <c:if test="${m.module_id==6 }">
	    	<li><a href="../bill/findBill.do?currentPage=1" class="bill_off"></a></li>
	    </c:if>
    	</c:if>
    	 -->
    	<c:if test="${currentModule==7 }">
    		  <c:if test="${m.module_id==7 }">
	    	 <li><a href="../report/findReport.do?currentPage=1" class="report_on"></a></li>
	    </c:if>
    	</c:if>
    	<c:if test="${currentModule!=7 }">
    		  <c:if test="${m.module_id==7 }">
	    	 <li><a href="../report/findReport.do?currentPage=1" class="report_off"></a></li>
	    </c:if>
    	</c:if>
    </c:forEach>
    <c:if test="${currentModule==8 }">
    	 <li><a href="../user/findUserInfo.do" class="information_on"></a></li>
    </c:if>
    <c:if test="${currentModule!=8 }">
    	 <li><a href="../user/findUserInfo.do" class="information_off"></a></li>
    </c:if>
    
     <c:if test="${currentModule==9 }">
    	<li><a href="../updateUserPwd/updateUserPwd.do" class="password_on"></a></li>
    </c:if>
    <c:if test="${currentModule!=9 }">
    	<li><a href="../updateUserPwd/updateUserPwd.do" class="password_off"></a></li>
    </c:if>
</ul>    








    