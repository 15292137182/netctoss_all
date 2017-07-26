$(function(){
        		$("#name").focus();
        		$("body").keydown(function(event){
        			var code=event.keyCode;
        			//alert(code);
        			if(code==13){
        				checkLogin();
        			}
        		});
        	});
        
        	function checkLogin(){
        		var name=$("#name").val().trim();
        		//alert(name);
        		reg=/^(?!_)(?![0-9])(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]{3,20}$/;
        		if(!reg.test(name)){
        			$("#name_msg").text("3~20以内的汉字,字母,数字及下划线组成");
        			return;
        		}
        		var pwd=$("#pwd").val().trim();
        		if(!reg.test(pwd)){
        			$("#pwd_msg").text("3~20以内的汉字,字母,数字及下划线组成");
        			return;
        		}
        		var verification=$("#verification").val().trim();
        		if(verification==""){
        			$("#verification_msg").text("验证码不能为空");
        			return;
        		}
        		//alert($("#login_form").serialize());
        		$.ajax({
        			url:"login.do",
        			type:"post",
        			dataType:"json",
        			data:$("#login_form").serialize(),
        			success:function(data){
        				var status=data.status;
        				var msg=data.msg;
        				if(status==1){
        					$("#name_msg").text(msg);
        					return;
        				}
        				if(status==2){
        					$("#pwd_msg").text(msg);
        					return;
        				}
        				if(status==3){
        					$("#verification_msg").text(msg);
        					return;
        				}
        				if(status==0){
        					//$("#login_msg_msg").val(msg);
        					location.href="toIndex.do";
        				}
        			},
        			error:function(){alert("登陆功能升级中...");}
        		});
        		
        	}
        
			function changeImage(){
				$("#change_image").attr("src","getImageCode.do?temp="+ new Date().getTime());
			}        