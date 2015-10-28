package com.listener;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import com.pojo.Admin;
import com.pojo.Member;

public class OnlineMemberListener implements HttpSessionListener{

	public void sessionCreated(HttpSessionEvent se) {
		// TODO Auto-generated method stub
		
	}

	public void sessionDestroyed(HttpSessionEvent se) {
		HttpSession session = se.getSession();   
		ServletContext application = session.getServletContext();   
		
		// get login user
		if(session.getAttribute("curMember")!=null){
			List<Member> onlineMemberList = (List<Member>) application.getAttribute("onlineMemberList");
			Member curMember = (Member) session.getAttribute("curMember");   
			// delete user from list		   
			onlineMemberList.remove(curMember);   
			System.out.println("User:"+curMember.getMemberEmail() + "Timeout logout");   
		}
		if(session.getAttribute("curAdmin")!=null){
			List<Admin> onlineAdminList = (List<Admin>) application.getAttribute("onlineAdminList");
			Admin curAdmin = (Admin) session.getAttribute("curAdmin");   
			// delete manager from list		   
			onlineAdminList.remove(curAdmin);   
			System.out.println("Manager"+curAdmin.getAdminName() + "Timeout logout");   
		}
	}

}
