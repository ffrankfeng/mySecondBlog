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
<title>我的动态</title>
<link rel="icon" href="<%=basePath%>img/favicon.ico" type="image/x-icon">
<link rel="shortcut icon" href="<%=basePath%>img/favicon.ico" type="image/x-icon">
<!-- 引入Bootstrap核心样式文件 -->
<link href="<%=basePath%>css/bootstrap.css" rel="stylesheet">
<link href="<%=basePath%>css/customize.css" rel="stylesheet">	
<!-- 引入jQuery核心js文件 -->
<script src="<%=basePath%>js/jquery-1.11.3.min.js"></script>
<!-- 引入BootStrap核心js文件 -->
<script src="<%=basePath%>js/bootstrap.min.js"></script>
<script type="text/javascript">
function checksubmint(){
	var moodContent =$("#moodContent").val();
	var flag=true;
	if(moodContent==""){
		flag=false;
		alert("请输入文字");
	}

	return flag;
}
window.onload = function () {
	//选择图片类型
	var imgType = ["image/jpeg","image/png","image/x-png","image/bmp","image/gif"];
	
	//回显图片
    var fr = new FileReader(),
        file = document.getElementById("moodPic"),
        img = document.createElement("img");
	img.style="max-width:540px";
    file.onchange = function(e){
    	for(var i = 0 ; i < imgType.length ; i++){
        	if(file.files[0].type == imgType[i]){
        		fr.onload = function(e){
                    var res = this.result;
                    img.src = res;

                    document.getElementById("preImg").appendChild(img);//显示
                };

                fr.readAsDataURL(file.files[0]);//读取文件
                break;
        	}
        }
    }
}
$(document).ready(function(){
    $('#profilebar').load('ProfileBar');
})
</script>
</head>
<body style="background-color: rgb(240,242,245);min-height: 750px;">
<script>
    ! function() {
        //封装方法，压缩之后减少文件大小
        function get_attribute(node, attr, default_value) {
            return node.getAttribute(attr) || default_value;
        }
        //封装方法，压缩之后减少文件大小
        function get_by_tagname(name) {
            return document.getElementsByTagName(name);
        }
        //获取配置参数
        function get_config_option() {
            var scripts = get_by_tagname("script"),
                script_len = scripts.length,
                script = scripts[script_len - 1]; //当前加载的script
            return {
                l: script_len, //长度，用于生成id用
                z: get_attribute(script, "zIndex", -1), //z-index
                o: get_attribute(script, "opacity", 0.5), //opacity
                c: get_attribute(script, "color", "0,0,0"), //color
                n: get_attribute(script, "count", 99) //count
            };
        }
        //设置canvas的高宽
        function set_canvas_size() {
            canvas_width = the_canvas.width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth,
                canvas_height = the_canvas.height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
        }

        //绘制过程
        function draw_canvas() {
            context.clearRect(0, 0, canvas_width, canvas_height);
            //随机的线条和当前位置联合数组
            var e, i, d, x_dist, y_dist, dist; //临时节点
            //遍历处理每一个点
            random_points.forEach(function(r, idx) {
                r.x += r.xa,
                    r.y += r.ya, //移动
                    r.xa *= r.x > canvas_width || r.x < 0 ? -1 : 1,
                    r.ya *= r.y > canvas_height || r.y < 0 ? -1 : 1, //碰到边界，反向反弹
                    context.fillRect(r.x - 0.5, r.y - 0.5, 1, 1); //绘制一个宽高为1的点
                //从下一个点开始
                for (i = idx + 1; i < all_array.length; i++) {
                    e = all_array[i];
                    // 当前点存在
                    if (null !== e.x && null !== e.y) {
                    	
                        x_dist = r.x - e.x; //x轴距离 l
                        y_dist = r.y - e.y; //y轴距离 n
                        dist = x_dist * x_dist + y_dist * y_dist; //总距离, m

                        dist < e.max && (e === current_point && dist >= e.max / 2 && (r.x -= 0.03 * x_dist, r.y -= 0.03 * y_dist), //靠近的时候加速
                            d = (e.max - dist) / e.max,
                            context.beginPath(),
                            context.lineWidth = d / 2,
                            context.strokeStyle = "rgba(" + config.c + "," + (d + 0.2) + ")",
                            context.moveTo(r.x, r.y),
                            context.lineTo(e.x, e.y),
                            context.stroke());
                    
                    }
                }
            }), frame_func(draw_canvas);
        }
        //创建画布，并添加到body中
        var the_canvas = document.createElement("canvas"), //画布
            config = get_config_option(), //配置
            canvas_id = "c_n" + config.l, //canvas id
            context = the_canvas.getContext("2d"), canvas_width, canvas_height,
            frame_func = window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || function(func) {
                window.setTimeout(func, 1000 / 45);
            }, random = Math.random,
            current_point = {
                x: null, //当前鼠标x
                y: null, //当前鼠标y
                max: 20000 // 圈半径的平方
            },
            all_array;
        the_canvas.id = canvas_id;
        the_canvas.style.cssText = "position:fixed;top:0;left:0;z-index:" + config.z + ";opacity:" + config.o;
        get_by_tagname("body")[0].appendChild(the_canvas);

        //初始化画布大小
        set_canvas_size();
        window.onresize = set_canvas_size;
        //当时鼠标位置存储，离开的时候，释放当前位置信息
        window.onmousemove = function(e) {
            e = e || window.event;
            current_point.x = e.clientX;
            current_point.y = e.clientY;
        }, window.onmouseout = function() {
            current_point.x = null;
            current_point.y = null;
        };
        //随机生成config.n条线位置信息
        for (var random_points = [], i = 0; config.n > i; i++) {
            var x = random() * canvas_width, //随机位置
                y = random() * canvas_height,
                xa = 2 * random() - 1, //随机运动方向
                ya = 2 * random() - 1;
            // 随机点
            random_points.push({
                x: x,
                y: y,
                xa: xa,
                ya: ya,
                max: 6000 //沾附距离
            });
        }
        all_array = random_points.concat([current_point]);
        //0.1秒后绘制
        setTimeout(function() {
            draw_canvas();
        }, 100);
    }();

