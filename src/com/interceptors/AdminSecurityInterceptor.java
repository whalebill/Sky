package com.interceptors;

import java.util.Map;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;

public class AdminSecurityInterceptor extends MethodFilterInterceptor {
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
		System.out.println("AdminSecurityInterceptor"+name+"initiated£¡");
	}

	@Override
	public void destroy() {
		super.destroy();
		System.out.println("AdminSecurityInterceptor"+name+"destroyed£¡");
	}

	@Override
	protected String doIntercept(ActionInvocation invocation) throws Exception {
		System.out.println("AdminSecurityInterceptor"+name+"worked£¡");
		Map<String, Object> session = invocation.getInvocationContext()
				.getSession();
		if (session.get("curAdmin") != null) {
			return invocation.invoke();
		} else {
			return "adminLogin";
		}
	}

}
