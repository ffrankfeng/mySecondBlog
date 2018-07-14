<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="fengf" uri="http://fengf.com/common/"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<!--声明文档兼容模式，表示使用IE浏览器的最新模式-->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!--设置视口的宽度(值为设备的理想宽度)，页面初始缩放值<理想宽度/可见宽度>-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<title>会员登录</title>

<!-- 引入Bootstrap核心样式文件 -->
<link href="<%=basePath%>css/bootstrap.css" rel="stylesheet">
<link href="<%=basePath%>css/customize.css" rel="stylesheet">	
<!-- 引入jQuery核心js文件 -->
<script src="<%=basePath%>js/jquery-1.11.3.min.js"></script>
<!-- 引入BootStrap核心js文件 -->
<script src="<%=basePath%>js/bootstrap.min.js"></script>
</head>
<script type="text/javascript">
function changeImg(obj){
	obj.src="${pageContext.request.contextPath}/checkcode?time="+new Date().getTime();	
};
$(function(){
	//为输入框绑定事件
	$("#username").blur(function(){
		//1、失去焦点获得输入框的内容
		var usernameInput=$(this).val();
		//2、去服务器端校验用户名是否存在--ajax
		var usernameInfo="";
		$.post(
			"${pageContext.request.contextPath}/checkUsername",
			{"userName":usernameInput},
			function(data){
				var isExist=data.isExist;
				//3、根据返回的isExist动态显示信息
				if(isExist){
					usernameInfo="用户不存在";
					$("#usernameInfo").css("color","red");
			 	}
				$("#usernameInfo").html(usernameInfo);
			},
			"json"
		);
	});
});	
$(function(){
	//为输入框绑定事件
$("#verificationCode").blur(function(){
		//1、失去焦点获得输入框的内容
		var checkcodeInput=$("#verificationCode").val();
		$.post(
			"${pageContext.request.contextPath}/checkverificationCode",
			{"verificationCode":checkcodeInput},
			
			function(data){
				var isCorrect=data.isCorrect;
				//3、根据返回的isExist动态显示信息
				if(isCorrect){
					$("#verificationCodeConfirm").attr("src","<%=basePath%>img/sign-check-icon.png");
			 	}else{
			 		$("#verificationCodeConfirm").attr("src","<%=basePath%>img/sign-error-icon.png");
				}
		},
			"json"
		);
	});
});	
function submitform(){
	var blog=true;
	var usernameInfo=$("#usernameInfo").text();
	var verificationCodeInput=document.getElementById("verificationCodeConfirm").src;
	if(usernameInfo.indexOf("用户不存在")>=0){
		alert("用户不存在");
		blog=false;
	}
	if(verificationCodeInput.indexOf("check")<0){
		/* alert("验证码不正确"); */
		blog=false;
	}
	
	/*  */
	return true;
};
</script>
<body style="background-image:url(<%=basePath%>img/background1.png);height: 750px;">
	<!--导航栏-->
	<jsp:include page="header.jsp"></jsp:include>
	<div class="container" style="margin-top:2%;">
			<div class="row" style="margin-top: 1%;" >
				<div class="col-lg-7"></div>
				<div class="col-lg-5 col-xs-12"align="center"style="border-radius:10px;background-color: rgba(255,250,240,0.8);text-align: center;font-size: 200%;">
					<div class="row" style="margin-top: 4%;vertical-align: middle;align-items: center;">
						<img src="<%=basePath%>img/login14.png" style="width: 30px;height: 30px;"/>
						<font style="font-weight: bold;">帐号登录</font>
					</div>
					<div class="row" style="margin-top: 4%;">
						<div class="col-lg-1 hidden-xs"></div>
						<div class="col-lg-11 col-xs-12" ><!-- onsubmit="return submitform()" -->
							<form class="bs-example bs-example-form" action="${pageContext.request.contextPath}/userLogin" method="post" onsubmit="return submitform()" >
								<div class="row">
									<div class="col-lg-8 col-xs-8" >
								 		<div class="form-group" style="margin-top: 2%;">
		           							<input type="text" class="form-control" placeholder="请输入用户名" id="username" name="userName">
								 		</div>
								 	</div>
								 	<div class="col-lg-4 col-xs-4" style="text-align: left;margin-top: 2%">
								 		<span style="font-size:initial;" id="usernameInfo"></span>
								 		<!--<img src="img/sign-check-icon.png" style="width: 20px;height: 20px;" />-->
								 	</div>
							 	</div>
							 	<div class="row" style="margin-top: 2%;">
								 	<div class="col-lg-8 col-xs-8" >
								 		<div class="form-group"style="margin-top: 2%;">
		           							<input type="password" class="form-control" placeholder="请输入密码"id="password" name="userPassword">
								 		</div>
								 	</div>
								 	<div class="col-lg-4 col-xs-4" style="text-align: left;">
								 		<span style="font-size: small;" id="passwordConfirm"></span>
								 		<!--<img src="img/sign-check-icon.png" style="width: 20px;height: 20px;" />-->
								 	</div>
							 	</div>
							 	<div class="row" style="margin-top: 2%;">
							 		<div class="col-lg-4 col-xs-4" >
									 	<div class="form-group" style="float: left;">
			           						<input type="text" class="form-control" placeholder="请输入验证码" id="verificationCode" name="verificationCode">
									 	</div>
									</div>
								 	<div class="col-lg-4 col-xs-4" >
								 		<img onclick="changeImg(this)" src="${pageContext.request.contextPath}/checkcode">
								 	</div>
								 	<div class="col-lg-2 col-xs-2" style="text-align: left;">
								 		<!--<span style="font-size: initial;" >验证码不正确</span>-->
								 		<img src="" id="verificationCodeConfirm" style="width: 20px;height: 20px;" />
								 	</div>
							 	</div>
							 	<div class="row" style="margin-top: 2%;margin-bottom: 4%;">
							 	<div class="col-lg-1 col-xs-1"></div>
								 	<div class="col-lg-6 col-xs-6" style="margin-top: 2%;">
								 		<span style="font-size:18px;color: red">${loginInfo}</span>
								 	</div>
								 	<div class="col-lg-8 col-xs-8" style="margin-top: 2%;float: right;">
								 		<a href="register" style="font-size: small;color: green;">去注册...</a> 
								 	</div>
							 	</div>
							 	<div class="row" style="margin-top: 2%;margin-bottom: 4%;">
								 	<div class="col-lg-4 col-xs-4"></div>
								 	<div class="col-lg-3 col-xs-4" style="margin-top: 2%;">
								 		<input type="submit" class="btn btn-block" style="background-color: brown;color: white;" value="登录"/>
								 	</div>
							 	</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>