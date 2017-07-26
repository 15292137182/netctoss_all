$(function(){
	var date=new Date().toLocaleDateString();
	var time=new Date().toLocaleTimeString();
	//alert(time);
	$("#systime").val(time+"  "+date);

});