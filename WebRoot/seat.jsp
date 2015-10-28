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

<title>Sky Movie Purchase Tickets</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="Page-Enter" content="revealTrans(duration=5, transition=23)">
<meta http-equiv="Page-Exit" content="revealTrans(duration=5, transition=23)">

<link href="styles/global.css" type="text/css" rel="stylesheet" />
<link href="styles/seat.css" type="text/css" rel="stylesheet" />
<link href="styles/head.css" type="text/css" rel="stylesheet" />
<link href="styles/foot.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="/Sky/scripts/jquery-1.7.2.js"></script>
<script type="text/javascript" src="/Sky/scripts/global.js"></script>

<script type="text/javascript">
	var seats = new Array(450);
	var chooseSeatsNum;

	function seatChangeClick(obj) {
		var img = obj.childNodes[0];

		if (img.src.substring(img.src.lastIndexOf("/") + 1) == "li.gif") {
			var j = 0;
			for ( var i in seats) {
				if (seats[i] == true) {
					j++;
					if (j == 4) {
						alert("You can only buy 4 tickets at a time.");
						return;
					}
				}
			}

			img.src = "images/selected.gif";
			seats[img.id - 1] = true;
		} else {
			img.src = "images/li.gif";
			seats[img.id - 1] = false;
		}

		var chooseSeats = document.getElementById("chooseSeats");
		var strChooseSeatsNum = "";
		chooseSeatsNum = new Array();
		var k = 0;

		for ( var i = 0; i < seats.length; i++) {
			if (seats[i] == true) {
				chooseSeatsNum[k] = parseInt(i) + 1;
				strChooseSeatsNum += chooseSeatsNum[k] + "&nbsp;";
				k++;
			}
		}
		chooseSeats.innerHTML = strChooseSeatsNum;

	}

	function nextButtonClick(obj) {
		if(chooseSeatsNum==null||chooseSeatsNum.length==0){
			alert("Please select a seat");
		}else{
			location = "play!showPay.action?chooseSeatsNum=" + chooseSeatsNum+ "&playId=" + document.getElementsByName("playId")[0].value;
		}
	}
</script>
</head>

<body>
	<div id="header">
		<s:include value="head.jsp"></s:include>
	</div>
	<div id="main">
		<div id="main_top">
			<a href="index.jsp" class="aToptxt">Sky Movie</a>
			&nbsp;&gt;&nbsp;
			<s:a action="play" method="showPlayTable">Purchase Tickets</s:a>
			&nbsp;&gt;&nbsp;
			<s:a action="play" method="showSeat">
				<s:param name="playId" value="#request.play.playId" />Select Seats</s:a>
		</div>

		<div id="main_bottom">
			<fieldset>
				<img src="images/choose_nav.png" style="margin-top:20px" />
				<fieldset style="margin:10px; padding:10px;">
					<s:property value="#request.play.movie.movieName" />
					(
					<s:property value="#request.play.movie.edition.editionName" />
					)&nbsp;&gt;&nbsp;
					<s:date name="#request.play.playTime" format="MM/dd HH:mm" />
					<br />
					<s:a action="play" method="showPlayTable" style="float:right;">Schedule</s:a>
				</fieldset>
				<div align="center">
					<img src="images/li.gif" />Available&nbsp; <img src="images/check.gif" />Unavailable&nbsp;
					<img src="images/selected.gif" />Your seats<br /><br /> <img
						src="images/screen.png" />
					<div style="clear:both; height: 40px;"></div>
					<s:iterator begin="1" end="450" status="s">
						<s:if test="(#s.index)%30==0">
							<div style="clear:both;"></div>
							<s:if test="(#s.index+1)/30+1==6">
								<div style="clear:both; height: 40px;"></div>
							</s:if>
							<div style="float:left;width: 30px;">
								<b><s:property value="(#s.index+1)/30+1" /> </b>
							</div>
						</s:if>

						<s:iterator var="ticket" value="#request.play.tickets">
							<s:if test="#ticket.ticketFlag&&#ticket.ticketSeat==#s.index+1">
								<s:set name="flag" value="true" />
							</s:if>
						</s:iterator>

						<s:if test="#flag">
							<div
								style="width:20px; height:30px; float:left; margin: 0px 5px 0px 5px; margin-bottom: 15px;">
								<img src="images/check.gif" />
								<s:property value="#s.index+1" />
								<s:set name="flag" value="false" />
							</div>
						</s:if>
						<s:else>
							<div
								style="width:20px; height:30px; float:left; margin: 0px 5px 0px 5px; margin-bottom: 15px; cursor: hand; "
								onclick="seatChangeClick(this)">
								<img src="images/li.gif" id="<s:property value="#s.index+1" />" />
								<s:property value="#s.index+1" />
							</div>
						</s:else>

					</s:iterator>
				</div>
				<hr style="clear:both; margin: 20px 0px;" />
				<b style="color:red; ">Your seats:</b><span id="chooseSeats"></span> <span
					style="float:right; margin-bottom:30px;"> <s:form
						action="play" theme="simple"
						style="float:left; margin-top:10px; margin-right:5px;">
						<s:submit method="showPlayTable" value=" Return to schedule " />
					</s:form> <input type="button" value=" Next Step "
					onclick="nextButtonClick(this)"
					style="float:left; width: 200px; height: 35px; font-weight:bold; font-size:large; margin-right:5px;" />
					<s:form action="play" theme="simple"
						style="float:left; margin-top:10px;">
						<s:hidden name="playId" value="%{#request.play.playId}" />
						<s:submit method="showSeat" value=" Reset " />
					</s:form> </span>
			</fieldset>

		</div>

	</div>
	<div id="footer">
		<s:include value="foot.jsp"></s:include>
	</div>

</body>
</html>
