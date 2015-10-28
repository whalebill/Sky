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

<title>Sky Movie Movie</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="Page-Enter" content="revealTrans(duration=5, transition=23)">
<meta http-equiv="Page-Exit" content="revealTrans(duration=5, transition=23)">

<link href="styles/global.css" type="text/css" rel="stylesheet" />
<link href="styles/oneMovie.css" type="text/css" rel="stylesheet" />
<link href="styles/head.css" type="text/css" rel="stylesheet" />
<link href="styles/right.css" type="text/css" rel="stylesheet" />
<link href="styles/foot.css" type="text/css" rel="stylesheet" />
<script src="SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
<link href="SpryAssets/SpryTabbedPanels.css" rel="stylesheet"
	type="text/css" />
	
<script type="text/javascript" src="/Sky/scripts/jquery-1.7.2.js"></script>
<script type="text/javascript" src="/Sky/scripts/global.js"></script>

<script type="text/javascript">
	var movieDate = 1, movieTime = "", movieEdition = "";

	function changeCSS(obj) {
		for ( var i = 0; i < obj.parentNode.getElementsByTagName("a").length; i++) {
			obj.parentNode.getElementsByTagName("a")[i].style
					.removeAttribute("backgroundColor");
			obj.parentNode.getElementsByTagName("a")[i].style.color="#3399FF";
		}

		obj.style.backgroundColor = "#3399FF";
		obj.style.color = "white";
	}

	function setDayClick(flag, obj) {
		changeCSS(obj);

		movieDate = flag;
		showOneMoviePlaies();
	}

	function setTimeClick(flag, obj) {
		changeCSS(obj);

		movieTime = flag;
		showOneMoviePlaies();
	}

	function setEditionClick(flag, obj) {
		changeCSS(obj);

		movieEdition = flag;
		showOneMoviePlaies();
	}

	function showOneMoviePlaies() {
	
		//(1) : create xmlhttp
		if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}

		//(2) : assign interaction path
		var movieName=null;
		for(var i=0;i<document.all["movieName"].length;i++){
			if(document.all["movieName"][i].id == "movieName"){
				movieName=document.all["movieName"][i].value;				
			}
		}
		
		xmlhttp.open("post",
				"play!showOneMovieByConditionByJson.action?movieName="
						+ encodeURI(movieName) + "&movieTime=" + movieTime
						+ "&movieEdition=" + movieEdition + "&movieDate="
						+ movieDate, true);

		//(3) : assign recall method
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var json_data = eval('(' + xmlhttp.responseText + ')'); // acquire Json data

				//acquire layer
				var show_json = document.getElementById("json");

				if (show_json.firstChild != null) {
					show_json.removeChild(show_json.firstChild);
				}

				//create table
				var table = document.createElement("table");
				table.border = 1;
				table.cellSpacing = 0;
				table.cellPadding = 5;
				table.width = "100%";

				var tr = table.insertRow(0);

				var th1 = tr.document.createElement("th");
				var playTime = document.createTextNode("Schedule");
				th1.appendChild(playTime);
				tr.appendChild(th1);

				var th2 = tr.document.createElement("th");
				var ticketNum = document.createTextNode("Availabel Seats");
				th2.appendChild(ticketNum);
				tr.appendChild(th2);

				var th3 = tr.document.createElement("th");
				var language = document.createTextNode("Language");
				th3.appendChild(language);
				tr.appendChild(th3);

				var th4 = tr.document.createElement("th");
				var edition = document.createTextNode("Version");
				th4.appendChild(edition);
				tr.appendChild(th4);

				var th5 = tr.document.createElement("th");
				var playPrice = document.createTextNode("Price");
				th5.appendChild(playPrice);
				tr.appendChild(th5);

				var th6 = tr.document.createElement("th");
				var word = document.createTextNode("Purchase Tickets");
				th6.appendChild(word);
				tr.appendChild(th6);
				
				if(json_data == null || json_data.length == 0) {
					var tr = table.insertRow(1);
					var td=tr.insertCell(0);
					td.colSpan=6;
					tr.align="center";
					
					var msg=document.createTextNode("Coming Soon!");
					td.appendChild(msg);
					tr.appendChild(td);
				}
				
				if (json_data != null && json_data.length > 0) { // ensure data is valid

					for ( var i = 0; i < json_data[0].lstPlaies.length; i++) {
						var tr = table.insertRow(i + 1);
						tr.align="center";
						
						var td1 = tr.insertCell(0);
						var playTime = document
								.createTextNode(json_data[0].lstPlaies[i].playTime);
						td1.appendChild(playTime);
						tr.appendChild(td1);

						var td2 = tr.insertCell(1);
						var ticketNum = document.createTextNode("Remaining"
								+ (450 - json_data[0].lstPlaies[i].ticketNum));
						td2.appendChild(ticketNum);
						tr.appendChild(td2);

						var td3 = tr.insertCell(2);
						var language = document
								.createTextNode(json_data[0].lstPlaies[i].language);
						td3.appendChild(language);
						tr.appendChild(td3);

						var td4 = tr.insertCell(3);
						var edition = document
								.createTextNode(json_data[0].lstPlaies[i].edition);
						td4.appendChild(edition);
						tr.appendChild(td4);

						var td5 = tr.insertCell(4);
						var playPrice = document
								.createTextNode(json_data[0].lstPlaies[i].playPrice+"元");
						td5.appendChild(playPrice);
						tr.appendChild(td5);

						var td6 = tr.insertCell(5);
						var a = tr.document.createElement("a");
						a.href="play!showSeat.action?playId="+json_data[0].lstPlaies[i].playId;
						var word = document.createTextNode("Purchase Tickets");
						a.appendChild(word);
						td6.appendChild(a);
						tr.appendChild(td6);

					}				
				}
				show_json.appendChild(table);
			}
		};
		//(4) : Start interaction, send request
		xmlhttp.send();
	}
