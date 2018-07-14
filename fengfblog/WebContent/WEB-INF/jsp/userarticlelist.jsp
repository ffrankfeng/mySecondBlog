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
<title>首页</title>

<!-- 引入Bootstrap核心样式文件 -->
<link href="<%=basePath%>css/bootstrap.css" rel="stylesheet">
<link href="<%=basePath%>css/customize.css" rel="stylesheet">	
<!-- 引入jQuery核心js文件 -->
<script src="<%=basePath%>js/jquery-1.11.3.min.js"></script>
<!-- 引入BootStrap核心js文件 -->
<script src="<%=basePath%>js/bootstrap.min.js"></script>
</head>
<body style="background-color: whitesmoke;">
		<!--导航栏-->
		<jsp:include page="header.jsp"></jsp:include>
		<div class="container" style="margin-top:2%;">
			
			<div class="row" style="height: 800px;">
				<div class="col-lg-8 col-xs-12"style="height: 800px;">
					<div class="row" style="height: 30px;">
						<div class="col-lg-4" style="background-color:#FFFFCC;">
							<img src="<%=basePath%>img/reading.png" style="width: 40px;height: 40px;"/>
							<span style="font-weight:bold;font-size:large;">
								搜索
							</span>
						</div>
					</div>
					<br />
					<div class="row" style="background-color:white;border-bottom:1px solid #C5C5C5;">
					<div class="col-lg-12 col-xs-12" style="margin-top:2%;border-bottom: 1px solid #C5C5C5;" align="center">
						<c:if test="${!empty search }">
							<form   method="post" action="${pageContext.request.contextPath }/userarticlelist?userId=${search} " class="form-inline"  id="searchform" >
						</c:if>
						<c:if test="${empty search }">
							<form   method="post" action="${pageContext.request.contextPath }/userarticlelist" class="form-inline"  id="searchform" >
						</c:if>
						
						<div class="col-lg-10 col-xs-10" style="text-align: right;margin-bottom: 2%;">
				            <input type="text" class="form-control"style="width: 100%" id="title" name="title">
				        </div> 
				        <div class="col-lg-2 col-xs-2" style="text-align: left;margin-bottom: 2%;">         
				            <input type="submit" class="btn" value="查询">
				        </div> 
				        </form>
					</div>
					</div>
						

					<c:forEach items="${page.rows }" var="article"> 
						<div class="row" style="background-color:white;height: 145px;border-bottom:1px solid #C5C5C5;">
							<a href="showarticle?articleId=${article.articleId }">
							<div class="clo-lg" style="margin-top:2%;margin-left: 2%;">
								<h3 style="font-weight:bold;">
									${article.title }
								</h3>
								<div class="col-lg" style="height:40px ; color: #808080;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">
									${article.content }
								</div>
								<div class="col-lg" style="">
									<div class="col-lg-4 col-xs-4">
										<img src="<%=basePath%>img/person.png" style="width: 20px;height: 20px;"/>&nbsp;
										<font style="margin-top: 1%;">${article.author }</font>
									</div>
								</div>
							</div></a>
						</div>
					</c:forEach>
					<div class="col-md-12 text-right">
						<fengf:page url="${pageContext.request.contextPath }/userarticlelist" />
					</div>
				</div>
				<div class="col-lg-3 hidden-xs"style="margin-left: 15px; height: 800px;">
					<div class="row">
						<div class="col-lg" style="background-color: #FFFFCC;margin-top: 2px;margin-left: 2px;height: 30px;">
							<img src="<%=basePath%>img/expert.png" style="width: 20px;height: 21px;"/>&nbsp;
							<font size="4">热门博主</font>
						</div>
						<div class="col"style="background-color: whitesmoke;margin-top: 2px;margin-left: 2px;">
							<c:set var="row_count" value="0"></c:set>
							<c:forEach items="${hotUsers }" var="hotuser" >
								<c:set var="row_count" value="${row_count+1}" />
								<c:if test="${row_count == 1 }">
									<div class="col-lg" style="height: 70px;background-color: white;border-bottom:1px solid #C5C5C5;">
										<div class="col-lg">
											<img src="<%=basePath%>img/person.png" style="margin-top: 2px;margin-left: 2px;width: 36px;height: 36px;"/>&nbsp;
											<font size="2" style="font-weight: bold;">${hotuser.userName }</font>
											
											<span style="float: right;margin-top: 22px;margin-right: 4px;">篇</span>
											<span style="float: right;margin-top: 22px;margin-right: 4px;">${hotuser.articlecount }</span>
										</div>
										<div class="col-lg"style="margin-top: 2px;margin-left: 4px">
											<span style="font-size: small; color: #808080;">${hotuser.introduction }</span>
										</div>
									</div>
								</c:if>
								<c:if test="${row_count != 1 }">
									<div class="col-lg-6" style="height: 70px;background-color: white;">
										<div class="col-lg" style="height: 60px;width:125px;background-color: whitesmoke;">
											<div class="col-lg" style="margin-top: 5px;margin-left: 1px;" >
												<img src="<%=basePath%>img/person.png" style="margin-top: 1px;margin-left: 1px;width: 28px;height: 28px;"/>&nbsp;
												<font size="2" style="font-weight: bold;">${hotuser.userName }</font>
											</div>
											<div class="col-lg"style="margin-top: 4px;margin-left: 2px">
												<span style="font-size: small; color: #808080;">${hotuser.profession }</span>
											</div>
										</div>
									</div>
								</c:if>
							</c:forEach>
							
						</div>
					</div>
					<div class="row" style="margin-top: 4px;margin-bottom: 4px;">
							<img src="<%=basePath%>img/background1.png" style="width: auto;height: 155px;"/>
					</div>
					<div class="row">
						<div class="col-lg-12" style="background-color: #FFFFCC;margin-top: 2px;height: 30px;">
							<img src="<%=basePath%>img/recommendation.png" style="width: 20px;height: 21px;"/>&nbsp;
							<font size="4">今日推荐</font>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-12" style="background-color: white;margin-top: 2px;">
							<div class="row" >
								<div class="col-lg-12" style="background-color: white;border-bottom: 1px solid #C5C5C5;">
									<a><span id="title" style="font-size: large;">JAVA并发编程（高级版）</span></a><br />
									<span id="distri" style="font-size: small;"> 编写正确的程序并不容易，而编写...</span>
								</div>
								<div class="col-lg-12" style="background-color: white;border-bottom: 1px solid #C5C5C5;">
									<a><span id="title" style="font-size: large;">JAVA并发编程（高级版）</span></a><br />
									<span id="distri" style="font-size: small;"> 编写正确的程序并不容易，而编写...</span>
								</div>
								<div class="col-lg-12" style="background-color: white;border-bottom: 1px solid #C5C5C5;">
									<a><span id="title" style="font-size: large;">JAVA并发编程（高级版）</span></a><br />
									<span id="distri" style="font-size: small;"> 编写正确的程序并不容易，而编写...</span>
								</div>
								
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-12" style="background-color: #FFFFCC;margin-top: 2px;height: 30px;">
							<img src="<%=basePath%>img/content.png" style="width: 24px;height: 24px;"/>
							<font size="4" style="text-align: center;">联系我</font>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-12" style="background-color: white;margin-top: 2px;">
							<div class="row" >
								<div class="col-lg-12" style="background-color: white;border-bottom: 1px solid #C5C5C5;margin-top: 2px;margin-bottom: 2px;">
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
			</div>
		</div>
	</body>
</html>