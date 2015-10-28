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

<title>Sky Movie Background Update Schedule</title>

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

		if (playDay.getValue() == "" || playDay.getValue().length == 0) {
			playEndTime.innerHTML = "&nbsp;<b style='color:red;'>Please choose date</b>";
		} else if (playHour.value == "" || playHour.value.length == 0) {
			playEndTime.innerHTML = "&nbsp;<b style='color:red;'>Please choose time</b>";
		} else if (playMinute.value == "" || playMinute.value.length == 0) {
			playEndTime.innerHTML = "&nbsp;<b style='color:red;'>Please choose minute</b>";
		} else if (playPrice.value == "" || playPrice.value.length == 0) {
			playEndTime.innerHTML = "&nbsp;<b style='color:red;'>Please input price</b>";
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
							.replace(':', 'h') + "m";
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
		<div id="main_right" style="margin: 10px; float: left; width:1120px; overflow:auto;">
			<fieldset style="line-height: 20px;">
				<legend>Update Schedule</legend>
				
				<fieldset>
					<legend>Movie Info</legend>
					<table cellpadding="5px;">
						<tr>
							<th width="100">Name：</th>
							<td><s:property value="#request.play.movie.movieName" />
							</td>
							<td align="right">
								<s:if test="#session.admin.adminPrivilege.index('1')!=-1">
									<s:a action="movie" method="showMovie">
									<s:param name="movieId" value="#request.play.movie.movieId" />Update Movie Info</s:a>
								</s:if>
							</td>
						</tr>
						<tr>
							<th>Director：</th>
							<td><s:property value="#request.play.movie.movieDirector" />
							</td>
							<td rowspan="8"><s:generator separator=","
									val="#request.play.movie.moviePhoto">
									<s:iterator>
										<img src='<s:property />' border="0" />
									</s:iterator>
								</s:generator></td>
						</tr>
						<tr>
							<th>Cast：</th>
							<td><s:property value="#request.play.movie.movieActor" />
							</td>
						</tr>
						<tr>
							<th>language：</th>
							<td><s:property
									value="#request.play.movie.language.languageName" />
							</td>
						</tr>
						<tr>
							<th>Genre：</th>
							<td><s:property value="#request.play.movie.kind.kindName" />
							</td>
						</tr>
						<tr>
							<th>Length：</th>
							<td><s:property value="#request.play.movie.movieLong" />分钟
							</td>
						</tr>
						<tr>
							<th>Version：</th>
							<td><s:property
									value="#request.play.movie.edition.editionName" />
							</td>
						</tr>
						<tr>
							<th>Release Date：</th>
							<td><s:date name="#request.play.movie.movieDate"
									format="yyyy年MM月dd日 E" />
							</td>
						</tr>
						<tr>
							<th style="vertical-align: top;">Info：</th>
							<td><s:property value="#request.play.movie.movieInfo" />
							</td>
						</tr>
					</table>
				</fieldset>
				<hr />
				<s:hidden id="movieLong" value="%{#request.play.movie.movieLong}" />
				<s:form theme="simple" action="play" namespace="/">
				<s:hidden name="playId" value="%{#request.play.playId}"/>
					<sx:datetimepicker name="playDay" id="playDay" label="Add Schedule"
						value="%{#request.play.playTime}" displayFormat="yyyy/MM/dd"
						toggleType="explode" toggleDuration="400" />

					Time: <s:select list="(24).{#this}" name="playHour" value="#request.hour"
						headerKey="" headerValue="--" onchange="change()" />:
				
						<s:select list="(6).{#this+'0'}" name="playMinute"
						value="#request.minute" headerKey="" headerValue="--"
						onchange="change()" />
						
						<span id="playEndTime"></span>
					<br />
					price: $<s:textfield name="playPrice" value="%{#request.play.playPrice}"
						maxLength="3" style="width:30px;" onkeyup="change()" />
					<br />
					<s:submit value="Click to Save" id="submit" disabled="true" method="modifyPlay" />
				</s:form>
			</fieldset>
		</div>
	</div>
	<div id="footer">
		<s:include value="adminFoot.jsp"></s:include>
	</div>
</body>
</html>