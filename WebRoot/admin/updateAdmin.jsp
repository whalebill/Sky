<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Sky Movie Background Update Manager</title>
    
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
		<div id="main_right" style="margin: 10px; float:left;">
			<fieldset>
				<legend>Update Manager</legend>
				<s:form action="admin" namespace="/">
					<s:hidden name="adminId" value="%{#request.admin.adminId}" />
					<s:textfield name="adminName" label="Manager Username" style="width:200px;"
						value="%{#request.admin.adminName}" />
					<s:password name="adminPwd" label="Manager Password" style="width:200px;"
						value="%{#request.admin.adminPwd}" />
					<s:checkboxlist list="#{1:'Movie Management',2:'Schedule Management',3:'User Management',4:'Ticket Management',5 : 'Ad Management',6:'Manager Management'}"
						listKey="key" listValue="value" name="adminPrivilege"
						label="Manager Authorization Level" value="%{#request.lstPrivilege}"></s:checkboxlist>
					<s:submit value="Click to Save" method="modifyAdmin"></s:submit>
				</s:form>
			</fieldset>
		</div>
	</div>
	<div id="footer">
		<s:include value="adminFoot.jsp"></s:include>
	</div>
  </body>
</html>
