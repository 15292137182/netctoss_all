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
                <div class="text_info clearfix"><span>资费ID：</span></div>
                <div class="input_info"><input type="text" class="readonly" readonly value="${c.cost_id }" /></div>
                <div class="text_info clearfix"><span>资费名称：</span></div>
                <div class="input_info"><input type="text" class="readonly" readonly value="${c.name }"/></div>
                <div class="text_info clearfix"><span>资费状态：</span></div>
                <div class="input_info">
                    <select class="readonly" disabled>
                    	
                        <option <c:if test="${c.status==1 }">selected</c:if>>开通</option>
                        <option <c:if test="${c.status==0 }">selected</c:if>>暂停</option>
                        <option <c:if test="${c.status==2 }">selected</c:if>>删除</option>
                    </select>                        
                </div>
                <div class="text_info clearfix"><span>资费类型：</span></div>
                <div class="input_info fee_type">
                	
                    <input <c:if test="${c.cost_type==1 }">checked</c:if> value="${c.cost_type }" type="radio" name="cost_type" id="monthly" disabled="disabled" />
                    <label for="monthly">包月</label>
                    <input <c:if test="${c.cost_type==2 }">checked</c:if> value="${c.cost_type }" type="radio" name=cost_type id="package" disabled="disabled" />
                    <label for="package">套餐</label>
                    <input <c:if test="${c.cost_type==3 }">checked</c:if> value="${c.cost_type }" type="radio" name="cost_type" id="timeBased" disabled="disabled" />
                    <label for="timeBased">计时</label>
                </div>
                <div class="text_info clearfix"><span>基本时长：</span></div>
                <div class="input_info">
                    <input type="text" class="readonly" readonly value="${c.base_duration }"  />
                    <span>小时</span>
                </div>
                <div class="text_info clearfix"><span>基本费用：</span></div>
                <div class="input_info">
                    <input type="text"  class="readonly" readonly value="${c.base_cost }" />
                    <span>元</span>
                </div>
                <div class="text_info clearfix"><span>单位费用：</span></div>
                <div class="input_info">
                    <input type="text"  class="readonly" readonly value="${c.unit_cost }" />
                    <span>元/小时</span>
                </div>
                <div class="text_info clearfix"><span>创建时间：</span></div>
                <div class="input_info">
                	
                <input type="text"  class="readonly" readonly 
                	value="<fmt:formatDate value="${ c.creatime}" pattern="yyyy-MM-dd hh:mm:ss" />"
                	/>
                </div>      
                <div class="text_info clearfix"><span>启动时间：</span></div>
                <div class="input_info">
                
                <input type="text"  class="readonly" readonly 
                	value="<fmt:formatDate value="${ c.startime}" pattern="yyyy-MM-dd hh:mm:ss" />"
                	 />
                </div>      
                <div class="text_info clearfix"><span>资费说明：</span></div>
                <div class="input_info_high">
                    <textarea class="width300 height70 readonly" readonly>${c.descr }</textarea>
                </div>                    
                <div class="button_info clearfix">
                    <input type="button" value="返回" class="btn_save" onclick="location.href='findCost.do';" />
                </div>
            </form>  
        </div>
       <!--主要区域结束-->
	 <div id="footer">
            <jsp:include page="/WEB-INF/menu/footer.jsp" />  
     </div>
    </body>
</html>
