function isCheck(){
	var rname=$("#real_name").val().trim();
	var reg_n=/^(?!_)(?![0-9])(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]{3,30}$/;
	if(!reg_n.test(rname)){
		$("#real_name_msg").text("3~30以内的汉字,字母,数字及下划线组成,不能以数字,下划线开头及下划线结尾").addClass("error_msg");
		return false;
	}
	var tel=$("#telephone").val().trim();
	var reg_tel = /^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/;
	var reg_t = /(0511-4405222、021-87888822)：\d{3}-\d{8}|\d{4}-\d{7}/;
	if (!reg_tel.test(tel) && !reg_t.test(tel)) {
		$("#telephone_msg").text("手机/固话号码无效").addClass("error_msg");
		return false;
	}
	var email=$("#email").val().trim();
	var reg_e=/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
	if(!reg_e.test(email) && email!=""){
		$("#email_msg").text("邮箱格式不正确").addClass("error_msg");
		return false;
	}
	var mailAdd=$("#mailaddress").val().trim();
	var reg_m=/^.{0,100}$/;
	if(!reg_m.test(mailAdd)){
		$("#mailaddress_msg").text("100长度以内").addClass("error_msg");
		return false;
	}
	var zip=$("#zipcode").val().trim();
	var reg_zip=/^\d{6,6}$/;
	if(!reg_zip.test(zip) && zip!=""){
		$("#zipcode_msg").text("邮编无效(6位)").addClass("error_msg");
		return false;
	}
	var qq=$("#qq").val().trim();
	var reg_qq=/^\d{6,13}$/;
	if(!reg_qq.test(qq) && qq!=""){
		$("#qq_msg").text("QQ号码无效(6~13位)").addClass("error_msg");
		return false;
	}
	return true;
}

var flagPwd;
var flag;
function checkOldPwd(){
	flagPwd=null;
	flag=null;
	var id=$("#account_id").val().trim();
	var reg_pwd=/^[a-zA-Z]\w{5,17}$/;
	var oldPwd=$("#login_passwd").val().trim();
	if(!reg_pwd.test(oldPwd)){
		$("#login_passwd_msg").text("6~18以内的字母,数字,下划线组成,由字母开头").addClass("error_msg");
		flagPwd=false;
		flag=false;
		return;
	}
	$.ajax({
		url:"checkPwd.do",
		type:"post",
		dataType:"json",
		data:{"id":id,"pwd":oldPwd},
		success:function(data){
			if(data.status==false){
				$("#login_passwd_msg").text(data.msg).addClass("error_msg");
				flagPwd=false;
				flag=false;
				return;
			}
			if(data.status){
				$("#login_passwd_msg").text(data.msg).removeClass("error_msg");
				flagPwd=false;
				flag=true;
				return;
			}
		},
		error:function(){alert("密码检查功能升级中...");}
	});
	var timer=setInterval(function(){
		if(flag!=null){
			clearInterval(timer);
			if(flag){
				var lpwd=$("#new_pwd").val().trim();
				if(!reg_pwd.test(lpwd)){
					$("#new_pwd_msg").text("6~18以内的字母,数字,下划线组成,由字母开头").addClass("error_msg");
					flagPwd=false;
					return;
				}
				var cPwd=$("#confirm_pwd").val().trim();
				if(cPwd!=lpwd){
					$("#confirm_pwd_msg").text("两次密码不相同").addClass("error_msg");
					flagPwd=false;
					return;
				}
					flagPwd=true;
					return;
			}
		}
	},300);
}

var flagCR;
function checkRecommender(){
	flagCR=null;
	$("#recommender_identity").val("");
	var reId=$("#recommender_id").val().trim();
	var reg_i=/^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{4}$/;
	if(!reg_i.test(reId) && reId!=""){
		$("#recommender_id_msg").text("身份证无效").addClass("error_msg");
		flagCR=false;
		return;
	}
	//$("#recommender_id_msg").text("身份证有效").removeClass("error_msg");
	$("#recommender_identity").val(reId);
	flagCR=true;
	//return ;
	if(reId!=""){
			$.ajax({
			url:"findByIdentityCard.do",
			type:"post",
			dataType:"json",
			data:{"id":reId},
			success:function(data){
				if(data.status==false){
					$("#recommender_id_msg").text("推荐人无效").addClass("error_msg");
					flagCR=false;
					return;
				}
				if(data.status){
					$("#recommender_id_msg").text("推荐人有效").removeClass("error_msg");
					$("#recommender_identity").val(data.result);
					flagCR=true;
					return;
				}
			},
			error:function(){alert("系统升级中...");}
		});
	}
}

function updateAccount(){
	checkOldPwd();
	checkRecommender();
	var timer=setInterval(function(){
		//alert(flagPwd+"222");
		if(flagCR!=null & flagPwd!=null){
			clearInterval(timer);
			if(isCheck() & flagCR & flagPwd){
				//alert("++++++");
				//alert($("#updateAccountForm").serialize());
				$.ajax({
					url:"updateAccount.do",
					type:"post",
					dataType:"json",
					data:$("#updateAccountForm").serialize(),
					success:function(data){
						if(data){
							location.href="findAccount.do";
						}
					},
					error:function(){alert("账务账号更新功能升级中...");}
				});
			}else{
				alert("请检查输入是否完毕");
			}
		}
	},600);
}

//显示修改密码的信息项
function showPwd(chkObj) {
    if (chkObj.checked)
        document.getElementById("divPwds").style.display = "block";
    else
        document.getElementById("divPwds").style.display = "none";
}