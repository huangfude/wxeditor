<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>微信图文在线编辑助手</title>
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<link rel="stylesheet" type="text/css" href="css/common.css">
<link rel="stylesheet" type="text/css" href="css/index.css">
<link rel="stylesheet" type="text/css" href="css/colorpicker.css">
<link rel="stylesheet" type="text/css" href="css/editor-min.css">
<script src="js/jquery-1.10.2.min.js" type="text/javascript"></script>
<script src="js/colorpicker-min.js" type="text/javascript"></script>
</head>
<body>

	<div class="wxeditor">
		<div class="clearfix">
			<div class="left clearfix">
				<div class="tabbox clearfix">
					<ul class="tabs" id="tabs">
						<li><a href="#" tab="tab1">默认</a></li>
						<li><a href="#" tab="tab2">标题</a></li>
						<li><a href="#" tab="tab3">正文</a></li>
						<li><a href="#" tab="tab4">分割线</a></li>
						<li><a href="#" tab="tab5">阅读全文</a></li>
						<li><a href="#" tab="tab6">图文样式</a></li>
						<li><a href="#" tab="tab7">关注</a></li>
						<li><a href="#" tab="tab9">模板</a></li>
						<li><a href="#" tab="tab8">更多</a></li>
					</ul>
					<em class="fr"></em>
				</div>
				<div class="tplcontent">
					<div id="colorpickerbox"></div>
					<div>
						<!-- 默认 -->
						<%@ include file="../data/temple_default.jsp" %>
						
						<!-- 标题 -->
						<%@ include file="../data/temple_title.jsp" %>
						
						<!-- 正文 -->
						<%@ include file="../data/temple_text.jsp" %>
						
						<!-- 分割线 -->
						<%@ include file="../data/temple_line.jsp" %>
						
						<!-- 阅读全文 -->
						<%@ include file="../data/temple_read.jsp" %>
						
						<!-- 图文样式 -->
						<%@ include file="../data/temple_style.jsp" %>
						
						<!-- 关注 -->
						<%@ include file="../data/temple_follow.jsp" %>
						
						<!-- 模板 -->
						<%@ include file="../data/temple_tpl.jsp" %>
						
						<!-- 更多 -->
						<%@ include file="../data/temple_more.jsp" %>
						
						
					</div>
				</div>
				<a title="使用说明" style="COLOR: #a5a5a5; TEXT-DECORATION: underline"
					href="#" target="_blank"><span style="COLOR: #a5a5a5">使用说明</span></a>
				<div class="goto">→</div>
			</div>
			<div class="right">
				<div id="bdeditor">
					<script charset="utf-8" src="ueditor/ueditor.config.js"
						type="text/javascript"></script>
					<script charset="utf-8" src="ueditor/ueditor.all.min.js"
						type="text/javascript">
						
					</script>
					<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
					<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
					<script charset="utf-8" src="ueditor/lang/zh-cn/zh-cn.js"
						type="text/javascript"></script>
					<script id="editor" style="width: 480px; height: 650px;"
						type="text/plain"></script>
				</div>
			</div>
		</div>


		<div id="previewbox">
			<div
				style="height: 100%; padding-right: 5px; -ms-overflow-y: scroll;">
				<div style="line-height: 24px; font-size: 18px; font-weight: 700;">这里填写你的图文标题</div>
				<div>
					<em
						style="color: rgb(140, 140, 140); font-size: 12px; font-style: normal;">2020-02-02</em>
					<a id="post-user"
						style="color: rgb(96, 127, 166); font-size: 12px;"
						href="javascript:void(0);">通讯报社</a>
				</div>
				<div id="preview"></div>
			</div>

			<div id="phoneclose"
				style="top: 40px; width: 50px; height: 50px; right: 50px; font-size: 50px; font-weight: 600; position: absolute; cursor: pointer;">X</div>
		</div>

		<div class="fullshowbox">全屏</div>
		<div class="fullhidebox">退出</div>
		<div id="phone">手机预览</div>

	</div>


	<script>
		function launchFullscreen(a) {
			if (a.requestFullscreen) {
				a.requestFullscreen()
			} else {
				if (a.mozRequestFullScreen) {
					a.mozRequestFullScreen()
				} else {
					if (a.msRequestFullscreen) {
						a.msRequestFullscreen()
					} else {
						if (a.webkitRequestFullscreen) {
							a.webkitRequestFullScreen()
						}
					}
				}
			}
		};
		function exitFullscreen() {
			if (document.exitFullscreen) {
				document.exitFullscreen()
			} else {
				if (document.mozCancelFullScreen) {
					document.mozCancelFullScreen()
				} else {
					if (document.webkitExitFullscreen) {
						document.webkitExitFullscreen()
					}
				}
			}
		};
		function fullscreenElement() {
			return document.fullscreenElement
					|| document.webkitCurrentFullScreenElement
					|| document.mozFullScreenElement || null
		};
		$(function() {
			$("#phoneclose").on('click', function() {
				$("#previewbox").hide()
			});
			$("#phone").on('click', function() {
				if ($("#previewbox").css("display") == "block") {
					$("#previewbox").hide();
				} else {
					$("#previewbox").show();
				}
			});
			$(window)
					.on(
							'fullscreenchange webkitfullscreenchange mozfullscreenchange',
							function() {
								if (!fullscreenElement()) {
									$('.wxeditor').css({
										margin : '0'
									});
								}
							});
			$('.fullshowbox').on('click', function() {
				$('.wxeditor').css({
					margin : '50px 0'
				});
				launchFullscreen(document.documentElement)
			});
			$('.fullhidebox').on('click', function() {
				$('#wxeditortip,#header').show();
				exitFullscreen()
			});
			var b = [ "borderTopColor", "borderRightColor",
					"borderBottomColor", "borderLeftColor" ], d = [];
			$.each(b, function(a) {
				d.push(".itembox .wxqq-" + b[a])
			});
			$("#colorpickerbox").ColorPicker({
				flat : true,
				color : "#00bbec",
				onChange : function(a, e, f) {
					$(".itembox .wxqq-bg").css({
						backgroundColor : "#" + e
					});
					$(".itembox .wxqq-color").css({
						color : "#" + e
					});
					$.each(d, function(g) {
						$(d[g]).css(b[g], "#" + e)
					})
				}
			});
			var c = UE.getEditor("editor", {
				topOffset : 0,
				autoFloatEnabled : false,
				autoHeightEnabled : false,
				autotypeset : {
					removeEmptyline : true
				},
				toolbars : [
						[ "forecolor", "backcolor", "bold", "italic",
								"underline", "strikethrough", "link", "unlink",
								"paragraph", "fontfamily", "fontsize", ],
						[ "undo", "redo", "indent", "justifyleft",
								"justifyright", "justifycenter",
								"justifyjustify", "insertorderedlist",
								"insertunorderedlist", "horizontal",
								"removeformat", "blockquote", ] ]
			});
			c
					.ready(function() {
						c
								.addListener(
										'contentChange',
										function() {
											$("#preview")
													.html(
															c.getContent()
																	+ '<div><a style="font-size:12px;color:#607fa6" href="javascript:void(0);" id="post-user">阅读原文</a> <em style="color:#8c8c8c;font-style:normal;font-size:12px;">阅读 100000+</em><span class="fr"><a style="font-size:12px;color:#607fa6" href="javascript:void(0);">举报</a></span></div>');
										});
						$(".itembox").on(
								"click",
								function(a) {
									c.execCommand("insertHtml", "<div>"
											+ $(this).html() + "</div><br />")
								})
					});
			$(".tabs li a").on(
					"click",
					function() {
						$(this).addClass("current").parent().siblings().each(
								function() {
									$(this).find("a").removeClass("current")
								});
						$("#" + $(this).attr("tab")).show().siblings().hide()
					})
		});
	</script>
</body>
</html>
