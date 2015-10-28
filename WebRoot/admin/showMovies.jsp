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

<title>Sky Movie Background Movie Management</title>

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
	function changePageSize(obj) {
		var pageSize = obj.value;
		var searchWord = document.getElementsByName("movieName")[0].value;

		window.location.href = "./movie!searchMoviesByPage.action?pageSize="
				+ pageSize + "&searchWord=" + searchWord;
	}
</script>
</head>

<body>
	<div id="header">
		<s:include value="adminHead.jsp"></s:include>
	</div>
	<div id="main">
		<div id="main_left" style="float:left; width:180px; margin: 10px;">
			<s:include value="adminLeft.jsp"/>
		</div>
		<div id="main_right" style="margin: 10px; float: left; width:1120px; overflow: auto;">
			<fieldset>
				<legend>Movie Management</legend>
				<h4>
					<s:a href="admin/saveMovie.jsp">Add New Movie</s:a>
				</h4>
				<hr />
				<s:form action="movie" method="post" namespace="/">
					<s:textfield name="movieName" value="%{#request.searchWord}"
						label="Name" style="width:400px;" />
					<s:textfield style="display:none;" />
					<s:submit value="Search" method="searchMoviesByPage" />
				</s:form>
				<hr />
				<table width="100%" cellpadding="5px;" border="1">
					<tr>
						<th>Name</th>
						<th>Director</th>
						<th>Cast</th>
						<th>Language</th>
						<th>Genre</th>
						<th>Length</th>
						<th>Version</th>
						<th>Info</th>
						<th>Release Date</th>
						<th>Operation</th>
					</tr>

					<s:iterator var="movie" value="#request.searchMoviesByPage.data">
						<tr align="center">
							<td><s:property value="#movie.movieName" />
							</td>
							<td><s:property value="#movie.movieDirector" />
							</td>
							<td><s:property value="#movie.movieActor" />
							</td>
							<td><s:property value="#movie.language.languageName" />
							</td>
							<td><s:property value="#movie.kind.kindName" />
							</td>
							<td><s:property value="#movie.movieLong+'min'" />
							</td>
							<td><s:property value="#movie.edition.editionName" />
							</td>
							<td><s:property
									value="#movie.movieInfo.substring(0,30)+'...'" />
							</td>
							<td><s:date name="#movie.movieDate" format="yyyy/MM/dd" />
							</td>
							<td><s:a action="movie" method="showMovie">
									<s:param name="movieId" value="#movie.movieId" />
										Update
									</s:a><br /> <s:a action="movie" method="removeMovie"
									onclick="return confirm('Are you sure to delete this movie？')">
									<s:param name="movieId" value="#movie.movieId" />
										Delete
									</s:a>
							</td>
						</tr>
					</s:iterator>
				</table>
				Please choose：Page 
				<s:iterator var="i" begin="1"
					end="%{#request.searchMoviesByPage.totalPages}">
					<s:if test="#request.searchMoviesByPage.currentPage != #i ">
						<s:a action="movie" method="searchMoviesByPage" namespace="/"
							style="color:blue;">
							<s:param name="currentPage" value="#i" />
							<s:param name="pageSize"
								value="#request.searchMoviesByPage.pageSize" />
							<s:param name="searchWord" value="#request.searchWord" />
							<s:property value="#i" />
						</s:a>
					</s:if>

					<s:if test="#request.searchMoviesByPage.currentPage == #i">
						<strong style="color:red;"><s:property value="#i" /> </strong>
					</s:if>
				</s:iterator>
				
				<s:select list="(10).{#this+1}" name="pageSize" label="Movie per Page"
					value="#request.searchMoviesByPage.pageSize"
					onchange="changePageSize(this)" />

			</fieldset>
		</div>
	</div>

	<div id="footer">
		<s:include value="adminFoot.jsp"></s:include>
	</div>
</body>
</html>
