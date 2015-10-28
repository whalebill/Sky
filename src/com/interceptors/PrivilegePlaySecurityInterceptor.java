package com.interceptors;

import java.util.Map;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;
import com.pojo.Admin;

public class PrivilegePlaySecurityInterceptor extends MethodFilterInterceptor{
	private String name;
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}

	@Override
	public void init() {
		super.init();
		System.out.println("PrivilegePlaySecurityInterceptor"+name+"initiated£¡");
	}

	@Override
	public void destroy() {
		super.destroy();
		System.out.println("PrivilegePlaySecurityInterceptor"+name+"destroyed£¡");
	}

	@Override
	protected String doIntercept(ActionInvocation invocation) throws Exception {
		System.out.println("PrivilegePlaySecurityInterceptor"+name+"worked£¡");
		Map<String, Object> session = invocation.getInvocationContext()
				.getSession();
		if (session.get("curAdmin") != null) {
			if(((Admin)session.get("curAdmin")).getAdminPrivilege().indexOf("2")!=-1){
				return invocation.invoke();
			}else{
				return "adminLogin";
			}
		} else {
			return "adminLogin";
		}
	}

}
