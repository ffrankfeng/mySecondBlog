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
<title>文字标题</title>

<!-- 引入Bootstrap核心样式文件 -->
<link href="<%=basePath%>css/bootstrap.css" rel="stylesheet">
<link href="<%=basePath%>css/customize.css" rel="stylesheet">	
<!-- 引入jQuery核心js文件 -->
<script src="<%=basePath%>js/jquery-1.11.3.min.js"></script>
<!-- 引入BootStrap核心js文件 -->
<script src="<%=basePath%>js/bootstrap.min.js"></script>
<script type="text/javascript">
	function attention(authorId){
		$.post(
				"${pageContext.request.contextPath}/attention",
				{"userId":authorId},
				function(data){
					var isFinish=data.isFinish;
					if(isFinish == false){
						alert("关注失败");
					}else{
						alert("关注成功");
						location.reload();
					}
				},
				"json"
		);
}
function deleteAttention(authorId){
	if(confirm("确定不再关注ta？")){	
		$.post(
				"${pageContext.request.contextPath}/deleteAttention",
				{"userId":authorId},
				function(data){
					var isFinish=data.isFinish;
					if(isFinish == false){
						alert("取消关注失败");
					}else{
						alert("取消关注成功");
						location.reload();
					}
				},
				"json"
		);
	}
}
function likeAndDislike(articleId,flag){
		if(flag){
			$.post(
					"${pageContext.request.contextPath}/likeAndDislike",
					{"flag":flag,"articleId":articleId},
					function(data){
						var isFinish=data.isFinish;
						if(isFinish == false){
							alert("操作失败");
						}else{
							location.reload();
						}
					},
					"json"
			);
		}else{
			$.post(
					"${pageContext.request.contextPath}/likeAndDislike",
					{"flag":flag,"articleId":articleId},
					function(data){
						var isFinish=data.isFinish;
						if(isFinish == false){
							alert("操作失败");
						}else{
							location.reload();
						}
					},
					"json"
				);
		}
		
	}

