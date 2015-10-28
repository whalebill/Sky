<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<base href="<%=basePath%>">

<title>Sky Movie My Order</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="Page-Enter" content="revealTrans(duration=5, transition=23)">
<meta http-equiv="Page-Exit" content="revealTrans(duration=5, transition=23)">

<link href="styles/global.css" type="text/css" rel="stylesheet" />
<link href="styles/myOrder.css" type="text/css" rel="stylesheet" />
<link href="styles/head.css" type="text/css" rel="stylesheet" />
<link href="styles/left.css" type="text/css" rel="stylesheet" />
<link href="styles/foot.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="/Sky/scripts/jquery-1.7.2.js"></script>
<script type="text/javascript" src="/Sky/scripts/global.js"></script>

<script type="text/javascript">
	function showfalgTime(i) {
		var ticketFlag=document.getElementById("ticketFlag"+i).value;
		if(!eval(ticketFlag)){
			document.getElementById("flagTime" + i).innerHTML = "Timeout";
			document.getElementById("operate" + i).innerHTML = "Invalid";
			return;
		}
		var playTime = document.getElementById("playTime" + i).innerHTML;

		var playDay = playTime;
		playDay = playDay.split("-");
		var endDay = new Date(playDay[0], playDay[1] - 1, playDay[2],
				playDay[3] - 3, playDay[4], 0);

		var now = new Date();
		if (now < endDay) {
			var hours = Math.floor((endDay - now) / 1000 / 3600);
			var minutes = Math.floor((endDay - now) / 1000 / 60 % 60);
			var seconds = Math.floor((endDay - now) / 1000 % 60);
			document.getElementById("flagTime" + i).innerHTML = hours + "h"
					+ minutes + "m" + seconds + "s";
			document.getElementById("hiddenOperate" + i).style.display="block";
		} else {
			document.getElementById("flagTime" + i).innerHTML = "Timeout";
			document.getElementById("operate" + i).innerHTML = "Invalid";
		}
	}
	//Loading Method
	window.onload = function() {
		for ( var i = 1; i <= parseInt(document.getElementById("size").value); i++) {
			window.setInterval("showfalgTime(" + i + ");", 1000);
		}
	};
</script>
</head>

<body>
	<s:if test="#request.ticketsByMemberByPage==null">
		<script>
			//location = "ticket!showOrder.action";
		</script>
	</s:if>
	<div id="header">
		<s:include value="head.jsp"></s:include>
	</div>
	<div id="main">
		<div id="main_top">
			<a href="index.jsp" class="aToptxt">Sky Movie</a>
			&nbsp;&gt;&nbsp;
			<a href="memberCenter.jsp" class="aToptxt">Account Center</a>
			&nbsp;&gt;&nbsp;
			<a href="myOrder.jsp" class="aToptxt">My Order</a>
		</div>

		<div id="main_left">
			<s:include value="left.jsp"></s:include>
		</div>

		<div id="main_right">
			<fieldset style="padding:10px;">
				<div id="main_right_top">【ERROR】</div>
				<div id="main_right_middle">
					Insufficient Balance!
				</div>
			</fieldset>
		</div>

	</div>
	<div id="footer">
		<s:include value="foot.jsp"></s:include>
	</div>

</body>

</html>
