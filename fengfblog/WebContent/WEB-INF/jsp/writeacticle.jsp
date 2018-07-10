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
<title>创作中ing</title>

<!-- 引入Bootstrap核心样式文件 -->
<link href="<%=basePath%>css/bootstrap.css" rel="stylesheet">
<link href="<%=basePath%>css/customize.css" rel="stylesheet">	
<!-- 引入jQuery核心js文件 -->
<script src="<%=basePath%>/js/jquery-1.11.3.min.js"></script>
<!-- 引入BootStrap核心js文件 -->
<script src="<%=basePath%>js/bootstrap.min.js"></script>
<script src="<%=basePath%>ueditor/ueditor.config.js"></script>
<script src="<%=basePath%>ueditor/ueditor.all.min.js"></script>
<script src="<%=basePath%>ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript">
var ue = UE.getEditor('editor', {
    toolbars: [
        [ 'undo', 'redo', '|',
         'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',
         'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
         'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|',
         'directionalityltr', 'directionalityrtl', 'indent', '|',
         'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'touppercase', 'tolowercase', '|',
         'link', 'unlink', 'imagenone', 'imageleft', 'imageright', 'imagecenter', '|',
         'simpleupload', 'insertimage', 'emotion', 'scrawl','insertcode', 
          'snapscreen','inserttable'
         ]
    ],
    autoHeightEnabled: true,
    autoFloatEnabled: true
});
function getContent() {

    var article=UE.getEditor('editor').getContent();
    var title=$("#title").val();
    var isOpen=$("#isOpen").val();
    var keyword1=$("#keyword1").val();
    var keyword2=$("#keyword2").val();
    var keyword3=$("#keyword3").val();
    if(article != null && article !="" && title != null && title != ""){
        $.post(
    			"${pageContext.request.contextPath}/savewriting",//url地址
    			{"title":title,"content":article,"isopen":isOpen,"keyword1":keyword1,"keyword2":keyword2,"keyword3":keyword3},//请求参数
    			function(data){//执行成功后的回调函数
    				var isFinish=data.isFinish;
    			if(isFinish){
    				alert("提交成功！");
    				window.location.href="index";
    			}else{
    				alert("提交失败请重新尝试");
    			}
    			},
    			"json"
    	);
    }else{
    	alert("请填写完整文章");
    }


}
</script>
</head>
<body style="background-image:url(<%=basePath%>img/background1.png);">
	<!--导航栏-->
	<jsp:include page="header.jsp"></jsp:include>
	<div class="container" style="margin-top:2%;">
			<div class="row" style="margin-top: 1%;" >
				<div class="col-lg-1"></div>
				<div class="col-lg-10 col-xs-12"align="center"style="border-radius:10px;background-color: rgba(255,250,240,0.8);text-align: center;font-size: 200%;">
					<div class="row" style="margin-top: 2%;vertical-align: middle;align-items: center;">
						<img src="<%=basePath%>img/sign_up.png" style="width: 30px;height: 30px;"/>
						<font style="font-weight: bold;">创作中ing</font>
					</div>
					<div class="row" style="margin-top: 2%;margin-bottom: 2%;">
							<div class="col-lg-2"></div>
							<div class="col-lg-8" style="margin-top: 2%;margin-bottom: 4%;">
								<input type="text" id="title" name="title" class="form-control" placeholder="输入文章标题" />
							</div>
							<div  class="col-lg-12" style="">
								<script id="editor" type="text/plain" style="width:100%;height:500px;"></script>
							</div>
							<div class="col-lg-3"></div>
							<div class="col-lg-6" style="margin-top: 4%;text-align: left;">
								<label style="font-size: initial;">公开:</label>
								<input id="isOpen"  name="isOpen" type="checkbox" style="margin-left: 5%;" checked="checked"/><br />
								<label style="font-size: initial;">标签:</label>
								<input type="text" class="form-inline" style="margin-left: 5%;width: 22%;height:70%;border-radius: 10px;" id="keyword1" name="keyword1"/>
								<input type="text" class="form-inline" style="margin-left: 5%;width: 22%;height:70%;border-radius: 10px;" id="keyword2" name="keyword2"/>
								<input type="text" class="form-inline" style="margin-left: 5%;width: 22%;height:70%;border-radius: 10px;" id="keyword3" name="keyword3"/><br />
							</div>
							<div class="col-lg-5 col-xs-4"></div>
							<div class="col-lg-6 col-xs-6" style="margin-top: 4%;text-align: left;">
								<button  class="btn btn-default"style="background-color: brown;color: white; " onclick="getContent()" >发布</button>&emsp;
								<button  class="btn btn-default"style="background-color: brown;color: white;" onclick="javascript:history.go(-1);" >返回</button>
							</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>