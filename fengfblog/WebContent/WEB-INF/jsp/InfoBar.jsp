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
</head>
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
						<div class="col-lg"style="margin-left: 2px;">
							<img src="<%=basePath%>img/person.png" style="margin-top: 2px;margin-left: 2px;width: 36px;height: 36px;"/>&nbsp;
							<a href="personcenter?userId=${hotuser.userId}"><font size="2" style="font-weight: bold;">${hotuser.userName }</font></a>
							
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
								<a href="personcenter?userId=${hotuser.userId}"><font size="2" style="font-weight: bold;">${hotuser.userName }</font></a>
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
				<c:forEach items="${hotArticles }" var="hotArticle">
					<div class="col-lg-12" style="background-color: white;height:60px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;border-bottom: 1px solid #C5C5C5;width:280px">
						<a href="showarticle?articleId=${hotArticle.articleId }"><span id="title" style="font-size: large;">${hotArticle.title }</span><br />
						<span id="distri"  style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">${hotArticle.content }</span></a>
					</div>
				</c:forEach>
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
</html>