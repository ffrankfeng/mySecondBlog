<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="">
			<nav class="navbar navbar-default" style="border-radius:0px;margin-bottom: 0px;">
				<div class="container-fluid">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
					        <span class="sr-only">Toggle navigation</span>
					        <span class="icon-bar"></span>
					        <span class="icon-bar"></span>
					        <span class="icon-bar"></span>
					    </button>
						<a class="navbar-brand" href="index">首页</a>
						<a class="navbar-brand hidden-lg" href="#"><img src="<%=basePath%>img/search.png" style="width: 18px;height: 18px;" /></a>
						<c:if test="${current_user == null }">
							<a class="navbar-brand hidden-lg" href="login">
						</c:if>
						<c:if test="${current_user != null }">
							<a class="navbar-brand hidden-lg" href="personcenter">
						</c:if>
						
						
						<img src="<%=basePath%>img/person.png" style="width: 18px;height: 18px;" /></a>
					</div>

					<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
						<ul class="nav navbar-nav">
							<li>
								<a href="#">关注</a>
							</li>
							<li>
								<a href="#">热门博主</a>
							</li>
							<li>
								<a href="moodshare">心情站</a>
							</li>
							<li class="visible-xs">
								<a href="${pageContext.request.contextPath }/userQuit">退出</a>
							</li>							
						</ul>
						<div class="nav navbar-nav navbar-right visible-lg" style="padding-top: 15px;">
							<c:if test="${empty current_user }">
							<a href="login">登录</a>
							<a href="register">注册</a>
							</c:if>
			
							<c:if test="${!empty current_user }">
							<a href="personcenter"><img src="<%=basePath%>img/person.png" style="width: 20px;height: 20px;" /></a>
							<a href="${pageContext.request.contextPath }/userQuit">退出</a>
							</c:if>
						</div>
						<form class="navbar-form navbar-right visible-lg" role="search">
							<div class="form-group">
								<input type="text" class="form-control" placeholder="Search">
								<img src="<%=basePath%>img/search.png" style="width: 18px;height: 18px;" />
							</div>
							<!--<button type="submit" class="btn btn-default">Submit</button>-->
						</form>
						<div class="nav navbar-nav navbar-right" >
							<ul class="nav navbar-nav">
							<li>
								<a href="writing" class="navbar-left"> <img src="<%=basePath%>img/write.png" style="width: 18px;height: 18px;" />
									<span>写文章</span>
								</a>
							</li>
							<li>
								<a href="mymoodshare" class="navbar-left"> <img src="<%=basePath%>img/mood.png" style="width: 18px;height: 18px;" />
									<span>发心情</span>
								</a>
							</li>
							</ul>
						</div>
					</div>
				</div>
			</nav>
		</div>