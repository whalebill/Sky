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

<title>Sky Movie Edit Profile</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="Page-Enter" content="revealTrans(duration=5, transition=23)">
<meta http-equiv="Page-Exit" content="revealTrans(duration=5, transition=23)">

<link href="styles/global.css" type="text/css" rel="stylesheet" />
<link href="styles/updateInfo.css" type="text/css" rel="stylesheet" />
<link href="styles/head.css" type="text/css" rel="stylesheet" />
<link href="styles/left.css" type="text/css" rel="stylesheet" />
<link href="styles/foot.css" type="text/css" rel="stylesheet" />
<script src="SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
<link href="SpryAssets/SpryTabbedPanels.css" rel="stylesheet"
	type="text/css" />

<script type="text/javascript" src="/Sky/scripts/jquery-1.7.2.js"></script>
<script type="text/javascript" src="/Sky/scripts/global.js"></script>

</head>

<body>
	<div id="header">
		<s:include value="head.jsp"></s:include>
	</div>
	<div id="main">
		<div id="main_top">
			<a href="index.jsp" class="aToptxt">Sky Movie</a>&nbsp;&gt;&nbsp;<a
				href="memberCenter.jsp" class="aToptxt">Account Center</a>&nbsp;&gt;&nbsp;<a
				class="aToptxt" href="updateInfo.jsp">Edit Profile</a>
		</div>

		<div id="main_left">
			<s:include value="left.jsp"></s:include>
		</div>

		<div id="main_right">

			<div id="main_right_middle">
				<div id="TabbedPanels1" class="TabbedPanels">
					<ul class="TabbedPanelsTabGroup">
						<li class="TabbedPanelsTab" tabindex="0">Basic Info</li>
						<li class="TabbedPanelsTab" tabindex="0">Edit Profile Picture</li>
					</ul>
					<div class="TabbedPanelsContentGroup">
						<div class="TabbedPanelsContent">
							<table width="780" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="150">
										<fieldset style="padding-top:10px;">
											<s:if test="#session.curMember.memberPhoto==null">
												<img src="images/user_male.jpg" width="130" />
											</s:if>
											<s:else>
												<s:generator separator=","
													val="#session.curMember.memberPhoto">
													<s:iterator>
														<img src='<s:property />' border="0" width="160px" />
													</s:iterator>
												</s:generator>
											</s:else>
										</fieldset></td>
									<td><s:form action="member" method="post" namespace="/"
											style="margin-left:100px;">
                        		&gt;Email:&nbsp;<s:property
												value="#session.curMember.memberEmail" />
											<s:textfield name="memberName"
												value="%{#session.curMember.memberName}" label=">Name" />
											<s:radio list="#{true:'M',false:'F' }" listKey="key"
												listValue="value" name="memberGender"
												value="#session.curMember.memberGender" label=">Gender" />
											<s:textfield name="memberPhone"
												value="%{#session.curMember.memberPhone}" label=">Tel" />
											<s:submit method="modifyMemberInfo" value="Click to Save"></s:submit>
										</s:form></td>
								</tr>
							</table>

						</div>
						<div class="TabbedPanelsContent">
							<table border="0" cellspacing="0" cellpadding="0" width="780">
								<tr>
									<td width="150">
										<fieldset style="padding-top:10px;">
											<s:if test="#session.curMember.memberPhoto==null">
												<img src="images/user_male.jpg" width="130" />
											</s:if>
											<s:else>
												<s:generator separator=","
													val="#session.curMember.memberPhoto">
													<s:iterator>
														<img src='<s:property />' border="0" width="160px" />
													</s:iterator>
												</s:generator>
											</s:else>
										</fieldset></td>
									<td><s:form action="member" enctype="multipart/form-data"
											method="post" namespace="/" style="margin-left:50px;">
											<s:file name="upload" label="Upload Profile Picture" />
											<s:submit value="上传" method="modifyMemberPhoto" />
										</s:form>
										<div style="margin-left:50px;">
											Please upload new photo<br /> .jpg/.jpeg/.png only
										</div></td>
								</tr>
							</table>

						</div>
					</div>
				</div>
			</div>

		</div>

	</div>
	<div id="footer">
		<s:include value="foot.jsp"></s:include>
	</div>

	<script type="text/javascript">
	<!--
		var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1");
	//-->
	</script>
</body>
</html>
