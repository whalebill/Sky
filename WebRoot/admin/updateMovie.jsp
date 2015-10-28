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

<title>Sky Movie Background Update Movie</title>

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
				<legend>Movie & Schedule Management</legend>
				<s:form action="movie" enctype="multipart/form-data" method="post"
					namespace="/" style="position: relative;">
					<s:hidden name="movieId" value="%{#request.movie.movieId}"/>
					<s:textfield name="movieName" label="Name"
						value="%{#request.movie.movieName}" style="width:800px;" />
					<s:textfield name="movieDirector" label="Director"
						value="%{#request.movie.movieDirector}" style="width:800px;" />
					<s:textfield name="movieActor" label="Cast"
						value="%{#request.movie.movieActor}" style="width:800px;" />
					<s:radio list="#application.lstLanguage" listKey="languageId"
						listValue="languageName" name="languageId"
						value="%{#request.movie.language.languageId}" label="Language" />
					<s:select list="#application.lstKind" name="kindId"
						value="%{#request.movie.kind.kindId}" listKey="kindId"
						listValue="kindName" label="Version" />
					<s:file name="upload" label="Upload Image" style="width:800px;" />
					<s:textfield name="movieLong" label="Length" maxlength="3"
						value="%{#request.movie.movieLong}" style="width:30px;" />
					<span style="position:absolute; top:157px; left:101px;">Upload an image from local...</span>
					<s:radio list="#application.lstEdition" listKey="editionId"
						listValue="editionName"
						value="%{#request.movie.edition.editionId}" name="editionId"
						label="Version" />
					<s:textarea name="movieInfo" label="Info" rows="10" cols="100"
						value="%{#request.movie.movieInfo}" />
					<sx:datetimepicker name="movieDate" label="Release Date"
						value="%{#request.movie.movieDate}" />

					<s:submit value="Click to Save" method="modifyMovie"></s:submit>

				</s:form>
				<s:iterator value="#request.lstPlaies" status="s" var="play">
						Movie Schedule<s:property value="%{#s.index+1}" />:<s:date
						name="#play.playTime" format="yyyy/MM/dd HH:mm" />
						<s:a action="play" method="findPlay">
						<s:param name="playId" value="#play.playId"/>
						Update Schedule</s:a>
					<br />
				</s:iterator>
			</fieldset>
		</div>
	</div>
	<div id="footer">
		<s:include value="adminFoot.jsp"></s:include>
	</div>
</body>
</html>
