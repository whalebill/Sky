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

<title>Sky Movie Background Add Member</title>

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
	var emailFlag = false, pwdFlag = false;
	var xmlhttp;
	function emailBlur(obj) {
		var emailMsg = document.getElementById("emailMsg");
		var emailReg = /^([a-zA-Z0-9]+[_|_|.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|_|.]?)*[a-zA-Z0-9]+.[a-zA-Z]{2,3}$/;
		
		if (obj.value.length == 0 || obj.value == "") {
			emailMsg.innerHTML = "Please enter your email as your username";
			emailFlag = false;
			checkSubmit();
		} else if (!emailReg.test(obj.value)) {
			emailMsg.innerHTML = "email is invalid!";
			emailFlag = false;
			checkSubmit();
		}  else {
			//(1) : create xmlhttp 
			if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp = new XMLHttpRequest();
			} else {// code for IE6, IE5
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}

			//(2) : assign interaction path
			xmlhttp
					.open("post",
							"member!IsExistMemberEmail.action?memberEmail="
									+ obj.value, true);
			//(3) : assign recall method
			xmlhttp.onreadystatechange = checkEmail;
			//(4) : start interaction, send request
			xmlhttp.send();
		}
	}

	function checkEmail() {
		var emailMsg = document.getElementById("emailMsg");

		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) { //if succeed, start process
			//acquire server response
			var res = eval('(' + xmlhttp.responseText + ')');

			if (res) {
				emailMsg.innerHTML = "Sorry, this email has been userd";
				emailFlag = false;
				checkSubmit();
			} else {
				emailMsg.innerHTML = "";
				emailFlag = true;
				checkSubmit();
			}
		} else {
			emailMsg.innerHTML = "Loading...";
			emailFlag = false;
			checkSubmit();
		}
	}

	function pwdBlur(obj) {
		var pwdMsg = document.getElementById("pwdMsg");
		if (obj.value.length == 0 || obj.value == "") {
			pwdMsg.innerHTML = "Please enter your password";
			pwdFlag = false;
			checkSubmit();
		}else if (obj.value.length<6||obj.value.length>20) {
			pwdMsg.innerHTML = "Password must be 8 - 20 letters or numbers";
			pwdFlag = false;
		} else {
			pwdMsg.innerHTML = "";
			pwdFlag = true;
		}
		checkSubmit();
	}

	function checkSubmit() {
		if (emailFlag && pwdFlag) {
			document.getElementById("submit").disabled = false;
		} else {
			document.getElementById("submit").disabled = true;
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
		<div id="main_right" style="margin: 10px; float: left;">
			<fieldset>
				<legend>Add Member</legend>
				<s:form action="member" namespace="/"
					style="position: relative;">
					<s:textfield name="memberEmail" label="Email" style="width:200px;"
						onblur="emailBlur(this)" />
					<span id="emailMsg"
						style="position:absolute; top:10px; left:310px; color:red; width:100%; background:none;"></span>
					<s:textfield name="memberName" label="Name" style="width:200px;" />
					<s:password name="memberPwd" label="Password" style="width:200px;"
						onblur="pwdBlur(this)" />
					<span id="pwdMsg"
						style="position:absolute; top:65px; left:310px; color:red; width:100%; background:none;"></span>
					<s:radio list="#{true:'M',false:'F' }" listKey="key"
						listValue="value" value="true" name="memberGender" label="Gender" />
					<s:textfield name="memberPhone" label="Tel" style="width:200px;" />
					<s:submit value="Click to Save" method="saveMember" id="submit" disabled="true"></s:submit>
				</s:form>

			</fieldset>
		</div>
	</div>
	<div id="footer">
		<s:include value="adminFoot.jsp"></s:include>
	</div>
</body>
</html>
