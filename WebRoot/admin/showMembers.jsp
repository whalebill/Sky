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

<title>Sky Movie Background User Management</title>

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

<script type="text/javascript" charset="utf-8">
	function changePageSize(obj) {
		var pageSize = obj.value;
		var movieName = document.getElementsByName("memberName")[0].value;
		location = "./member!searchMembersByPage.action?pageSize=" + pageSize+"&searchWord=" + movieName;
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
		<div id="main_right" style="margin: 10px; float: left; width:1120px; overflow:auto;">
			<fieldset>
				<legend>User Management</legend>
				<h4>
					<s:a href="admin/saveMember.jsp">Add Member</s:a>
				</h4>
				<hr />
				<s:form action="member" method="post" namespace="/">
					<s:textfield name="memberName" value="%{#request.searchWord}"
						label="Username" />
					<s:textfield style="display:none;" />
					<s:submit value="Search" method="searchMembersByPage" />
				</s:form>
				<hr />
				<table width="100%" cellpadding="5px;" border="1">
					<tr>
						<th>Email</th>
						<th>Name</th>
						<th>Password</th>
						<th>Gender</th>
						<th>Tel</th>
						<th>Operation</th>
					</tr>
					<s:iterator var="member" value="#request.searchMembersByPage.data">
						<tr align="center">
							<td><s:property value="#member.memberEmail" />
							</td>
							<td><s:property value="#member.memberName" />
							</td>
							<td><s:property value="#member.memberPwd" />
							</td>
							<td><s:if test="#member.memberGender">M</s:if> <s:else>F</s:else>
							</td>
							<td><s:property value="#member.memberPhone" />
							</td>
							<td><s:a action="member" method="findMemberById">
									<s:param name="memberId" value="#member.memberId" />Update</s:a><br />
								<s:a action="member" method="removeMember"
									onclick="return confirm('Are you sure to delete this user？')">
									<s:param name="memberId" value="#member.memberId" />Delete</s:a>
							</td>
						</tr>
					</s:iterator>
				</table>

				Please choose：Page 
				<s:iterator var="i" begin="1"
					end="%{#request.searchMembersByPage.totalPages}">
					<s:if test="#request.searchMembersByPage.currentPage != #i ">
						<s:a action="member" method="searchMembersByPage" namespace="/"
							style="color:blue;">
							<s:param name="currentPage" value="#i" />
							<s:param name="pageSize"
								value="#request.searchMembersByPage.pageSize" />
							<s:param name="searchWord" value="#request.searchWord" />
							<s:property value="#i" />
						</s:a>
					</s:if>

					<s:if test="#request.searchMembersByPage.currentPage == #i">
						<strong style="color:red;"><s:property value="#i" /> </strong>
					</s:if>
				</s:iterator>
				
				
				<s:select list="(10).{#this+1}" name="pageSize" label="Users per Page"
					value="#request.searchMembersByPage.pageSize"
					onchange="changePageSize(this)" />
			</fieldset>
		</div>
	</div>
	<div id="footer">
		<s:include value="adminFoot.jsp"></s:include>
	</div>
</body>
</html>
