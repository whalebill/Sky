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

<title>Sky Movie Background Update User</title>

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

</head>

<body>
	<div id="header">
		<s:include value="adminHead.jsp"></s:include>
	</div>
	<div id="main">
		<div id="main_left" style="float:left; width:180px; margin: 10px;">
			<s:include value="adminLeft.jsp"></s:include>
		</div>
		<div id="main_right" style="margin: 10px; ">
			<fieldset>
				<legend>Update User</legend>
				<s:form action="member" namespace="/">
					<s:hidden name="memberId" value="%{#request.member.memberId}" />
					<s:textfield name="memberEmail" label="Email" style="width:200px;"
						value="%{#request.member.memberEmail}" />
					<s:textfield name="memberName" label="Name" style="width:200px;"
						value="%{#request.member.memberName}" />
					<s:textfield name="memberPwd" label="Password" style="width:200px;"
						value="%{#request.member.memberPwd}" />
					<s:radio list="#{true:'M',false:'F' }" listKey="key"
						listValue="value" name="memberGender" label="Gender"
						value="%{#request.member.memberGender}" />
					<s:textfield name="memberPhone" label="电话" style="width:200px;"
						value="%{#request.member.memberPhone}" />
					<s:submit value="Click to Save" method="modifyMember"></s:submit>
				</s:form>
			</fieldset>
		</div>
	</div>
	<div id="footer">
		<s:include value="adminFoot.jsp"></s:include>
	</div>
</body>
</html>
