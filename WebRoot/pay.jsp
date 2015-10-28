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

<title>Sky Movie Pay</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="Page-Enter" content="revealTrans(duration=5, transition=23)">
<meta http-equiv="Page-Exit" content="revealTrans(duration=5, transition=23)">

<link href="styles/global.css" type="text/css" rel="stylesheet" />
<link href="styles/pay.css" type="text/css" rel="stylesheet" />
<link href="styles/head.css" type="text/css" rel="stylesheet" />
<link href="styles/foot.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="/Sky/scripts/jquery-1.7.2.js"></script>
<script type="text/javascript" src="/Sky/scripts/global.js"></script>

</head>

<body>
	<div id="header">
		<s:include value="head.jsp"></s:include>
	</div>
	<div id="main">
		<div id="main_top">
			<a href="index.jsp" class="aToptxt">Sky Movie</a>&nbsp;&gt;&nbsp;<a href="time.jsp" class="aToptxt">Purchase Tickets</a>&nbsp;&gt;&nbsp;<a>Order has been placed!</a>
		</div>

		<div id="main_bottom">
			<fieldset>
				<img src="images/v2_pay_nav.png" style="margin-top:20px" />
				<div id="main_bottom_left">
					<ul>
						<li>Your Movie:</li>
						<li><b><s:property
									value="#request.play.movie.movieName" />(<s:property
									value="#request.play.movie.edition.editionName" />)</b>
						</li>
						<li>Schedule:<s:date name="#request.play.playTime"
								format="yyyy-MM-dd HH:mm" />
						</li>
						<li>Quantity: <s:property value="#request.chooseSeatsNum.length" /></li>
						<li>
							<table cellpadding="0" cellspacing="0">
								<tr>
									<td valign="top">Seat NO.:</td>
									<td><ul style="display: inline;">
											<s:iterator var="seat" value="#request.chooseSeatsNum"
												status="s">
												<li><s:property value="#seat" /></li>
											</s:iterator>
										</ul>
									</td>
								</tr>
							</table></li>
						<li>Price: $<s:property value="#request.ticketPrice" /></li>
					</ul>
					<br />Total:$
					<s:property
						value="#request.ticketPrice*#request.chooseSeatsNum.length" />
				</div>
				<div id="main_bottom_right">
					<fieldset style="padding:20px;">
						<legend>Payment Methods:</legend>
						<div style="line-height:20px;">We accept:</div>
						
							<img src="images/pay.png" />
					</fieldset>
					<s:form action="ticket" style="margin:30px; float:right;"
						namespace="/">
						<s:hidden name="playId" value="%{#request.play.playId}" />
						<s:hidden name="ticketPrice" value="%{#request.ticketPrice}" />
						<s:iterator var="seat" value="#request.chooseSeatsNum">
							<s:hidden name="chooseSeatsNum" value="%{#seat}" />
						</s:iterator>
						<s:submit value="Place Order" method="addTickets" />
					</s:form>
				</div>
			</fieldset>

		</div>

	</div>
	<div id="footer">
		<s:include value="foot.jsp"></s:include>
	</div>

</body>
</html>