function articlecomment(articleId,author,authorId){
	var commentContent = $("#commentContent").val();
	var at=commentContent.indexOf("@");
	var flag=commentContent.substring(0,at+1);
	if(flag == '@' && at == 0 ){
		var end=commentContent.indexOf(":");
		var str=commentContent.substring(1,end);
		var str2=commentContent.substring(end+1,commentContent.length);
		alert(str2);
		if($.trim(str2) == ''){
				alert("评论内容不能为空");
				return false;
		}else{
			alert("str2="+str2);
			$.post(
					"${pageContext.request.contextPath}/articlecomment",
					{"articleId":articleId,"toUsername":str,"topicType":"reply","toUid":authorId,"commentContent":str2},
					function(data){
						var isFinish=data.isFinish;
						if(isFinish == false){
							alert("评论失败");
						}else{
							alert("评论成功");
							location.reload();
						}
					},
					"json"
				);
			}
	}else{
		 if(commentContent == ""){
				alert("评论内容不能为空");
				return false;
			}
			$.post(
					"${pageContext.request.contextPath}/articlecomment",
					{"articleId":articleId,"toUsername":author,"toUid":authorId,"commentContent":commentContent},
					function(data){
						var isFinish=data.isFinish;
						if(isFinish == false){
							alert("评论失败");
						}else{
							alert("评论成功");
							location.reload();
						}
					},
					"json"
				);
	}
}
function reply(fromUid,fromUsername){
	document.getElementById('commentContent').value = "@"+fromUsername+": ";
	document.getElementById('commentContent').focus();
}
</script>
<body style="background-color: whitesmoke;">
	<!--导航栏-->
	<jsp:include page="header.jsp"></jsp:include>
	<div class="navbar navbar-default" style="margin-top:0px;border-radius:0px;">
		<div class="col-lg-12 col-xs-12" style="padding:0;height: 120px;background-image: url(<%=basePath%>img/author.png);background-size: cover;">
				<div id="col-lg-12 col-xs-12" style="margin-top: 35px;">
					<span  style="font-weight:bold;font-size:200%;margin-left: 10%;">
						${article.author }的博文	
					</span>
					<c:if test="${isAttention == false}">
						<input type="button" class="btn btn-default" onclick="attention(${article.authorId })" style="width:100px;float: right;margin-right: 20%;color: red;border-color: red;" value="关注" />
					</c:if>
					<c:if test="${isAttention == true}">
						<input type="button" class="btn btn-default" onclick="deleteAttention(${article.authorId })" style="width:100px;float: right;margin-right: 20%;color: red;background-color:#FF9966; border-color:#FF9900;" value="已关注" />
					</c:if>

				</div>
			</div>
		</div>
	<div class="container"style="margin-top:2%;">
			
			<div class="row" style="min-height: 800px;">
				
				<div class="col-lg-8 col-xs-12"style="min-height: 800px;margin-top: 3%;background-color:white;">
					<div class="col-lg-12 col-xs-12" style="">
						<span style="font-weight:bold;font-size:200%">
							${article.title }
						</span>
					</div>
					<div class="col-lg-4 col-xs-4"style="margin-top: 2%;">${article.uptime }</div>
					<div class="col-lg-6 col-xs-6"style="margin-top: 2%;">
						<span style="font-size: small;">${article.keyword1 }</span>
						<span style="font-size: small;">${article.keyword2 }</span>
						<span style="font-size: small;">${article.keyword3 }</span>
					</div>
					<div class="col-lg-2 col-xs-2"style="margin-top: 2%;">
						<span style="font-size: small;">阅读:</span>
						<span style="font-size: small;">${article.reading }</span>
					</div>
					<div class="col-lg-12 col-xs-12" style="border-bottom: 1px solid #C5C5C5;"></div>
					<div class="col-lg-12 col-xs-12" style="margin-top: 4%; margin-bottom:6%">
						<span >
							${article.content }
						</span>
					</div>
					<div class="col-lg-4 col-xs-4"></div>
					<c:if test="${articlelike == null}">
						<div class="col-lg-3 col-xs-3" style="vertical-align: middle;">
							<span id="thumbsup" style="font-size: large;"><a onclick="likeAndDislike(${article.articleId },true)"><img src="<%=basePath%>img/like3.png" style="width: 30px;height: 30px;" onclick="" /></a>
							&emsp;${article.likecount }</span>
						</div>
						<div class="col-lg-3 col-xs-3" style=" vertical-align: middle;">
							<span id="disthumbsup" style="font-size: large;"><a onclick="likeAndDislike(${article.articleId },false)"><img src="<%=basePath%>img/dislike.png" style="width: 30px;height: 30px;"/></a>
							&emsp;${article.dislike }</span>
						</div>
					</c:if>
					<c:if test="${articlelike != null}">
						<c:if test="${articlelike.likeordislike == 'like'}">
							<div class="col-lg-3 col-xs-3" style="vertical-align: middle;">
								<span id="thumbsup" style="font-size: large;color: red"><img src="<%=basePath%>img/finishlike.png" style="width: 30px;height: 30px;" onclick="" />
								&emsp;${article.likecount }</span>
							</div>
							<div class="col-lg-3 col-xs-3" style=" vertical-align: middle;">
								<span id="disthumbsup" style="font-size: large;"><img src="<%=basePath%>img/dislike.png" style="width: 30px;height: 30px;"/>
								&emsp;${article.dislike }</span>
							</div>
						</c:if>
						
						<c:if test="${articlelike.likeordislike == 'dislike'}">
							<div class="col-lg-3 col-xs-3" style="vertical-align: middle;">
								<span id="thumbsup" style="font-size: large;"><img src="<%=basePath%>img/like3.png" style="width: 30px;height: 30px;" onclick="" />
								&emsp;${article.likecount }</span>
							</div>
							<div class="col-lg-3 col-xs-3" style=" vertical-align: middle;">
								<span id="disthumbsup" style="font-size: large;color: #DDDDDD"><img src="<%=basePath%>img/finishdislike3.png" style="width: 30px;height: 30px;"/>
								&emsp;${article.dislike }</span>
							</div>
						</c:if>
					</c:if>
								
					<div class="col-lg-12 col-xs-12" style="margin-top: 4%;height: 80px;">
						<form name="form" method="post" >
							<div class="col-lg-10 col-xs-10" style="margin-bottom: 2%;">
								<textarea style="height: 100%;width: 100%;resize: none; maxlength="100"  onchange="this.value=this.value.substring(0, 100)" onkeydown="this.value=this.value.substring(0, 100)" onkeyup="this.value=this.value.substring(0, 100)"  id="commentContent" name="commentContent" placeholder="想说点什么。。。"></textarea>
							
							</div>
							<div class="col-lg-2 col-xs-2" >
								<input type="button" class="btn btn-info" style="margin-left: 2%;margin-top: 6px;" value="发布" style="font-size: 80%;" onclick="articlecomment(${article.articleId},${article.author },${article.authorId })" />
							</div>	
							</form> 
						
					</div>
					<c:forEach items="${commentList }" var="comment">
						<div class="col-lg-12 col-xs-12" style="margin-top: 2%;margin-bottom: 2%;border-bottom: 1px solid #C5C5C5;">
							<span style="margin-top: 2%;font-size: large;">
							${comment.fromUsername }
							</span>
							<span style="margin-top: 2%;margin-left: 4%;">
							${comment.commentTime }
							</span>
							<a onclick="reply('${comment.fromUid}','${comment.fromUsername }')"><span style="margin-top: 2%;margin-left: 4%;">回复</span></a>
							<br/>
							<c:if test="${comment.topicType == 'reply'}">
								<span style="margin-top: 2%;margin-left: 1%;">
									@ ${comment.toUsername }: 
								</span>
							</c:if>
							<span style="margin-top: 2%;margin-left: 1%;">
							${comment.commentContent }
							</span>
							<div class="col-lg-12 col-xs-12" style="height: 10px"></div>
						</div>		
					</c:forEach>
					<div class="col-lg-12 col-xs-12" style="height: 80px"></div>
				</div>
				<div class="col-lg-3 hidden-xs"style="margin-left: 15px; height: 800px;">
					<div class="row">
						<div class="col-lg" style="background-color: #FFFFCC;margin-top: 2px;margin-left: 2px;height: 30px;">
							<img src="<%=basePath%>img/expert.png" style="width: 20px;height: 21px;"/>&nbsp;
							<font size="4">个人资料</font>
						</div>
						<div class="col"style="background-color: whitesmoke;margin-top: 2px;margin-left: 2px;">
							<div class="col-lg" style="height: 70px;background-color: white;">
								<div class="col-lg">
									<img src="<%=basePath%>img/person.png" style="margin-top: 2px;margin-left: 2px;width: 36px;height: 36px;"/>&nbsp;
									<font size="2" style="font-weight: bold;">${articleAuthor.userName }</font>
								</div>
								<div class="col-lg"style="margin-top: 2px;margin-left: 4px">
									<span style="font-size: small; color: #808080;">${articleAuthor.introduction }</span>
								</div>
								<div class="col-lg-12 col-xs-12" style="margin-top: 4%; height: 70px;background-color: white;border-bottom: 1px solid #C5C5C5;">
									<table class="col-lg-12 col-xs-12" style="margin-top: 2%;text-align: center;">
										<tr >
											<td>关注</td>
											<td>粉丝</td>
											<td>心情</td>
											<td>文章</td>
										</tr>
										<tr>
												<td><span>${articleAuthor.attention }</span></td>
												<td><span>${articleAuthor.fans }</span></td>
												<td><span>${articleAuthor.moodcount }</span></td>
												<td><span>${articleAuthor.articlecount }</span></td>
											</tr>
										</table>
										
								</div>
							</div>

						</div>
					</div>
					<div class="row" style="margin-top: 4px;margin-bottom: 4px;">
							<img src="<%=basePath%>img/background1.png" style="width: auto;height: 155px;"/>
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