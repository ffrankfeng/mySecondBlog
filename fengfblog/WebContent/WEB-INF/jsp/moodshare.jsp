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
<title>全部动态</title>

<!-- 引入Bootstrap核心样式文件 -->
<link href="<%=basePath%>css/bootstrap.css" rel="stylesheet">
<link href="<%=basePath%>css/customize.css" rel="stylesheet">	
<!-- 引入jQuery核心js文件 -->
<script src="<%=basePath%>js/jquery-1.11.3.min.js"></script>
<!-- 引入BootStrap核心js文件 -->
<script src="<%=basePath%>js/bootstrap.min.js"></script>
</head>
<body style="background-image:url(<%=basePath%>img/background1.png);">
	<!--导航栏-->
	<jsp:include page="header.jsp"></jsp:include>
	<div class="container"style="margin-top:2%;">
			<div class="row" style="min-height: 600px;">
				<div class="col-lg-3 hidden-xs"style="margin-right: 45px;height: 800px;border-bottom: 1px solid #C5C5C5;background-color: white;">
					<div class="row" style=" ">
						<div class="col-lg-6 col-xs-6" style="border-radius:0 40px 40px 0;background-color: #FFFFCC;vertical-align: middle;margin-top: 2px;margin-left: 2px;height: 30px;border-bottom: 1px solid #C5C5C5;">
							<img src="<%=basePath%>img/expert.png" style="width: 20px;height: 21px;"/>&nbsp;
							<font size="4">我的资料</font>
						</div>
						
						<div class="col-lg-12 col-xs-12" style="vertical-align: middle;border-top: 1px solid #C5C5C5;">
						
							<img src="<%=basePath%>img/person.png" style="margin-top: 2%;margin-left: 2%;width: 60px;height: 60px;background-color: red;border-radius:50px ;"/>&nbsp;
						
						
							<font size="2" style="font-weight: bold;">博主</font>
							<span style="float: right;margin-top: 2px;margin-right: 4px;">修改</span>
							<img src="<%=basePath%>img/file_edit48.png" style="margin-top: 4px;float: right;width: 15px;height: 15px;"/>
							
						</div>
						<div class="col-lg-1 col-xs-1" style="margin-top: 3%;"></div>
						<div class="col-lg-10 col-xs-10" style="margin-top: 3%;">
							<table style="margin-top: 2%;font-weight: 560;">
										<tr>
											<td>性别:</td>
											<td><span>男</span></td>
											
										</tr>
										<tr>
											<td>生日：</td>	
											<td><span>2018-6-30</span></td>		
										</tr>
										<tr>
											<td>行业：</td>
											<td><span>IT</span></td>
										</tr>
										<tr>
											<td>金币：</td>
											<td><span>0</span></td>
										</tr>
										</table>
						</div>
						<div class="col-lg-12 col-xs-12"style="margin-top: 2%;margin-bottom: 2%;margin-left: 4%;">
							<span style="font-size: small; color: #808080;">程序设计，软件工程，人工智能的技术博客</span>
						</div>
											
						<div class="col-lg-12 col-xs-12" style="margin-top: 4%; height: 70px;background-color: white;border-top: 1px solid #C5C5C5;border-bottom: 1px solid #C5C5C5;">
									<table class="col-lg-12 col-xs-12" style="margin-top: 2%;text-align: center;">
										<tr >
											<td>关注</td>
											<td>粉丝</td>
											<td>心情</td>
											<td>文章</td>
										</tr>
										<tr>
												<td><span>0</span></td>
												<td><span>0</span></td>
												<td><span>0</span></td>
												<td><span>0</span></td>
											</tr>
										</table>
										
						</div>
					</div>
				
					
					<div class="row">
						<div class="col-lg-6 col-xs-6" style="background-color: #FFFFCC;margin-top: 2px;height: 30px;border-radius: 0 40px 40px 0;border-bottom: 1px solid #C5C5C5;">
							<img src="<%=basePath%>img/content.png" style="width: 24px;height: 24px;"/>
							<font size="4" style="text-align: center;">联系我</font>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-12 col-xs-12" style="background-color: white;margin-top: 2px;border-top: 1px solid #C5C5C5;">
							<div class="row" >
								<div class="col-lg-12 col-xs-12" style="background-color: white;border-bottom: 1px solid #C5C5C5;margin-top: 2px;margin-bottom: 2px;">
									<img src="<%=basePath%>img/email.png" style="width: 33px;height: 33px;"/>
									<span id="distri" style="font-size:  initial;"> 95111539@qq.com</span><br/>
									<img src="<%=basePath%>img/phone.png" style="width: 33px;height: 33px;"/>
									<span id="distri" style="font-size: initial;"> 15366363203</span><br/>
									<img src="<%=basePath%>img/qq.png" style="width: 33px;height: 33px;"/>
									<span id="distri" style="font-size: initial;"> 951115439</span>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-8 col-xs-12" style="background-color: white;">
					<div class="row" style="border-bottom: 1px solid #C5C5C5;">
						<div class="col-lg-4 col-xs-4" style="background-color:#FFFFCC;border-radius:0 40px 40px 0;vertical-align: middle;">
							<img src="<%=basePath%>img/favourites2.png" style="width: 30px;height: 30px;"/>
							<font style="font-weight:bold;font-size:400;">
								全部动态
							</font>
							
						</div>
					</div>
					<br />
					<div class="row" style="background-color:white;height: 145px;">
						<div class="clo-lg-12 col-xs-12" style="margin-left: 2%;">
							<div class="col-lg-12 col-xs-12" style="margin-bottom: 2%;margin-top: 2%;">
									<img src="<%=basePath%>img/person.png" style="width: 50px;height: 50px;border-radius:25px;background-color: red;"/>&nbsp;
									<font style="margin-top: 1%;font-size: large;">默认用户</font>&emsp;
									<font style="margin-top: 1%;font-size: small;">2018年7月1日 09:37</font>
							</div>
							<div class="col-lg-12 col-xs-12" style="color: #808080;">
								<span>
									在面试的后期，往往都会问性能优化的问题，譬如你优化过 JVM 吗，有没有遇到过 JVM 排查的场景，如果只能说点基本的见解，那面试官给你的定岗定薪很有可能是初级，…
								</span><br />
								<img src="<%=basePath%>img/content.png" class="col-xs-12" style="max-width: 600px;max-height: 600px;"/>
							</div>
							<div class="col-lg-12 col-xs-12" style="margin-top: 2%;border-bottom: 1px solid #C5C5C5;">
								<div class="col-lg-3 col-xs-6"style="float: right;margin-bottom: 2%;">
									<img src="<%=basePath%>img/like3.png" style="width: 20px;height: 20px;" onclick="#"/>&nbsp;
									<span style="font-size: large;">123</span>&emsp;
									<img src="<%=basePath%>img/dislike.png" style="width: 20px;height: 20px;" onclick="#"/>&nbsp;
									<span style="font-size: large;">123</span>
								</div>
							</div>
						</div>
						<div class="clo-lg-12 col-xs-12" style="margin-left: 2%;">
							<div class="col-lg-12 col-xs-12" style="margin-bottom: 2%;margin-top: 2%;">
									<img src="<%=basePath%>img/person.png" style="width: 50px;height: 50px;border-radius:25px;background-color: red;"/>&nbsp;
									<font style="margin-top: 1%;font-size: large;">默认用户</font>&emsp;
									<font style="margin-top: 1%;font-size: small;">2018年7月1日 09:37</font>
							</div>
							<div class="col-lg-12 col-xs-12" style="color: #808080;">
								<span>
									在面试的后期，往往都会问性能优化的问题，譬如你优化过 JVM 吗，有没有遇到过 JVM 排查的场景，如果只能说点基本的见解，那面试官给你的定岗定薪很有可能是初级，…
								</span><br />
								<img src="<%=basePath%>img/background1.png" class="col-xs-12" style="max-width: 600px;max-height: 600px;"/>
							</div>
							<div class="col-lg-12 col-xs-12" style="margin-top: 2%;border-bottom: 1px solid #C5C5C5;">
								<div class="col-lg-3 col-xs-6"style="float: right;margin-bottom: 2%;">
									<img src="<%=basePath%>img/like3.png" style="width: 20px;height: 20px;" onclick="#"/>&nbsp;
									<span style="font-size: large;">123</span>&emsp;
									<img src="<%=basePath%>img/dislike.png" style="width: 20px;height: 20px;" onclick="#"/>&nbsp;
									<span style="font-size: large;">123</span>
								</div>
							</div>
						</div>
						<div class="clo-lg-12 col-xs-12" style="margin-left: 2%;">
							<div class="col-lg-12 col-xs-12" style="margin-bottom: 2%;margin-top: 2%;">
									<img src="<%=basePath%>img/person.png" style="width: 50px;height: 50px;border-radius:25px;background-color: red;"/>&nbsp;
									<font style="margin-top: 1%;font-size: large;">默认用户</font>&emsp;
									<font style="margin-top: 1%;font-size: small;">2018年7月1日 09:37</font>
							</div>
							<div class="col-lg-12 col-xs-12" style="color: #808080;">
								<span>
									在面试的后期，往往都会问性能优化的问题，譬如你优化过 JVM 吗，有没有遇到过 JVM 排查的场景，如果只能说点基本的见解，那面试官给你的定岗定薪很有可能是初级，…
								</span><br />
								<img src="<%=basePath%>img/author.png" class="col-xs-12" style="max-width: 600px;max-height: 600px;"/>
							</div>
							<div class="col-lg-12 col-xs-12" style="margin-top: 2%;border-bottom: 1px solid #C5C5C5;">
								<div class="col-lg-3 col-xs-6"style="float: right;margin-bottom: 2%;">
									<img src="<%=basePath%>img/like3.png" style="width: 20px;height: 20px;" onclick="#"/>&nbsp;
									<span style="font-size: large;">123</span>&emsp;
									<img src="<%=basePath%>img/dislike.png" style="width: 20px;height: 20px;" onclick="#"/>&nbsp;
									<span style="font-size: large;">123</span>
								</div>
							</div>
							<div class="col-md-12 text-right">
								<fengf:page url="${pageContext.request.contextPath }/moodshare" />
							</div>
						</div>
					</div>
					
						
					
				
				</div>
			</div>
		</div>
	</body>
</html>