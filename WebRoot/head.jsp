<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div id="header_menu">
	<div id="header_menu_left">
		&nbsp;
		<a href="index.jsp" class="aToptxt">Sky Movie</a>
	</div>
	<div id="header_menu_right">
		<s:if test="#session.curMember==null">
			<a href="register.jsp" class="aToptxt">Register</a><span>|</span>
	        <a href="login.jsp" class="aToptxt">Login</a><span>|</span>
		</s:if>
		<s:else>
        	<span>Welcome，
        	<s:if test="#session.curMember.memberName==null||#session.curMember.memberName==''">
				<s:property value="#session.curMember.memberEmail" />
			</s:if>
			<s:else>				
				<s:if test="#session.curMember.memberGender==1">Mr.</s:if>
				<s:else>Ms.</s:else>
				<s:property value="#session.curMember.memberName" />				
			</s:else></span><span>|</span>       	   	
        	<a class="aToptxt" style="cursor: hand; " onclick="location='member!logout.action';">Logout</a><span>|</span>
        	<a href="memberCenter.jsp" class="aToptxt">Account Center</a><span>|</span>
		</s:else>
		
		<a href="#" class="aToptxt">Help</a>&nbsp;
	</div>
</div>

<div id="header_middle">

	<div id="header_middle_left">
	<marquee id="marquee" behavior="alternate" direction="right" >
		<s:iterator var="ad" value="#application.lstAd">
			<s:if test="#ad.adId==1">
				<s:a href="%{#ad.adHref}">
					<s:generator separator="," val="#ad.adImg">
						<s:iterator>
							<img src='<s:property />' border="0" height="75" onMouseOut="document.getElementById('marquee').start()" onMouseOver="document.getElementById('marquee').stop()"/>
						</s:iterator>
					</s:generator>
				</s:a>
			</s:if>
		</s:iterator>
		</marquee>	
	</div>

	<div id="header_middle_right">
		<s:form action="play" theme="simple">
			<s:textfield name="movieName" value="Input Movie Name to Search Schedule"
					style="width:200px; color:gray; margin:5px;" onfocus="if (this.value == 'Input Movie Name to Search Schedule') {this.value = '';this.style.color = 'black';}" onblur="if (this.value == '' || this == 0) {this.style.color = 'gray';this.value = 'Input Movie Name to Search Schedule';}" />
			<s:textfield style="display:none;" />
			<s:submit value="Search" method="showPlayTable"  style="vertical-align: middle;"/>
		</s:form>
	</div>
</div>

<div id="header_bottommenu">
	<a href="index.jsp" class="aMenuTxt">Home</a>
	|
	<a href="time.jsp" class="aMenuTxt">Schedule</a>
	|
	<a href="movies.jsp" class="aMenuTxt">Movie</a>
</div>