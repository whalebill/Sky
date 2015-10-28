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

<title>Sky Movie Account Center</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="Page-Enter" content="revealTrans(duration=5, transition=23)">
<meta http-equiv="Page-Exit" content="revealTrans(duration=5, transition=23)">

<link href="styles/global.css" type="text/css" rel="stylesheet" />
<link href="styles/memberCenter.css" type="text/css" rel="stylesheet" />
<link href="styles/head.css" type="text/css" rel="stylesheet" />
<link href="styles/left.css" type="text/css" rel="stylesheet" />
<link href="styles/right.css" type="text/css" rel="stylesheet" />
<link href="styles/foot.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="/Sky/scripts/jquery-1.7.2.js"></script>
<script type="text/javascript" src="/Sky/scripts/global.js"></script>

</head>

<body>
	<s:if test="#request.lstTickets==null">
		<script>
			location = "ticket!showTodayOrder.action";
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
		</div>
		<div id="main_left">
			<s:include value="left.jsp"></s:include>
		</div>

		<div id="main_center">
			<div id="main_center_top">
				<fieldset>
					<table width="560" border="0" align="left" cellpadding="5"
						cellspacing="0">
						<tr>
							<th width="140" scope="col">
								<fieldset style="padding-top:10px;">
									<s:a href="updateInfo.jsp">
										<s:if test="#session.curMember.memberPhoto==null">
											<img src="images/user_male.jpg" title="Edit Profile Picture" width="130px"
												style="margin-top:10px;" />
										</s:if>
										<s:else>
											<s:generator separator=","
												val="#session.curMember.memberPhoto">
												<s:iterator>
													<img src='<s:property />' title="Edit Profile Picture" border="0"
														width="130px" />
												</s:iterator>
											</s:generator>
										</s:else>
									</s:a>
								</fieldset></th>
							<th align="center" valign="middle" scope="col" style="font-size:20px;">Welcome，<s:if
									test="#session.curMember.memberName==null">
									<s:property value="#session.curMember.memberEmail" />
								</s:if> <s:else>
									<s:if test="#session.curMember.memberGender==1">Mr.</s:if>
									<s:else>Ms.</s:else>
									<s:property value="#session.curMember.memberName" />
								</s:else>
							</th>
						</tr>
					</table>
					<hr style="clear:both;" />
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td valign="top">Transaction Notice:</td>
							<td><s:if test="#request.lstTickets.size()==0">N/A</s:if> <s:else>
									<table border="0" cellpadding="5" cellspacing="0">

										<s:iterator var="ticket" value="#request.lstTickets" status="index">
											<tr>
												<td>（<s:property value="#index.index+1"/>）Order No.:<s:property value="#ticket.ticketCode" />
												</td>
												<td>Movie:<s:property value="#ticket.play.movie.movieName" />(<s:property
														value="#ticket.play.movie.edition.editionName" />) <br />Schedule:<s:date
														name="#ticket.play.playTime" format="MM/dd HH:mm" /><br />Seat<s:property
														value="#ticket.ticketSeat" /></td>
											</tr>
										</s:iterator>

									</table>
								</s:else></td>
						</tr>
					</table>
				</fieldset>
			</div>

			<div id="main_center_bottom">
				<fieldset style="padding: 10px;">
					<span>Recommended Movie</span>
					<s:a href="movies.jsp" style="float:right;">More Movie</s:a>
					<s:iterator var="movie" value="#request.afterMovieByPage.data">
						<hr />
						<table width="100%" border="0" cellspacing="0" cellpadding="5">
							<tr>
								<td rowspan="3"><s:a href="#">
										<s:generator separator="," val="#movie.moviePhoto">
											<s:iterator>
												<img src='<s:property />' border="0" width="160px" />
											</s:iterator>
										</s:generator>
									</s:a></td>
								<td><b><s:a>
											<s:property value="#movie.movieName" />
										</s:a> </b>Release Date:<s:date name="#movie.movieDate" format="yyyy/MM/dd" />
								</td>
							</tr>
							<tr>
								<td>Cast:<s:property value="#movie.movieActor" /></td>
							</tr>
							<tr>
								<td><s:property value="#movie.movieInfo" />
								</td>
							</tr>
							<tr>
								<td align="center"><s:a action="play"
										method="showOneMoviePlaies">
										<s:param name="movieName" value="#movie.movieName" />Purchase Tickets</s:a>
								</td>
								<td><s:a action="play" method="showOneMoviePlaies">
										<s:param name="movieName" value="#movie.movieName" />Info</s:a> | <s:a
										action="play" method="showOneMoviePlaies">
										<s:param name="movieName" value="#movie.movieName" />Schedule</s:a>
								</td>
							</tr>
						</table>
					</s:iterator>
				</fieldset>
			</div>

		</div>

		<div id="main_right">
			<s:include value="right.jsp"></s:include>
		</div>

	</div>
	<div id="footer">
		<s:include value="foot.jsp"></s:include>
	</div>

</body>
</html>
