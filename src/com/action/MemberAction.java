package com.action;

import java.io.File;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import com.pojo.Member;
import com.service.MemberService;
import com.util.FileProcessUitl;
import com.util.PageBean;

public class MemberAction extends ActionSupport implements ModelDriven<Member> {

	private Member member = new Member();

	public Member getModel() {
		// TODO Auto-generated method stub
		return member;
	}

	private String checkCode;

	public String getCheckCode() {
		return checkCode;
	}

	public void setCheckCode(String checkCode) {
		this.checkCode = checkCode;
	}

	private MemberService memberService;

	public void setMemberService(MemberService memberService) {
		this.memberService = memberService;
	}

	private File[] upload; // File uploaded
	private String[] uploadContentType; // File kind ---> png jpg
	private String[] uploadFileName; // File Name ---> A.PNG B.jpg

	public File[] getUpload() {
		return upload;
	}

	public void setUpload(File[] upload) {
		this.upload = upload;
	}

	public String[] getUploadContentType() {
		return uploadContentType;
	}

	public void setUploadContentType(String[] uploadContentType) {
		this.uploadContentType = uploadContentType;
	}

	public String[] getUploadFileName() {
		return uploadFileName;
	}

	public void setUploadFileName(String[] uploadFileName) {
		this.uploadFileName = uploadFileName;
	}
	
	/**
	 * Check valid for new registry email
	 * 
	 * @throws Exception
	 */
	public void IsExistMemberEmail() throws Exception {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.print(memberService.isExistEmail(member));
		out.flush();
		out.close();
	}

	/**
	 * Registry
	 * 
	 * @return
	 * @throws Exception
	 */
	public String register() throws Exception {

		HttpServletRequest request = ServletActionContext.getRequest();

		String checkCode = request.getParameter("checkCode").toString().trim();
		String rand = (String) ActionContext.getContext().getSession()
				.get("rand");
		if (checkCode.equals(rand)) {
			memberService.create(member);

			Map<String, Object> session = ActionContext.getContext()
					.getSession();
			session.put("curMember", memberService.login(member));

			return "index";
		} else {
			return null;
		}
	}

	/**
	 * Check verification code
	 * 
	 * @throws Exception
	 */
	public void checkCode() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();

