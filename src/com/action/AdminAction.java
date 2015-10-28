package com.action;

import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.util.IteratorGenerator.Converter;

import com.mysql.jdbc.EscapeTokenizer;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.pojo.Admin;
import com.service.AdminService;

public class AdminAction extends ActionSupport implements ModelDriven<Admin> {

	private Admin admin = new Admin();

	public Admin getModel() {
		// TODO Auto-generated method stub
		return admin;
	}

	private String checkCode;

	public String getCheckCode() {
		return checkCode;
	}

	public void setCheckCode(String checkCode) {
		this.checkCode = checkCode;
	}

	private AdminService adminService;

	public void setAdminService(AdminService adminService) {
		this.adminService = adminService;
	}

	/**
	 * Manager Login
	 * 
	 * @throws Exception
	 */
	public void login() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();

		String checkCode = request.getParameter("checkCode").toString().trim();

		String rand = (String) ActionContext.getContext().getSession()
				.get("rand");

		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		Map<String, Object> session = ActionContext.getContext().getSession();

		if (checkCode.equals(rand)) {
			Admin curAdmin = adminService.login(admin);
			boolean flagOnline = false;
			if (curAdmin != null) {
				Map<String, Object> application = ActionContext.getContext()
						.getApplication();
				// Online List
				List<Admin> onlineAdminList = (List<Admin>) application
						.get("onlineAdminList");
				for (Admin admin : onlineAdminList) {
					if (admin.getAdminId().intValue() == curAdmin.getAdminId()
							.intValue()) {
						flagOnline = true;
					}
				}
				if (session.get("curAdmin") != null) {
					if (curAdmin.getAdminId().intValue() == ((Admin) session
							.get("curAdmin")).getAdminId().intValue()) {
						flagOnline = false;
					}
				}
				if (!flagOnline) {
					// Online List Addition
					if (session.get("curAdmin") != null) {
						if (curAdmin.getAdminId().intValue() != ((Admin) session
								.get("curAdmin")).getAdminId().intValue()) {
							onlineAdminList.add(curAdmin);
						}
					}
					session.put("curAdmin", curAdmin);

					String[] AdminPrivileges = curAdmin.getAdminPrivilege()
							.split(", ");
					List<String> lstPrivilege = Arrays.asList(AdminPrivileges);
					session.put("lstPrivilege", lstPrivilege);
					out.print(3);
				} else {
					out.print(4);
				}
			} else {
				out.print(2);
			}

		} else {
			out.print(1);
		}
		out.flush();
		out.close();
	}

	/**
	 * Manager Dismiss
	 * 
	 * @return
	 * @throws Exception
	 */
	public String logout() throws Exception {
		Map<String, Object> session = ActionContext.getContext().getSession();
		Map<String, Object> application = ActionContext.getContext()
				.getApplication();
		// Online List Remove
		List<Admin> onlineAdminList = (List<Admin>) application
				.get("onlineAdminList");
		onlineAdminList.remove(session.get("curAdmin"));
		session.clear();
		return "login";
	}

	/**
	 * Search All Manager
	 * 
	 * @return
	 * @throws Exception
	 */
	public String searchAdmin() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		List<Admin> lstAdmin = adminService.findAll();
		request.setAttribute("lstAdmin", lstAdmin);
		return "showAdmin";
	}

	/**
	 * Add Manager
	 * 
	 * @return
	 * @throws Exception
	 */
	public String saveAdmin() throws Exception {
		adminService.create(admin);
		return searchAdmin();
	}

	/**
	 * AJAX rules out duplicate login
	 * 
	 * @throws Exception
	 */
	public void IsExistAdminName() throws Exception {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.print(adminService.findByName(admin.getAdminName()));
		out.flush();
		out.close();
	}

	/**
	 * Search Manager by ID
	 * 
	 * @return
	 * @throws Exception
	 */
	public String findAdminById() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		Admin newAdmin = adminService.findById(admin);
		String[] AdminPrivileges = newAdmin.getAdminPrivilege().split(", ");
		List<String> lstPrivilege = Arrays.asList(AdminPrivileges);
		request.setAttribute("admin", newAdmin);
		request.setAttribute("lstPrivilege", lstPrivilege);
		return "updateAdmin";
	}

	/**
	 * Edit Manager
	 * 
	 * @return
	 * @throws Exception
	 */
	public String modifyAdmin() throws Exception {
		adminService.modifyAdmin(admin);
		return searchAdmin();
	}

	/**
	 * Delete Manager
	 * 
	 * @return
	 * @throws Exception
	 */
	public String removeAdmin() throws Exception {
		adminService.remove(admin);
		return searchAdmin();
	}

	public Converter getPrivilegeConverter() {
		return new Converter() {
			public Object convert(String value) throws Exception {
				String result = "";
				switch (Integer.parseInt(value)) {
				case 1:
					result = "Movie Management";
					break;
				case 2:
					result = "Schedule Management";
					break;
				case 3:
					result = "User Management";
					break;
				case 4:
					result = "Ticket Management";
					break;
				case 5:
					result = "Ad Management";
					break;
				case 6:
					result = "Manager Management";
					break;
				}
				return result;
			}
		};
	}
}
