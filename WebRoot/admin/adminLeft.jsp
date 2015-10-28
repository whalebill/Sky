<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<fieldset>
	<legend>Management Menu</legend>
	<ul style="line-height: 20px;">
		<s:iterator var="lstPrivilege" value="#session.lstPrivilege">
			<s:if test="#lstPrivilege==1">
				<li><s:a action="movie" method="searchMoviesByPage"
						namespace="/">Movie Management</s:a></li>
			</s:if>
			<s:if test="#lstPrivilege==2">
				<li><s:a action="play" method="findPlaiesByTimeByPage"
						namespace="/">Schedule Management</s:a></li>
			</s:if>
			<s:if test="#lstPrivilege==3">
				<li><s:a action="member" method="searchMembersByPage"
						namespace="/">User Management</s:a></li>
			</s:if>
			<s:if test="#lstPrivilege==4">
				<li><s:a href="admin/showTickets.jsp">Ticket Management</s:a></li>
			</s:if>
			<s:if test="#lstPrivilege==5">
				<li><s:a href="admin/updateAd.jsp">Ad Management</s:a></li>
			</s:if>
			<s:if test="#lstPrivilege==6">
				<li><s:a action="admin" method="searchAdmin" namespace="/">Manager Management</s:a>
				</li>
			</s:if>
		</s:iterator>
	</ul>
</fieldset>