		String checkCode = request.getParameter("checkCode").toString().trim();
		String rand = (String) ActionContext.getContext().getSession()
				.get("rand");
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		if (checkCode.equals(rand)) {
			out.print(true);
		} else {
			out.print(false);
		}
		out.flush();
		out.close();
	}

	/**
	 * Login & Cookie
	 * 
	 * @throws Exception
	 */
	public void login() throws Exception {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		HttpServletRequest request=ServletActionContext.getRequest();
		
		Map<String, Object> session = ActionContext.getContext()
				.getSession();
		
		Boolean auto=Boolean.parseBoolean(request.getParameter("auto"));
		
		Member curMember = memberService.login(member);
		boolean flagOnline=false;
		if (curMember != null) {
			Map<String,Object> application=ActionContext.getContext().getApplication();
			//Online List
			List<Member> onlineMemberList=(List<Member>) application.get("onlineMemberList");
			for (Member member : onlineMemberList) {
				if(member.getMemberId().intValue()==curMember.getMemberId().intValue()){
					flagOnline=true;
				}
			}
			if(session.get("curMember") != null){
				if(curMember.getMemberId().intValue()==((Member)session.get("curMember")).getMemberId().intValue()){
					flagOnline = false;
				}
			}
			if(!flagOnline){
				//Online List Addition
				if(session.get("curMember") != null){
					if(curMember.getMemberId().intValue()!=((Member)session.get("curMember")).getMemberId().intValue()){
						onlineMemberList.add(curMember);
					}
				}
				
				session.put("curMember", curMember);
				
				if (auto) { // If cookie checkbox checked£¬save user info into cookie & client-end while login£¡
					// Create cookie to save user login info
					Cookie cookie = new Cookie("TianRenInfo", member.getMemberEmail() + "," + member.getMemberPwd());
					cookie.setMaxAge(60 * 60 * 24 * 30);
					// Save cookie to client-end
					response.addCookie(cookie);
					
				} else { // If cookie checkbox unchecked£¬find if already exits cookie info£¬if so delete it£¡
					
					Cookie[] cookies = request.getCookies();
					for (Cookie cookie : cookies) {
						if ("TianRenInfo".equals(cookie.getName())) {
							// delete cookie£¬set expire time to 0£¡
							cookie.setMaxAge(0);
							// save this new cookie to client-end to void it£¡
							response.addCookie(cookie);
							break;
						}
					}
				}
				
				out.print(true);
			}else{
				out.print("online");
			}
		} else {
			out.print(false);
		}
		out.flush();
		out.close();
	}

	/**
	 * Cancel
	 * 
	 * @return
	 * @throws Exception
	 */
	public String logout() throws Exception {
		Map<String, Object> session = ActionContext.getContext().getSession();
		Map<String,Object> application=ActionContext.getContext().getApplication();
		//Remove Online List
		List<Member> onlineMemberList=(List<Member>) application.get("onlineMemberList");
		onlineMemberList.remove(session.get("curMember"));
		
		session.clear();
		
		return "index";
	}

	/**
	 * Paging Search Users
	 * 
	 * @return
	 * @throws Exception
	 */
	public String searchMembersByPage() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		if (request.getParameter("searchWord") != null) {
			member.setMemberName(new String(request.getParameter("searchWord")
					.toString().trim().getBytes("ISO8859-1"), "UTF-8"));
		}

		int currentPage = 1;
		if (request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage")
					.toString());
		}

		int pageSize = 8;
		if (request.getParameter("pageSize") != null) {
			pageSize = Integer.parseInt(request.getParameter("pageSize")
					.toString());
		}

		PageBean searchMembersByPage = memberService.findLikeByEntityByPage(
				member, new String[] { "memberName" }, currentPage, pageSize);

		request.setAttribute("searchMembersByPage", searchMembersByPage);
		request.setAttribute("searchWord", member.getMemberName());
		return "showMembers";
	}

	/**
	 * Edit User Info
	 * 
	 * @return
	 * @throws Exception
	 */
	public String modifyMemberInfo() throws Exception {
		Map<String, Object> session = ActionContext.getContext().getSession();
		Member curMember = (Member) session.get("curMember");
		session.put("curMember", memberService.modifyInfo(curMember, member));
		return "updateInfo";
	}

	/**
	 * Edit Profile Picture
	 * 
	 * @return
	 * @throws Exception
	 */
	public String modifyMemberPhoto() throws Exception {
		Map<String, Object> session = ActionContext.getContext().getSession();
		Member curMember = (Member) session.get("curMember");
		FileProcessUitl util = new FileProcessUitl();
		String path = util.processFileUpload("/uploadMember", upload,
				uploadFileName);
		member.setMemberPhoto(path);
		session.put("curMember", memberService.modifyPhoto(curMember, member));
		return "updateInfo";
	}

	/**
	 * Edit User Password
	 * 
	 * @return
	 * @throws Exception
	 */
	public String modifyMemberPwd() throws Exception {
		Map<String, Object> session = ActionContext.getContext().getSession();
		Member curMember = (Member) session.get("curMember");
		session.put("curMember", memberService.modifyPwd(curMember, member));
		return "updatePwd";
	}

	/**
	 * Check Original Password
	 * 
	 * @throws Exception
	 */
	public void checkOldMemberPwd() throws Exception {
		Map<String, Object> session = ActionContext.getContext().getSession();

		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.print(memberService.checkOldPwd((Member) session.get("curMember"),
				member));
		out.flush();
		out.close();
	}

	/**
	 * Add User
	 * 
	 * @return
	 * @throws Exception
	 */
	public String saveMember() throws Exception {
		memberService.create(member);
		return searchMembersByPage();
	}

	/**
	 * Delete User
	 * 
	 * @return
	 * @throws Exception
	 */
	public String removeMember() throws Exception {
		memberService.remove(member);
		return searchMembersByPage();
	}

	/**
	 * Search User by ID
	 * 
	 * @return
	 * @throws Exception
	 */
	public String findMemberById() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("member", memberService.findById(member));
		return "updateMember";
	}

	/**
	 * Edit User
	 * 
	 * @return
	 * @throws Exception
	 */
	public String modifyMember() throws Exception {
		memberService.modify(member);
		return searchMembersByPage();
	}
	
	/**
	 * Check cookie while login£¬if exit, login£¬if not jump to input login info
	 * @return
	 * @throws Exception
	 */
	public String prepareLogin() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		//get cookie from client-end
		Cookie[] cookies = request.getCookies();
		
		Map<String, Object> session = ActionContext.getContext()
				.getSession();
		
		String memberEmail = null;
		String memberPwd = null;
		//find cookie info
		for (Cookie cookie : cookies) {
			if("TianRenInfo".equals(cookie.getName())) {
				String[] studentInfo = cookie.getValue().split(",");
				memberEmail = studentInfo[0];
				memberPwd = studentInfo[1];	
				break;
			}
		}
		//if cookie info is not null£¬login£¡
		if(memberEmail!=null && memberPwd !=null) {
			member.setMemberEmail(memberEmail);
			member.setMemberPwd(memberPwd);
			Member curMember = memberService.login(member);			
			session.put("curMember", curMember);
		}
		session.put("cookieFlag", true);
		return "index";		
	}
}
