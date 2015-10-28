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

<title>Sky Movie Register</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="Page-Enter" content="revealTrans(duration=5, transition=23)">
<meta http-equiv="Page-Exit" content="revealTrans(duration=5, transition=23)">

<link href="styles/global.css" type="text/css" rel="stylesheet" />
<link href="styles/register.css" type="text/css" rel="stylesheet" />
<link href="styles/head.css" type="text/css" rel="stylesheet" />
<link href="styles/foot.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="/Sky/scripts/jquery-1.7.2.js"></script>
<script type="text/javascript" src="/Sky/scripts/global.js"></script>

<script type="text/javascript">
	var emailFlag = false, pwdFlag = false, comPwdFlag = false,checkCodeFlag=false,look=false;
	
	function changeValidateCode(obj) {		
		var timenow = new Date().getTime();
		obj.src = "rand.action?d=" + timenow;
		
		checkCodeFlag=false;
		document.getElementsByName("checkCode")[0].value="";
		checkCodeMsg.innerHTML = "Please enter verification code";
		checkSubmit();
	}

	
	var xmlhttp;
	function emailblur(obj) {
		var emailMsg = document.getElementById("emailMsg");
		var emailReg = /^([a-zA-Z0-9]+[_|_|.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|_|.]?)*[a-zA-Z0-9]+.[a-zA-Z]{2,3}$/;
		if(obj.value.length == 0 || obj.value == ""){
			emailMsg.innerHTML = "please enter you email";
			emailFlag=false;
			checkSubmit();
		}
		else if(!emailReg.test(obj.value)){				
			emailMsg.innerHTML="Email invalid";
			emailFlag=false;
			checkSubmit();
		}else{
			//(1) : create xmlhttp
			if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp = new XMLHttpRequest();
			} else {// code for IE6, IE5
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}

			//(2) : assign interaction path
			var memberEmail = document.getElementsByName("memberEmail")[0].value;

			xmlhttp.open("post",
					"member!IsExistMemberEmail.action?memberEmail="
							+ memberEmail, true);
			//(3) : assign recall method
			xmlhttp.onreadystatechange = checkEmail;
			//(4) : start intercation, send request
			xmlhttp.send();
		}
	}

	function checkEmail() {
		var emailMsg = document.getElementById("emailMsg");
		
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) { //If succeed, start process
			//acquire server response
			var res = eval('(' + xmlhttp.responseText + ')');

			if (res) {
				emailMsg.innerHTML = "Sorry, this email has been used";
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

	function pwdkeyup(obj) {
		var pwdMsg = document.getElementById("pwdMsg");
		if (obj.value.length<6||obj.value.length>20) {
			pwdMsg.innerHTML = "Password must be 6 - 20 letters or numbers";
			pwdFlag = false;
		} else {
			pwdMsg.innerHTML = "Password valid";
			pwdFlag = true;
		}

		var comPwdMsg = document.getElementById("comPwdMsg");
		if (obj.value != document.getElementsByName("comPwd")[0].value) {
			comPwdMsg.innerHTML = "Password doesn't match, please reenter";
			comPwdFlag = false;
		} else {
			comPwdMsg.innerHTML = "Password matches";
			comPwdFlag = true;
		}
		checkSubmit();
	}

	function comPwdblur(obj) {
		var comPwdMsg = document.getElementById("comPwdMsg");
		if (obj.value.length == 0 || obj.value == "") {
			comPwdMsg.innerHTML = "Password must be 6 - 20 letters or numbers";
			comPwdFlag = false;
		} else if (obj.value != document.getElementsByName("memberPwd")[0].value) {
			comPwdMsg.innerHTML = "Password doesn't match, please reenter";
			comPwdFlag = false;
		} else {
			comPwdMsg.innerHTML = "Password matches";
			comPwdFlag = true;
		}
		checkSubmit();
	}

	function comPwdfocus(obj) {
		document.getElementById("submit").disabled = true;
	}
	
	function checkCodeblur(obj){
		if(obj.value.length != 0 || obj.value != "") {
			//(1) : create xmlhttp
			if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp = new XMLHttpRequest();
			} else {// code for IE6, IE5
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}

			//(2) : assign interaction path
			var checkCode = document.getElementsByName("checkCode")[0].value;

			xmlhttp.open("post",
					"member!checkCode.action?checkCode="
							+ checkCode, true);
			//(3) : assign recall method
			xmlhttp.onreadystatechange = checkCodeSubmit;
			//(4) : start interaction, send request
			xmlhttp.send();
		}else{
			var checkCodeMsg = document.getElementById("checkCodeMsg");
			checkCodeMsg.innerHTML = "Please enter verification code";
			pwdFlag=false;
			checkSubmit();
		}
	}
	
	function checkClickLook(obj){
		if(obj.checked){
			look=true;
		}else{
			look=false;
		}
		checkSubmit();
	}
	
	function checkCodeSubmit(){
		var checkCodeMsg = document.getElementById("checkCodeMsg");

		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) { //if succeed, start process
			//acquire server response
			var res = eval('(' + xmlhttp.responseText + ')');

			if (res) {
				checkCodeMsg.innerHTML = "Verification code correct";
				checkCodeFlag = true;
				checkSubmit();
			} else {
				checkCodeMsg.innerHTML = "Verification code incorrect";
				checkCodeFlag = false;
				checkSubmit();
			}
		} else {
			checkCodeMsg.innerHTML = "Loading...";
			checkCodeFlag = false;
			checkSubmit();
		}
	}

	function checkSubmit() {
		if (emailFlag && pwdFlag && comPwdFlag&&checkCodeFlag&&look) {
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
		<fieldset>
			<legend>Register</legend>
			<s:form action="member" method="post" namespace="/"
				style="margin-left:300px; width:600px; position: relative;">
				<s:textfield name="memberEmail" label="* Email" style="width:200px;"
					onblur="emailblur(this)" />
				<span id="emailMsg"
					style="position:absolute; top:20px; left:340px; color:red;">Please input your email</span>
				<s:radio list="#{true:'M',false:'F'}" listKey="key"
					listValue="value" value="true" name="memberGender" label="* Gender" />
				<s:password name="memberPwd" label="* Create password" style="width:200px;"
					onkeyup="pwdkeyup(this)" />
				<span id="pwdMsg"
					style="position:absolute; top:70px; left:340px; color:red;">Input password. Password must be 6 - 20 letters or numbers</span>
				<s:password name="comPwd" label="* Submit" style="width:200px;"
					onblur="comPwdblur(this)" onfocus="comPwdfocus(this)" />
				<span id="comPwdMsg"
					style="position:absolute; top:100px; left:340px; color:red;">Input password. Password must be 6 - 20 letters or numbers</span>
				<s:textfield name="checkCode" label="* Verification Code" style="width:120px;" onblur="checkCodeblur(this)"/>
				<img src="rand.action" onclick="changeValidateCode(this)"
					title="Not Clear?"
					style="border:1px #000000 solid; position: absolute; top:135px; left:270px;" />
					<span id="checkCodeMsg"
					style="position:absolute; top:120px; left:340px; color:red;"></span>
				<s:checkbox name="look" label="I agree" onclick="checkClickLook(this)" />
				<s:a style="position:absolute; top:170px; left:212px;">Conditions of Use and Privacy Notice</s:a>
				<s:submit value="Register" method="register" id="submit" disabled="true"></s:submit>
			</s:form>
		</fieldset>
	</div>
	<div id="footer">
		<s:include value="foot.jsp"></s:include>
	</div>

</body>
</html>