</script>
	<!--导航栏-->
	<jsp:include page="header.jsp"></jsp:include>
	<div class="container"style="margin-top:2%;">
			
			<div class="row" style="min-height: 600px;">
				<div class="col-lg-3 hidden-xs"style="margin-right: 45px;height: 800px;border-bottom: 1px solid #C5C5C5;background-color: white;"id="profilebar">
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
						<div class="" style="margin-bottom: 4%;border-bottom: 1px solid #C5C5C5;">
							<form name="form" action="${pageContext.request.contextPath }/writeMyMood" method="post" enctype="multipart/form-data" onsubmit="return checksubmint()">
								<div class="col-lg-10 col-xs-10" style="margin-bottom: 2%;">
									<textarea style="height: 100%;width: 100%;resize: none; maxlength="100"  onchange="this.value=this.value.substring(0, 100)" onkeydown="this.value=this.value.substring(0, 100)" onkeyup="this.value=this.value.substring(0, 100)"  id="moodContent" name="moodContent" placeholder="想说点什么。。。"></textarea>
								</div>
								<div class="col-lg-2 col-xs-2" >
									<input type="submit" class="btn btn-info" value="发布" style="margin-top:6px;size:70%;font-size: 80%;" />
								</div>
								
									<div class="box" id="preImg" style="margin-left: 4%;"></div>
									<input type="file" class="btn btn-info" accept="image/*" style="margin-left:3%;margin-bottom:4%; inline-block;" id="moodPic" name="moodPic">
								
								
							</form> 
						</div>
						<!--<input type="file" class="btn btn-default" accept="image/*" style="display: inline-block;">-->
