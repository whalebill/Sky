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

<title>Sky Movie Background Ad Management</title>

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
		<div id="main_right" style="margin: 10px; float: left; width:1120px; overflow:visible;">
			<fieldset>
				<legend>Ad Management</legend>
				<s:iterator var="ad" value="#application.lstAd">
					<s:form action="ad" enctype="multipart/form-data" method="post"
						namespace="/">
						<s:if test="#ad.adId==1">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" />
								</s:iterator>
							</s:generator>
							<s:file name="upload" label="LOGO" />
							<s:textfield name="adHref" label="Link Address" value="%{#ad.adHref}" />
							<s:hidden name="adId" value="%{#ad.adId}" />
						</s:if>

						<s:if test="#ad.adId==2">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" />
								</s:iterator>
							</s:generator>
							<s:file name="upload" label="Header Ad" />
							<s:textfield name="adHref" label="Link Address" value="%{#ad.adHref}" />
							<s:hidden name="adId" value="%{#ad.adId}" />
						</s:if>
						<s:if test="#ad.adId==3">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" />
								</s:iterator>
							</s:generator>
							<s:file name="upload" label="Foot Ad 1" />
							<s:textfield name="adHref" label="Link Address" value="%{#ad.adHref}" />
							<s:hidden name="adId" value="%{#ad.adId}" />
						</s:if>
						<s:if test="#ad.adId==4">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" />
								</s:iterator>
							</s:generator>
							<s:file name="upload" label="Foot Ad 2" />
							<s:textfield name="adHref" label="Link Address" value="%{#ad.adHref}" />
							<s:hidden name="adId" value="%{#ad.adId}" />
						</s:if>

						<s:if test="#ad.adId==5">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" />
								</s:iterator>
							</s:generator>
							<s:file name="upload" label="Right Ad 1" />
							<s:textfield name="adHref" label="Link Address" value="%{#ad.adHref}" />
							<s:hidden name="adId" value="%{#ad.adId}" />
						</s:if>
						<s:if test="#ad.adId==6">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" />
								</s:iterator>
							</s:generator>
							<s:file name="upload" label="Right Ad 2" />
							<s:textfield name="adHref" label="Link Address" value="%{#ad.adHref}" />
							<s:hidden name="adId" value="%{#ad.adId}" />
						</s:if>
						<s:if test="#ad.adId==7">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" />
								</s:iterator>
							</s:generator>
							<s:file name="upload" label="Right Ad 3" />
							<s:textfield name="adHref" label="Link Address" value="%{#ad.adHref}" />
							<s:hidden name="adId" value="%{#ad.adId}" />
						</s:if>
						<s:if test="#ad.adId==8">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" />
								</s:iterator>
							</s:generator>
							<s:file name="upload" label="Right Ad 4" />
							<s:textfield name="adHref" label="Link Address" value="%{#ad.adHref}" />
							<s:hidden name="adId" value="%{#ad.adId}" />
						</s:if>
						<s:if test="#ad.adId==9">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" />
								</s:iterator>
							</s:generator>
							<s:file name="upload" label="Right Ad 5" />
							<s:textfield name="adHref" label="Link Address" value="%{#ad.adHref}" />
							<s:hidden name="adId" value="%{#ad.adId}" />
						</s:if>
						<s:if test="#ad.adId==10">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" />
								</s:iterator>
							</s:generator>
							<s:file name="upload" label="Dynamic Ad 1" />
							<s:textfield name="adHref" label="Link Address" value="%{#ad.adHref}" />
							<s:hidden name="adId" value="%{#ad.adId}" />
						</s:if>
						<s:if test="#ad.adId==11">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" />
								</s:iterator>
							</s:generator>
							<s:file name="upload" label="Dynamic Ad 2" />
							<s:textfield name="adHref" label="Link Address" value="%{#ad.adHref}" />
							<s:hidden name="adId" value="%{#ad.adId}" />
						</s:if>
						<s:if test="#ad.adId==12">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" />
								</s:iterator>
							</s:generator>
							<s:file name="upload" label="Dynamic Ad 3" />
							<s:textfield name="adHref" label="Link Address" value="%{#ad.adHref}" />
							<s:hidden name="adId" value="%{#ad.adId}" />
						</s:if>
						<s:if test="#ad.adId==13">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" />
								</s:iterator>
							</s:generator>
							<s:file name="upload" label="Dynamic Ad 4" />
							<s:textfield name="adHref" label="Link Address" value="%{#ad.adHref}" />
							<s:hidden name="adId" value="%{#ad.adId}" />
						</s:if>
						<s:submit value="Click to Save" method="modifyAd" />
					</s:form>
					<s:if test="#ad.adId==1||#ad.adId==4||#ad.adId==9">
						<hr>
					</s:if>
				</s:iterator>
			</fieldset>
		</div>
	</div>
	<div id="footer">
		<s:include value="adminFoot.jsp"></s:include>
	</div>
</body>
</html>
