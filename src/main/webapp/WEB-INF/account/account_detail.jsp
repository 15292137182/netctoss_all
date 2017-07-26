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
            <form  class="main_form">
                <!--必填项-->
                <div class="text_info clearfix"><span>账务账号ID：</span></div>
                <div class="input_info"><input type="text" value="${a.account_id }" readonly class="readonly" /></div>
                <div class="text_info clearfix"><span>姓名：</span></div>
                <div class="input_info"><input type="text" value="${a.real_name }" readonly class="readonly" /></div>
                <div class="text_info clearfix"><span>身份证：</span></div>
                <div class="input_info">
                    <input type="text" value="${a.idcard_no }" readonly class="readonly" />
                </div>
                <div class="text_info clearfix"><span>登录账号：</span></div>
                <div class="input_info">
                    <input type="text" value="${a.login_name }" readonly class="readonly" />
                </div>                   
                <div class="text_info clearfix"><span>电话：</span></div>
                <div class="input_info">
                    <input type="text" class="width200 readonly" readonly value="${a.telephone }" />
                </div>
                <div class="text_info clearfix"><span>推荐人账务账号ID：</span></div>
                <div class="input_info"><input type="text" readonly class="readonly" value="${a.recommender_id }" /></div>
                <div class="text_info clearfix"><span>推荐人身份证号码：</span></div>
                <div class="input_info"><input type="text" readonly class="readonly" value="${a.reIdentityCard }" /></div>
                <div class="text_info clearfix"><span>状态：</span></div>
                <div class="input_info">
                    <select disabled>
                        <option <c:if test="${a.status==0 }">selected</c:if>>开通</option>
                        <option <c:if test="${a.status==1 }">selected</c:if>>暂停</option>
                        <option <c:if test="${a.status==2 }">selected</c:if>>删除</option>
                    </select>                        
                </div>                    
                <div class="text_info clearfix"><span>开通/暂停/删除时间：</span></div>
                <div class="input_info">
               
                <c:if test="${a.status==0 }">
                	 <input type="text" readonly class="readonly" 
                		value="<fmt:formatDate value="${a.create_date }" pattern="yyyy-MM-dd hh:mm:ss" />" 
                	/>
                </c:if>
               <c:if test="${a.status==1 }">
                	 <input type="text" readonly class="readonly" 
                		value="<fmt:formatDate value="${a.pause_date }" pattern="yyyy-MM-dd hh:mm:ss" />" 
                	/>
                </c:if>
                <c:if test="${a.status==2 }">
                	 <input type="text" readonly class="readonly" 
                		value="<fmt:formatDate value="${a.close_date }" pattern="yyyy-MM-dd hh:mm:ss" />" 
                	/>
                </c:if>
                
                </div>
                <div class="text_info clearfix"><span>上次登录时间：</span></div>
                <div class="input_info"><input type="text" readonly class="readonly" value="${a.last_login_time }" /></div>
                <div class="text_info clearfix"><span>上次登录IP：</span></div>
                <div class="input_info"><input type="text" readonly class="readonly" value="${a.last_login_ip }" /></div>
                <!--可选项数据-->
                <div class="text_info clearfix"><span>生日：</span></div>
                <div class="input_info">
                    <input type="text" readonly class="readonly" value="${a.birthdate }" />
                </div>
                <div class="text_info clearfix"><span>Email：</span></div>
                <div class="input_info">
                    <input type="text" class="width350 readonly" readonly value="${a.email }" />
                </div> 
                <div class="text_info clearfix"><span>职业：</span></div>
                <div class="input_info">
                    <select disabled>
                    	
                        <option <c:if test="${a.occupation==0 }">selected</c:if>>干部</option>
                        <option <c:if test="${a.occupation==1 }">selected</c:if>>学生</option>
                        <option <c:if test="${a.occupation==2 }">selected</c:if>>技术人员</option>
                        <option <c:if test="${a.occupation==3 }">selected</c:if>>其他</option>
                    </select>                        
                </div>
                <div class="text_info clearfix"><span>性别：</span></div>
                <div class="input_info fee_type">
                	
                    <input <c:if test="${a.gender==0 }">checked</c:if> type="radio" name="gender" id="female" disabled />
                    <label for="female">女</label>
                    <input <c:if test="${a.gender==1 }">checked</c:if> type="radio" name="gender" id="male" disabled />
                    <label for="male">男</label>
                </div> 
                <div class="text_info clearfix"><span>通信地址：</span></div>
                <div class="input_info"><input type="text" class="width350 readonly" readonly value="${a.mailaddress }" /></div> 
                <div class="text_info clearfix"><span>邮编：</span></div>
                <div class="input_info"><input type="text" class="readonly" readonly value="${a.zipcode }" /></div> 
                <div class="text_info clearfix"><span>QQ：</span></div>
                <div class="input_info"><input type="text" class="readonly" readonly value="${a.qq }" /></div>                
                <!--操作按钮-->
                <div class="button_info clearfix">
                    <input type="button" value="返回" class="btn_save" onclick="location.href='findAccount.do';" />
                </div>
            </form>  
        </div>
        <!--主要区域结束-->
	<div id="footer">
		<jsp:include page="/WEB-INF/menu/footer.jsp" />
	</div>
    </body>
</html>
