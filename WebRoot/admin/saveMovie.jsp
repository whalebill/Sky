<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
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
<sx:head parseContent="true" />

<title>Sky Movie Background Add Movie</title>

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
	$(document).ready(function() {
		$("#showAddKind").click(function() {
			$("#addKind").hide(2000);
			$("#addKind").show(2000, kindCallback);
		});
		$("#hideAddKind").click(function() {
			$("#addKind").hide(2000);
		});

		$("#showAddLanguage").click(function() {
			$("#addLanguage").hide(2000);
			$("#addLanguage").show(2000, languageCallback);
		});
		$("#hideAddLanguage").click(function() {
			$("#addLanguage").hide(2000);
		});
		
		$("#showAddEdition").click(function() {
			$("#addEdition").hide(2000);
			$("#addEdition").show(2000, editionCallback);
		});
		$("#hideAddEdition").click(function() {
			$("#addEdition").hide(2000);
		});
	});

	function kindCallback() {
		$("#addKind [name='kindName']").focus();
	}

	function languageCallback() {
		$("#addLanguage [name='languageName']").focus();
	}
	
	function editionCallback() {
		$("#addEdition [name='editionName']").focus();
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
		<div id="main_right" style="float: left; ">

			<fieldset id="addLanguage"
				style="margin: 10px; display: none; width: 270px; float: left;">
				<legend>Add New Movie Language</legend>
				<s:form action="language" namespace="/">
					<s:textfield name="languageName" label="New Movie Language" />
					<s:textfield style="display:none;" />
					<s:submit value="Add New Movie Language" method="saveLanguage"/>
				</s:form>
				<a id="hideAddLanguage" style="cursor: hand; margin: 10px;">Hide</a>
			</fieldset>

			<fieldset id="addKind"
				style="margin: 10px; display: none; width: 270px; float: left;">
				<legend>Add New Movie Genre</legend>
				<s:form action="kind" namespace="/">
					<s:textfield name="kindName" label="New Movie Genre" />
					<s:textfield style="display:none;" />
					<s:submit value="Add New Movie Genre" method="saveKind"/>
				</s:form>
				<a id="hideAddKind" style="cursor: hand; margin: 10px;">Hide</a>
			</fieldset>

			<fieldset id="addEdition"
				style="margin: 10px; display: none; width: 270px; float: left;">
				<legend>Add New Movie Version</legend>
				<s:form action="edition" namespace="/">
					<s:textfield name="editionName" label="New Movie Version" />
					<s:textfield style="display:none;" />
					<s:submit value="Add New Movie Version" method="saveEdition"/>
				</s:form>
				<a id="hideAddEdition" style="cursor: hand; margin: 10px;">Hide</a>
			</fieldset>

			<fieldset style="margin: 10px; clear: both;">
				<legend>Add New Movie</legend>
				<a id="showAddLanguage" style="cursor: hand; margin: 10px;">Add New Movie Language</a>
				<a id="showAddKind" style="cursor: hand; margin: 10px;">Add New Movie Genre</a>
				<a id="showAddEdition" style="cursor: hand; margin: 10px;">Add New Movie Version</a>
				<s:form action="movie" enctype="multipart/form-data" method="post"
					namespace="/" style="position: relative; ">
					<s:textfield name="movieName" label="Name" style="width:800px;" />
					<s:textfield name="movieDirector" label="Director" style="width:800px;" />
					<s:textfield name="movieActor" label="Cast" style="width:800px;" />
					<s:checkboxlist list="#application.lstLanguage"
						listKey="languageId" listValue="languageName" name="languageIds"
						label="Language" />

					<s:select list="#application.lstKind" name="kindId"
						listKey="kindId" listValue="kindName" label="Genre" />

					<s:file name="upload" label="Upload Image" style="width:800px;" />
					<s:textfield name="movieLong" label="Length" maxlength="3"
						style="width:30px;" />
					<span style="position:absolute; top:155px; left:100px;">Choose a Local Image File...</span>
					<s:checkboxlist list="#application.lstEdition" listKey="editionId"
						listValue="editionName" name="editionIds" label="Version" />
					<s:textarea name="movieInfo" label="Info" rows="10" cols="100" />
					<sx:datetimepicker name="movieDate" label="Release Date" />
					<s:submit value="Click to Save" method="saveMovie"></s:submit>
				</s:form>
			</fieldset>
		</div>
	</div>
	<div id="footer">
		<s:include value="adminFoot.jsp"></s:include>
	</div>
</body>
</html>
