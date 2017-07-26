	function isCheck() {
		var rname = $("#real_name").val().trim();
		var reg_n = /^(?!_)(?![0-9])(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]{3,30}$/;
		if (!reg_n.test(rname)) {
			$("#real_name_msg").text("3~30以内的汉字,字母,数字及下划线组成,不能以数字,下划线开头及下划线结尾")
					.addClass("error_msg");
			return false;
		}
		var lname = $("#login_name").val().trim();
		if (!reg_n.test(lname)) {
			$("#login_name_msg")
					.text("3~30以内的汉字,字母,数字及下划线组成,不能以数字,下划线开头及下划线结尾").addClass(
							"error_msg");
			return false;
		}
		var lpwd = $("#login_passwd").val().trim();
		var reg_pwd = /^[a-zA-Z]\w{5,17}$/;
		if (!reg_pwd.test(lpwd)) {
			$("#login_passwd_msg").text("6~18以内的字母,数字,下划线组成,由字母开头").addClass(
					"error_msg");
			return false;
		}
		var cPwd = $("#confirm_pwd").val().trim();
		if (cPwd != lpwd) {
			$("#confirm_pwd_msg").text("两次密码不相同").addClass("error_msg");
			return false;
		}
		var tel = $("#telephone").val().trim();
		var reg_tel = /^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/;
		var reg_t = /(0511-4405222、021-87888822)：\d{3}-\d{8}|\d{4}-\d{7}/;
		if (!reg_tel.test(tel) && !reg_t.test(tel)) {
			$("#telephone_msg").text("手机/固话号码无效").addClass("error_msg");
			return false;
		}
		var email = $("#email").val().trim();
		var reg_e = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
		if (!reg_e.test(email) && email != "") {
			$("#email_msg").text("邮箱格式不正确").addClass("error_msg");
			return false;
		}
		var mailAdd = $("#mailaddress").val().trim();
		var reg_m = /^.{0,100}$/;
		if (!reg_m.test(mailAdd)) {
			$("#mailaddress_msg").text("100长度以内").addClass("error_msg");
			return false;
		}
		var zip = $("#zipcode").val().trim();
		var reg_zip = /^\d{6,6}$/;
		if (!reg_zip.test(zip) && zip != "") {
			$("#zipcode_msg").text("邮编无效(6位)").addClass("error_msg");
			return false;
		}
		var qq = $("#qq").val().trim();
		var reg_qq = /^\d{6,13}$/;
		if (!reg_qq.test(qq) && qq != "") {
			$("#qq_msg").text("QQ号码无效(6~13位)").addClass("error_msg");
			return false;
		}
		return true;
	}

	var flagCI;
	function check_identityCard() {
		flagCI = null;
		$("#birthdate").val("");
		var identityCard = $("#idcard_no").val();
		reg_i = /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{4}$/;
		if (!reg_i.test(identityCard)) {
			$("#idcard_no_msg").text("身份证无效").addClass("error_msg");
			flagCI = false;
			return;
		}
		//$("#idcard_no_msg").text("身份证有效").removeClass("error_msg");
		$.ajax({
			url : "findByIdentityCard.do",
			type : "post",
			dataType : "json",
			data : {
				"id" : identityCard
			},
			success : function(data) {
				if (data.status) {
					$("#idcard_no_msg").text("身份证已被注册").addClass("error_msg");
					$("#birthdate").val("");
					flagCI = false;
					//alert(flagCI+"333");
					return;
				}
				if (data.status == false) {
					$("#idcard_no_msg").text("身份证有效").removeClass("error_msg");
					flagCI = true;
					//alert(flagCI+"333");
					return;
				}
			},
			error : function() {
				alert("系统升级中...");
			}
		});
		//alert(flagCI+"111");
		//511526 1991 10 29 4210
		var year = identityCard.substring(6, 10);
		var month = identityCard.substring(10, 12);
		var day = identityCard.substring(12, 14);
		var birthday = year + "-" + month + "-" + day;
		//alert(birthday);
		$("#birthdate").val(birthday);
		flagCI = true;
		//alert(flagCI+"222");
		return;
	}

	var flagCR;
	function checkRecommender() {
		flagCR = null;
		$("#recommender_identity").val("");
		var reId = $("#recommender_id").val().trim();
		var reg_i = /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{4}$/;
		if (!reg_i.test(reId) && reId != "") {
			$("#recommender_id_msg").text("身份证无效").addClass("error_msg");
			flagCR = false;
			return;
		}

		//$("#recommender_id_msg").text("身份证有效").removeClass("error_msg");
		$("#recommender_identity").val(reId);
		flagCR = true;
		//return ;
		if (reId != "") {
			$.ajax({
				url : "findByIdentityCard.do",
				type : "post",
				dataType : "json",
				data : {
					"id" : reId
				},
				success : function(data) {
					if (data.status == false) {
						$("#recommender_id_msg").text("推荐人无效").addClass(
								"error_msg");
						flagCR = false;
						return;
					}
					if (data.status) {
						$("#recommender_id_msg").text("推荐人有效").removeClass("error_msg");
						//alert(data.result.account_id);
						$("#recommender_identity").val(data.result.account_id);
						flagCR = true;
						return;
					}
				},
				error : function() {
					alert("系统升级中...");
				}
			});
		}
	}

	function save() {
		alert("++++++++++++");
		check_identityCard();
		checkRecommender();
		var timer = setInterval(function() {
			if (flagCI != null & flagCR != null) {
				clearInterval(timer);
				if (isCheck() & flagCI & flagCR) {
					//alert("11111111111111");
					//alert($("#addAccount_form").serialize());
					$.ajax({
						url : "save.do",
						type : "post",
						dataType : "json",
						data : $("#addAccount_form").serialize(),
						success : function(data) {
							if (data) {
								//alert("2222222222222");
								location.href = "findAccount.do";
							}
						},
						error : function() {
							alert("账务账号新增功能升级中...");
						}
					});
				} else {
					alert("请检查是否输入完毕.");
				}
			}
		}, 300);
	}

	//显示选填的信息项
	function showOptionalInfo(imgObj) {
		var div = document.getElementById("optionalInfo");
		if (div.className == "hide") {
			div.className = "show";
			imgObj.src = "../images/hide.png";
		} else {
			div.className = "hide";
			imgObj.src = "../images/show.png";
		}
	}