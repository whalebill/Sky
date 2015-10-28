<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
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

<sx:head parseContent="true" />

<title>Sky Movie Background Add Schedule</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<meta http-equiv="Page-Enter" content="revealTrans(duration=5, transition=23)">
<meta http-equiv="Page-Exit" content="revealTrans(duration=5, transition=23)">

<link rel="stylesheet" href="/Sky/styles/global.css" type="text/css" />

<script type="text/javascript" src="/Sky/scripts/jquery-1.7.2.js"></script>
<script type="text/javascript" src="/Sky/scripts/global.js"></script>

<script type="text/javascript">
	dojo.addOnLoad(setStyle);
	function setStyle() {
		document.getElementsByName("playDay")[0].childNodes(1).style.width = "100px";
	}

	function change() {
		var playDay = dojo.widget.byId("playDay");
		var playEndTime = document.getElementById("playEndTime");
		var playHour = document.getElementsByName("playHour")[0];
		var playMinute = document.getElementsByName("playMinute")[0];
		var movieLong = document.getElementById("movieLong");
		var playPrice = document.getElementsByName("playPrice")[0];

		if (movieLong.value == "" || movieLong.value.length == 0) {
			playEndTime.innerHTML = "&nbsp;<b style='color:red;'>Choose a Movie</b>";
		} else if (playDay.getValue() == "" || playDay.getValue().length == 0) {
			playEndTime.innerHTML = "&nbsp;<b style='color:red;'>Choose a Date</b>";
		} else if (playHour.value == "" || playHour.value.length == 0) {
			playEndTime.innerHTML = "&nbsp;<b style='color:red;'>Choose a Time</b>";
		} else if (playMinute.value == "" || playMinute.value.length == 0) {
			playEndTime.innerHTML = "&nbsp;<b style='color:red;'>Choose a Length</b>";
		} else if (playPrice.value == "" || playPrice.value.length == 0) {
			playEndTime.innerHTML = "&nbsp;<b style='color:red;'>Input the Price</b>";
		} else {
			var date = playDay.getValue().split("-");
			year = date[0];
			month = date[1];
			day = date[2].substr(0, 2);
			hour = playHour.value;
			minute = playMinute.value;
			var endTime = new Date();
			endTime.setTime(new Date(year, month - 1, day, hour, minute)
					.getTime()
					+ 1000 * 60 * movieLong.value);
			playEndTime.innerHTML = "&nbsp;--&nbsp;"
					+ endTime.toLocaleString().replace(/:\d{1,2}$/, '')
							.replace(':', '时') + "分";
		}

		if (playDay.getValue() == "" || playDay.getValue().length == 0
				|| movieLong.value == "" || movieLong.value.length == 0
				|| playHour.value == "" || playHour.value.length == 0
				|| playMinute.value == "" || playMinute.value.length == 0
				|| playPrice.value == "" || playPrice.value.length == 0) {
			document.getElementById("submit").disabled = true;
		} else {
			document.getElementById("submit").disabled = false;
		}
	}

	function movieIdChange(obj) {
		if (obj.value == "" || obj.value.length == 0) {
			var movieLong = document.getElementById("movieLong");
			movieLong.value = "";
			playEndTime.innerHTML = "&nbsp;<b style='color:red;'>Choose a Movie</b>";
		} else {
			//(1) : Createxmlhttp
			if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp = new XMLHttpRequest();
			} else {// code for IE6, IE5
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}

			//(2) : Assign Interaction Path
			xmlhttp.open("post", "movie!findMovieById.action?movieId="
					+ obj.value, true);
			//(3) : assign recall method
			xmlhttp.onreadystatechange = handler;
			//(4) : start interaction, send request
			xmlhttp.send();
		}
	}

	function handler() {
		var movieLong = document.getElementById("movieLong");

		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) { //if succeed, start process
			//acquire server response
			var res = eval('(' + xmlhttp.responseText + ')');

			movieLong.value = res;
		}

		change();
	}
</script>
</head>

<body>
	<div id="header">
		<s:include value="adminHead.jsp"></s:include>
	</div>
	<div id="main">
		<div id="main_left" style="float:left; width:180px; margin: 10px;">
			<s:include value="adminLeft.jsp"></s:include>
		</div>
		<div id="main_right" style="margin: 10px; float: left;">
			<fieldset style="line-height: 20px;">
				<legend>Add Schedule</legend>
				<s:form theme="simple" action="play" namespace="/">
					Choose a Movie:<s:select name="movieId" list="#application.lstMovie"
						listKey="movieId"
						listValue="movieName+' ('+edition.editionName+') ('+language.languageName+') ('+movieLong+'分钟)'"
						headerKey="" headerValue="--Choose a Movie--"
						onchange="movieIdChange(this)" />
					<s:hidden id="movieLong"/>
					<br /><br />
					<sx:datetimepicker name="playDay" id="playDay" label="Add Schedule"
						displayFormat="yyyy/MM/dd" toggleType="explode"
						toggleDuration="400" />
					<s:select list="(24).{#this}" name="playHour" headerKey=""
						headerValue="--" onchange="change()" />H<s:select
						list="(6).{#this+'0'}" name="playMinute" headerKey=""
						headerValue="--" onchange="change()" />M<span id="playEndTime"></span>
					<br /><br />
					Price: $<s:textfield name="playPrice" maxLength="3" style="width:30px;" onkeyup="change()"/>
					<br /><br />
					<s:submit value="Click to Save" id="submit" disabled="true" method="savePlay"/>
				</s:form>
			</fieldset>
		</div>
	</div>
	<div id="footer">
		<s:include value="adminFoot.jsp"></s:include>
	</div>
</body>
</html>
