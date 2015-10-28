package com.service;

import java.util.List;

import com.dao.AdminDao;
import com.pojo.Admin;
import com.util.PageBean;

public class AdminService {
	
	private AdminDao adminDao;

	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}
	
	/**
	 * Manager Login
	 * @param admin
	 * @return
	 */
	public Admin login(Admin admin){
		List<Admin> lstAdmin=adminDao.selectByExample(admin);
		if(lstAdmin.size()==0){
			return null;
		}else{
			return lstAdmin.get(0);
		}		
	}	
	
	/**
	 * Search Manager
	 * @return
	 */
	public List<Admin> findAll(){
		return adminDao.selectAll();
	}
	
	/**
	 * Add Manager
	 * @param admin
	 */
	public void create(Admin admin){
		adminDao.insert(admin);
	}
	
	/**
	 * Search by Manager Username
	 * @param adminName
	 * @return
	 */
	public boolean findByName(String adminName){
		Admin admin=new Admin();
		admin.setAdminName(adminName);
		List<Admin> lstAdmin=adminDao.selectByExample(admin);
		if(lstAdmin.size()>0){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * Search Manager by ID
	 * @param admin
	 * @return
	 */
	public Admin findById(Admin admin){
		return adminDao.selectById(admin.getAdminId());
	}
	
	/**
	 * Edit Manager
	 * @param admin
	 */
	public void modifyAdmin(Admin admin){
		adminDao.update(admin);
	}
	
	/**
	 * Delete Manager
	 * @param admin
	 */
	public void remove(Admin admin){
		adminDao.delete(adminDao.selectById(admin.getAdminId()));
	}
}