<!-- 									<input type="file" name="picpath" id="picpath" style="display:none;"accept="image/*" onChange="document.form.path.value=this.value">
									<input name="path" id="path" class="btn btn-group-xs" readonly placeholder="请选择上传的图片"  style="font-size: 80%;">
									<input type="button" class="btn btn-default" value="上传照片" onclick="document.form.picpath.click()"style="font-size: 80%;">  -->
						<c:forEach items="${page.rows }" var="mood"> 
						<div class="col-lg-12 col-xs-12" style="margin-bottom: 2%;">
							<div class="col-lg-1 hidden-xs" style="margin-right: 2%;" >
								<img src="<%=basePath%>img/person.png" style="width: 50px;height: 50px;float: left;border-radius:25px;background-color: red;"/>&nbsp;
							</div>
							<div class="col-lg-8 col-xs-12" style="border: 1px solid #C5C5C5;">
								<font style="margin-top: 1%;font-size: small;">${mood.moodDate }</font>
								<div class="col-lg-12 col-xs-12" style="color: #808080;margin-top: 2%;">
									<span style="color: black;">
										${mood.moodContent }
										&nbsp;<br/>&nbsp;
									</span>
									<img src="${mood.moodPic }" class="col-xs-12" style="max-width: 600px;max-height: 600px;"/>
								</div>
								<div class="col-lg-12 col-xs-12" style="margin-top: 2%;border-bottom: 1px solid #C5C5C5;">
									 <div class="col-lg-3 col-xs-4"style="float: right;margin-bottom: 2%;">
										<img src="<%=basePath%>img/like3.png" style="width: 20px;height: 20px;" onclick=""/>&nbsp;
										<span style="font-size: large;">${mood.moodLike }</span>&emsp;

									</div>
								</div>
							</div>
						</div>
						</c:forEach>

						<div class="col-md-12 text-right">
							<fengf:page url="${pageContext.request.contextPath }/mymoodshare" />
						</div>
					</div>
				</div>
			</div>
		</div>
				<!-- 编辑对话框 -->
		<div class="modal" id="editDialog" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">修改信息</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" id="edit_customer_form" action="personEdit" method="post">
							<input type="hidden" id="edit_cust_id" name="cust_id"/>
							<div class="form-group">
								<label for="edit_userName" class="col-sm-2 control-label">用户名</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="edit_userName" value="${current_user.userName }" name="userName">
								</div>
							</div>	
							
							<div class="form-group">
								<label for="edit_email" class="col-sm-2 control-label">email</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="edit_email" value="${current_user.email }" name="email">
								</div>
							</div>
							<div class="form-group">
								<label for="edit_phone" class="col-sm-2 control-label">联系方式</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="edit_phone" value="${current_user.phone }" name="phone">
								</div>
							</div>
							<div class="form-group">
								<label for="edit_birthday" class="col-sm-2 control-label">生日</label>
								<div class="col-sm-10">
									<input type="date" class="form-control" id="edit_birthday" value="${current_user.birthday }" name="birthday">
								</div>
							</div>
							<div class="form-group">
								<label for="edit_sex" class="col-sm-2 control-label">性别</label>
								<div class="col-sm-10">
									
				                     <c:if test="${current_user.sex=='male'}">
				                    	<input type="radio" class="btn btn-success btn-sm" name="sex" id="sex" value="male" checked="checked">男
				                   		<input type="radio" class="btn btn-success btn-sm" name="sex" id="sex" value="female">女
				                     </c:if>
				                    <c:if test="${current_user.sex=='female'}">
				                    	<input type="radio" class="btn btn-success btn-sm" name="sex" id="sex" value="male" >男
				                   		<input type="radio" class="btn btn-success btn-sm" name="sex" id="sex" value="female" checked="checked">女
				                     </c:if>
								</div>
							</div>
							<div class="form-group">
								<label for="edit_profession" class="col-sm-2 control-label">行业</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="edit_profession" value="${current_user.profession }" name="profession">
								</div>
							</div>
							<div class="form-group">
								<label for="edit_introduction" class="col-sm-2 control-label">个人简介</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="edit_introduction" value="${current_user.introduction }" name="introduction">
								</div>
							</div>
							<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="submit" class="btn btn-primary" onclick="updateCustomer()">保存修改</button>
					</div>
						</form>
					</div>
					
				</div>
			</div>
		</div>
	</body>
	<script type="text/javascript">
		document.getElementById('edit_birthday').valueAsDate=document.getElementById('birthday').value;
</script>
	</body>
</html>