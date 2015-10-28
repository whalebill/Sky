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

<title>Sky Movie Background Ticket Management</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<meta http-equiv="Page-Enter"
	content="revealTrans(duration=5, transition=23)">
<meta http-equiv="Page-Exit"
	content="revealTrans(duration=5, transition=23)">

<link rel="stylesheet" href="/Sky/styles/global.css" type="text/css" />

<script type="text/javascript" src="/Sky/scripts/jquery-1.7.2.js"></script>
<script type="text/javascript" src="/Sky/scripts/global.js"></script>

</head>

<body>
	<div id="header">
		<s:include value="adminHead.jsp"></s:include>
	</div>
	<div id="main">
		<div id="main_left" style="float:left; width:180px; margin: 10px;">
			<s:include value="adminLeft.jsp"></s:include>
		</div>
		<div id="main_right"
			style="margin: 10px; float: left; width:1120px; overflow:auto;">
			<fieldset>
				<legend>Ticket Management</legend>
				<s:form action="ticket" method="post" namespace="/">
					<s:textfield name="ticketCode" label="Order Number" style="width:400px;" />
					<s:textfield style="display:none;" />
					<s:submit value="Search" method="searchTickets" />
				</s:form>
				<hr />
				<s:if test="#request.baseInfo!=null">
					<table width="100%" cellpadding="5px;" border="1">
						<tr>						
							<th>Order Time</th>
							<td><s:date name="#request.baseInfo.ticketDate"
									format="yyyy/MM/dd HH:mm" />
							</td>
							<th>Price</th>
							<td>$<s:property value="#request.baseInfo.ticketPrice" />
							</td>
						</tr>
						<tr>
							<th>Username</th>
							<td><s:property
									value="#request.baseInfo.member.memberName" /></td>
							<th>Email</th>
							<td><s:property
									value="#request.baseInfo.member.memberEmail" /></td>
						</tr>
						<tr>
							<th>Movie</th>
							<td><s:property
									value="#request.baseInfo.play.movie.movieName" />（<s:property
									value="#request.baseInfo.play.movie.edition.editionName" />）<s:property
									value="#request.baseInfo.play.movie.language.languageName" />
							</td>
							<th>Schedule</th>
							<td><s:date name="#request.baseInfo.play.playTime"
									format="yyyy/MM/dd HH:mm" /></td>
						</tr>
					</table>
					<table width="100%" cellpadding="5px;" border="1">
					<tr>
						<th>Order has been placed</th>
						<th>Order has been canceled</th>
					</tr>
					<tr align="center">
						<s:if test="#request.lstTickets!=null">
							<td><s:iterator var="ticket" value="#request.lstTickets">
									NO.<s:property value="#ticket.ticketSeat" />
							</s:iterator></td>
						</s:if>
						<s:else>
							<td>N/A</td>
						</s:else>
						<s:if test="#request.lstReturnTickets!=null">
							<td><s:iterator var="ticket"
									value="#request.lstReturnTickets">
									NO.<s:property value="#ticket.ticketSeat" />
							</s:iterator></td>
						</s:if>
						<s:else>
							<td>N/A</td>
						</s:else>
					</tr>
				</table>
				</s:if>
				<s:else>
					<table width="100%" cellpadding="5px;" border="1">
						<tr>
							<th>No Info</th>
						</tr>
					</table>
				</s:else>
			</fieldset>
		</div>
	</div>
	<div id="footer">
		<s:include value="adminFoot.jsp"></s:include>
	</div>
</body>
</html>

