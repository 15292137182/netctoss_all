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
         <script type="text/javascript" src="../js/account/account_update.js"></script>
    </head>
    <body>
        <!--Logo区域开始-->
        <div id="header">
            <jsp:include page="/WEB-INF/menu/logo.jsp" />          
        </div>
        <!--Logo区域结束-->
        <!--导航区域开始-->
        <div id="navi">
            <ul id="menu">
                <jsp:include page="/WEB-INF/menu/menu_list.jsp" />
            </ul>
        </div>
        <!--导航区域结束-->
        <!--主要区域开始-->
        <div id="main">  
            <!--保存成功或者失败的提示消息-->          
            <div id="save_result_info" class="save_fail">保存失败，旧密码错误！</div>
            <form id="updateAccountForm" class="main_form">
                    <!--必填项-->
                    <div class="text_info clearfix"><span>账务账号ID：</span></div>
                    <div class="input_info">
                        <input type="text" id="account_id" name="account_id" value="${a.account_id }" readonly class="readonly" />
                    </div>
                    <div class="text_info clearfix"><span>姓名：</span></div>
                    <div class="input_info">
                        <input type="text" id="real_name" name="real_name" onfocus="clearMsg('real_name_msg')" value="${a.real_name }" />
                        <span class="required">*</span>
                        <div class="validate_msg_long error_msg" id="real_name_msg"></div>
                    </div>
                    <div class="text_info clearfix"><span>身份证：</span></div>
                    <div class="input_info">
                        <input type="text" value="${a.idcard_no }" readonly class="readonly" />
                    </div>
                    <div class="text_info clearfix"><span>登录账号：</span></div>
                    <div class="input_info">
                        <input type="text" value="${a.login_name }" readonly class="readonly"  />        
                        <div class="change_pwd">
                            <input id="chkModiPwd" type="checkbox" onclick="showPwd(this);" />
                            <label for="chkModiPwd">修改密码</label>
                        </div>
                    </div>
                    <!--修改密码部分-->
                    <div id="divPwds">
                        <div class="text_info clearfix"><span>旧密码：</span></div>
                        <div class="input_info">
                            <input type="password" id="login_passwd" onfocus="clearMsg('login_passwd_msg')" onblur="checkOldPwd();"/>
                            <span class="required">*</span>
                            <div class="validate_msg_long" id="login_passwd_msg"></div>
                        </div>
                        <div class="text_info clearfix"><span>新密码：</span></div>
                        <div class="input_info">
                            <input type="password" id="new_pwd" name="login_passwd" onfocus="clearMsg('new_pwd_msg')" />
                            <span class="required">*</span>
                            <div class="validate_msg_long" id="new_pwd_msg"></div>
                        </div>
                        <div class="text_info clearfix"><span>重复新密码：</span></div>
                        <div class="input_info">
                            <input type="password"  id="confirm_pwd" onfocus="clearMsg('confirm_pwd_msg')"/>
                            <span class="required">*</span>
                            <div class="validate_msg_long" id="confirm_pwd_msg"></div>
                        </div>  
                    </div>      
                    <div class="text_info clearfix"><span>电话：</span></div>
                    <div class="input_info">
                        <input type="text" class="width200" id="telephone" name="telephone" onfocus="clearMsg('telephone_msg')" value="${a.telephone }"/>
                        <span class="required">*</span>
                        <div class="validate_msg_medium error_msg" id="telephone_msg"></div>
                    </div>
                    <div class="text_info clearfix"><span>推荐人身份证号码：</span></div>
                    <div class="input_info">
                        <input type="text" id="recommender_id" onfocus="clearMsg('recommender_id_msg')" onblur="checkRecommender();" value="${a.reIdentityCard }"/>
                        <input type="hidden" id="recommender_identity" name="recommender_id" />
                        <div class="validate_msg_long error_msgs" id="recommender_id_msg"></div>
                    </div>
                    <div class="text_info clearfix"><span>生日：</span></div>
                    <div class="input_info">
                        <input type="text"  value="${a.birthdate }" readonly class="readonly" />
                    </div>
                    <div class="text_info clearfix"><span>Email：</span></div>
                    <div class="input_info">
                        <input type="text" id="email" name="email" onfocus="clearMsg('email_msg')" class="width200" value="${a.email }"/>
                        <div class="validate_msg_medium" id="email_msg"></div>
                    </div> 
                    <div class="text_info clearfix"><span>职业：</span></div>
                    <div class="input_info">
                        <select name="occupation">
                            <option value="0" <c:if test="${a.occupation==0 }">selected</c:if>>干部</option>
                            <option value="1" <c:if test="${a.occupation==1 }">selected</c:if>>学生</option>
                            <option value="2" <c:if test="${a.occupation==2 }">selected</c:if>>技术人员</option>
                            <option value="3" <c:if test="${a.occupation==3 }">selected</c:if>>其他</option>
                        </select>                        
                    </div>
                    <div class="text_info clearfix"><span>性别：</span></div>
                    <div class="input_info fee_type">
                    	
                        <input type="radio" <c:if test="${a.gender==0 }">checked</c:if> name="gender" value="0" id="female" onclick="feeTypeChange(1);" />
                        <label for="female">女</label>
                        <input type="radio" <c:if test="${a.gender==1 }">checked</c:if> name="gender" value="1" id="male" onclick="feeTypeChange(2);" />
                        <label for="male">男</label>
                    </div> 
                    <div class="text_info clearfix"><span>通信地址：</span></div>
                    <div class="input_info">
                        <input type="text" class="width350" id="mailaddress" name="mailaddress" onfocus="clearMsg('mailaddress_msg')" value="${a.mailaddress }"/>
                        <div class="validate_msg_tiny" id="mailaddress_msg"></div>
                    </div> 
                    <div class="text_info clearfix"><span>邮编：</span></div>
                    <div class="input_info">
                        <input type="text" id="zipcode" name="zipcode" onfocus="clearMsg('zipcode_msg')" value="${a.zipcode }"/>
                        <div class="validate_msg_long" id="zipcode_msg"></div>
                    </div> 
                    <div class="text_info clearfix"><span>QQ：</span></div>
                    <div class="input_info">
                        <input type="text" value="${a.qq }" id="qq" name="qq" onfocus="clearMsg('qq_msg')"/>
                        <div class="validate_msg_long" id="qq_msg"></div>
                    </div>                
                    <!--操作按钮-->
                    <div class="button_info clearfix">
                        <input type="button" value="保存" class="btn_save" onclick="updateAccount();" />
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
