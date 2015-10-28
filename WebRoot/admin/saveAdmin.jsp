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

<title>Sky Movie Background Add Manager</title>

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

<script type="text/javascript">
	var nameFlag = false, pwdFlag = false, privilegeFlag = false;
	//Authorization verify
	function privilegeClick() {
		var privilegeMsg = document.getElementById("privilegeMsg");
		var objPrivilege = document.getElementsByName("adminPrivilege");
		for ( var i = 0; i < objPrivilege.length; i++) {
			if (objPrivilege[i].checked == true) {
				privilegeFlag = true;
			}
		}
		if (!privilegeFlag) {
			privilegeMsg.innerHTML = "Please Select Autorization Level！";
			privilegeFlag = false;
			checkSubmit();
		} else {
			privilegeMsg.innerHTML = "";
			privilegeFlag = true;
			checkSubmit();
		}
	}

	function nameBlur() {
		var objName = document.getElementsByName("adminName")[0];
		var nameMsg = document.getElementById("nameMsg");
		if (objName.value.length == 0 || objName.value == "") {
			nameMsg.innerHTML = "Sorry, please enter manager username！";
			nameFlag = false;
			checkSubmit();
		} else {
			//(1) : create xmlhttp 
			if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp = new XMLHttpRequest();
			} else {// code for IE6, IE5
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			//(2) : assign interaction path
			xmlhttp.open("post", "admin!IsExistAdminName.action?AdminName="
					+ objName.value, true);
			//(3) : assign recall method
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) { //if succeed, start process
					//acquire server response
					var res = eval('(' + xmlhttp.responseText + ')');
					if (res) {
						nameMsg.innerHTML = "Sorry, this manager account has been canceled!";
						nameFlag = false;
						checkSubmit();
					} else {
						nameMsg.innerHTML = "";
						nameFlag = true;
						checkSubmit();
					}
				} else {
					nameMsg.innerHTML = "Loading...";
				}
			};
			//(4) : start interaction, send request
			xmlhttp.send();
		}
	}

	function pwdBlur() {
		var objPwd = document.getElementsByName("adminPwd")[0];
		var pwdMsg = document.getElementById("pwdMsg");
		if (objPwd.value.length == 0 || objPwd.value == "") {
			pwdMsg.innerHTML = "Please enter you password";
			pwdFlag = false;
			checkSubmit();
		} else {
			pwdMsg.innerHTML = "";
			pwdFlag = true;
			checkSubmit();
		}
	}

	function checkSubmit() {
		if (nameFlag && pwdFlag && privilegeFlag) {
			document.getElementById("submit").disabled = false;
		} else {
			document.getElementById("submit").disabled = true;
		}
	}

	function resetClick() {
		var nameMsg = document.getElementById("nameMsg");
		nameMsg.innerHTML = "Sorry, please enter manager username！";
		var pwdMsg = document.getElementById("pwdMsg");
		pwdMsg.innerHTML = "Please enter your password";
		var privilegeMsg = document.getElementById("privilegeMsg");
		privilegeMsg.innerHTML = "Please select authorization level！";
		document.getElementById("submit").disabled = true;
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
				<legend>Add Manager</legend>
				<s:form action="admin" namespace="/" style="position: relative;">
					<s:textfield name="adminName" label="Manager Username" style="width:200px;"
						onblur="nameBlur()" />
					<span id="nameMsg"
						style="position:absolute; top:10px; left:310px; color:red; width:100%;"></span>
					<s:password name="adminPwd" label="Manager Password" style="width:200px;"
						onblur="pwdBlur()" />
					<span id="pwdMsg"
						style="position:absolute; top:35px; left:310px; color:red; width:100%;"></span>
					<s:checkboxlist
						list="#{1:'Movie Management',2:'Schedule Management',3:'User Management',4:'Ticket Management',5 : 'Ad Management',6:'Manager Management'}"
						listKey="key" listValue="value" name="adminPrivilege"
						label="Authorization Level" onclick="privilegeClick()" />
					<s:reset value="Reset" style="float:left;" onclick="resetClick();" />
					<s:submit value="Click to Save" method="saveAdmin" id="submit"
						disabled="true" />
				</s:form>
				<span id="privilegeMsg" style="color:red;"></span>
			</fieldset>
		</div>
	</div>
	<div id="footer">
		<s:include value="adminFoot.jsp"></s:include>
	</div>
</body>
</html>
