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

<title>Sky Movie Edit Password</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="Page-Enter" content="revealTrans(duration=5, transition=23)">
<meta http-equiv="Page-Exit" content="revealTrans(duration=5, transition=23)">

<link href="styles/global.css" type="text/css" rel="stylesheet" />
<link href="styles/updatePwd.css" type="text/css" rel="stylesheet" />
<link href="styles/head.css" type="text/css" rel="stylesheet" />
<link href="styles/left.css" type="text/css" rel="stylesheet" />
<link href="styles/foot.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="/Sky/scripts/jquery-1.7.2.js"></script>
<script type="text/javascript" src="/Sky/scripts/global.js"></script>

<script type="text/javascript">
	var oldPwdflag = false, newPwdflag = false, comPwdflag = false;
	function oldPwdblur(obj) {
		if (obj.value.length != 0 || obj.value != "") {
			//(1) : create xmlhttp
			if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp = new XMLHttpRequest();
			} else {// code for IE6, IE5
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}

			//(2) : assign interaction path			
			xmlhttp.open("post", "member!checkOldMemberPwd.action?memberPwd="
					+ obj.value, true);
			//(3) : assign recall method
			xmlhttp.onreadystatechange = checkOldPwd;
			//(4) : start interaction, send request
			xmlhttp.send();
		} else {
			oldPwdflag = false;
			checkSubmit();
		}

	}

	function newPwdkeyup(obj) {
		var newPwdMsg = document.getElementById("newPwdMsg");
		if (obj.value.length<6||obj.value.length>20) {
			newPwdMsg.innerHTML = "Password must be 6 - 20 letters or numbers";
			newPwdflag = false;
		} else {
			newPwdMsg.innerHTML = "Password valid";
			newPwdflag = true;
		}

		var comPwdMsg = document.getElementById("comPwdMsg");
		if (obj.value != document.getElementsByName("comPwd")[0].value) {
			comPwdMsg.innerHTML = "Password doesn't match, please reenter";
			comPwdflag = false;
		} else {
			comPwdMsg.innerHTML = "Password matches";
			comPwdflag = true;
		}
		checkSubmit();
	}

	function comPwdblur(obj) {
		var comPwdMsg = document.getElementById("comPwdMsg");
		if (obj.value.length == 0 || obj.value == "") {
			comPwdMsg.innerHTML = "Password must be 6 - 20 letters or numbers";
			comPwdflag = false;
		} else if (obj.value != document.getElementsByName("memberPwd")[0].value) {
			comPwdMsg.innerHTML = "Password doesn't match, please reenter";
			comPwdflag = false;
		} else {
			comPwdMsg.innerHTML = "Password matches";
			comPwdflag = true;
		}
		checkSubmit();
	}

	function comPwdfocus(obj) {
		document.getElementById("submit").disabled = true;
	}

	function checkOldPwd() {
		var oldPwdMsg = document.getElementById("oldPwdMsg");

		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) { //if succeed, start process
			//acquire server response
			var res = eval('(' + xmlhttp.responseText + ')');

			if (!res) {
				oldPwdMsg.innerHTML = "Password doesn't match, please reenter";
				oldPwdflag = false;
				checkSubmit();
			} else {
				oldPwdMsg.innerHTML = "";
				oldPwdflag = true;
				checkSubmit();
			}
		} else {
			oldPwdMsg.innerHTML = "Loading...";
			oldPwdflag = false;
			checkSubmit();
		}
	}

	function checkSubmit() {
		if (oldPwdflag && newPwdflag && comPwdflag) {
			document.getElementById("submit").disabled = false;
		} else {
			document.getElementById("submit").disabled = true;
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
			<a href="memberCenter.jsp" class="aToptxt">Account center</a>
			&nbsp;&gt;&nbsp;
			<a href="updatePwd.jsp" class="aToptxt">Edit Password</a>
		</div>
		<div id="main_left">
			<s:include value="left.jsp"></s:include>
		</div>

		<div id="main_center">
			<fieldset style="padding: 10px;">
				<div>Edit Password</div>
				<s:form action="member"
					style="width:600px; margin:auto; position: relative;">
					<s:password name="oldPwd" label="> Input Original Password" onblur="oldPwdblur(this)" />
					<span id="oldPwdMsg"
						style="position:absolute; top:15px; left:400px; color:red;">Please input original password</span>
					<s:password name="memberPwd" label="> Input New Password"
						onkeyup="newPwdkeyup(this)" />
					<span id="newPwdMsg"
						style="position:absolute; top:45px; left:400px; color:red;">Password must be 6 - 20 letters or numbers</span>
					<s:password name="comPwd" label="> Input New Password again" onblur="comPwdblur(this)"
						onfocus="comPwdfocus(this)" />
					<span id="comPwdMsg"
						style="position:absolute; top:80px; left:400px; color:red;">Password must be 6 - 20 letters or numbers</span>
					<s:submit id="submit" value="Click to Save" method="modifyMemberPwd"
						disabled="true"></s:submit>
				</s:form>
			</fieldset>

		</div>

	</div>
	<div id="footer">
		<s:include value="foot.jsp"></s:include>
	</div>

</body>
</html>