</script>
</head>

<body>
	<%
		Calendar cd = Calendar.getInstance();
		int todayMonth = cd.get(Calendar.MONTH) + 1;
		int today = cd.get(Calendar.DATE);
		cd.add(Calendar.DATE, 1);
		int tomorrowMonth = cd.get(Calendar.MONTH) + 1;
		int tomorrow = cd.get(Calendar.DATE);
	%>
	<div id="header">
		<s:include value="head.jsp"></s:include>
	</div>
	<div id="main">
		<div id="main_top">
			<a href="index.jsp" class="aToptxt">Home</a>
			&nbsp;&gt;&nbsp;
			<a href="movies.jsp" class="aToptxt">Movie</a>
			&nbsp;&gt;&nbsp;
			<s:a action="play" method="showOneMoviePlaies">
				<s:param name="movieName" value="#request.movie.movieName" />
				<s:property value="#request.movie.movieName" />
			</s:a>
		</div>
		<div id="main_left">
			<div id="main_left_top">
				<fieldset>
					<s:hidden id="movieName" value="%{#request.movie.movieName}" />
					<table border="0" cellspacing="0" cellpadding="5" width="100%" style="font-size: 14px;">
						<tr>
							<th colspan="2"  scope="col" style="font-size: 25px;color:blue;">Movie Info</th>
						</tr>
						<tr>
							<td rowspan="7" align="center"><s:generator separator=","
									val="#request.movie.moviePhoto">
									<s:iterator>
										<img src='<s:property />' border="0" />
									</s:iterator>
								</s:generator>
							</td>
							<td align="left"><b style="font-size: 20px; color: #3399FF"><s:property
										value="#request.movie.movieName" /> </b>
							</td>
						</tr>
						<tr>
							<td align="left"><b>Director:</b> <s:property
									value="#request.movie.movieDirector" />
							</td>
						</tr>
						<tr>
							<td align="left"><b>Cast:</b> <s:property
									value="#request.movie.movieActor" />
							</td>
						</tr>
						<tr>
							<td align="left"><b>Genre:</b> <s:property
									value="#request.movie.kind.kindName" />
							</td>
						</tr>
						<tr>
							<td align="left"><b>Length:</b> <s:property
									value="#request.movie.movieLong" />min</td>
						</tr>
						<tr>
							<td align="left"><b>Release Date:</b> <s:date
									name="#request.movie.movieDate" format="yyyy/MM/dd" /></td>
						</tr>
						<tr>
							<td align="left"><b>Info:</b> <s:property
									value="#request.movie.movieInfo" />
							</td>
						</tr>
					</table>
				</fieldset>
			</div>

			<div id="main_left_middle">
				<fieldset>
					<table border="0" cellspacing="0" cellpadding="5" width="100%">
						<tr>
							<th colspan="2" scope="col" style="font-size: 25px;color: #3399FF;">Schedule</th>
						</tr>
						<tr>
							<th scope="row" width="50">Date:</th>
							<td><a onclick="setDayClick('1',this)"
								style="cursor: hand; background-color:#3399FF; color:white;">Today（<%=todayMonth%>.<%=today%>）</a>&nbsp;<a
								onclick="setDayClick('2',this)"
								style="cursor: hand; color:#3399FF;">Tomorrow（<%=tomorrowMonth%>.<%=tomorrow%>）</a>
							</td>
						</tr>
						<tr>
							<th scope="row">Time:</th>
							<td><a onclick="setTimeClick('',this)"
								style="cursor: hand; background-color:#3399FF; color:white;">[All]</a>&nbsp;<a
								onclick="setTimeClick('am',this)"
								style="cursor: hand; color:#3399FF;">Morning</a>&nbsp;<a
								onclick="setTimeClick('pm',this)"
								style="cursor: hand; color:#3399FF;">Afternoon</a>&nbsp;<a
								onclick="setTimeClick('night',this)"
								style="cursor: hand; color:#3399FF;">Evening</a>
							</td>
						</tr>
						<tr>
							<th scope="row">Version:</th>
							<td><a onclick="setEditionClick('',this)"
								style="cursor: hand; background-color:#3399FF; color:white;">[All]</a> <s:iterator
									var="edition" value="#application.lstEdition">
									<a
										onclick="setEditionClick('<s:property value="#edition.editionId" />',this)"
										style="cursor: hand; color:#3399FF;"> <s:property
											value="#edition.editionName" /> </a>&nbsp;
										</s:iterator>
							</td>
						</tr>
					</table>
					<div id="json">
						<table border="1" cellspacing="0" cellpadding="5" width="100%">
							<tr>
								<th scope="col">Schedule</th>
								<th scope="col">Available Seats</th>
								<th scope="col">Language</th>
								<th scope="col">Version</th>
								<th scope="col">Price</th>
								<th scope="col">Purchase Tickets</th>
							</tr>
							<s:if test="#request.lstMapOneMovieTime.size()==0">
								<tr>
									<td colspan="6" align="center">Coming soon!</td>
								</tr>
							</s:if>
							<s:iterator var="play"
								value="#request.lstMapOneMovieTime[0]['lstPlaies']">
								<tr>
									<td align="center"><s:date name="#play.playTime"
											format="HH:mm" /></td>
									<td align="center">Remaining<s:property
											value="450-#play.tickets.size()" />
									</td>
									<td align="center"><s:property
											value="#play.movie.language.languageName" /></td>
									<td align="center"><s:property
											value="#play.movie.edition.editionName" /></td>
									<td align="center">$<s:property value="#play.playPrice" /></td>
									<td align="center"><s:a action="play" method="showSeat">
											<s:param name="playId" value="#play.playId" />Purchase Tickets</s:a>
									</td>
								</tr>
							</s:iterator>
						</table>
					</div>
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
