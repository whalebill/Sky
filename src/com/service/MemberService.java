package com.service;

import java.util.List;
import java.util.Map;

import com.dao.MemberDao;
import com.opensymphony.xwork2.ActionContext;
import com.pojo.Member;
import com.util.PageBean;

public class MemberService {

	private MemberDao memberDao;

	public void setMemberDao(MemberDao memberDao) {
		this.memberDao = memberDao;
	}

	/**
	 * User Login
	 * @param member
	 * @return
	 */
	public Member login(Member member) {
		if (memberDao.selectByExample(member).size() == 0) {
			return null;
		} else {
			return memberDao.selectByExample(member).get(0);
		}
	}
	
	/**
	 * Check Email
	 * @param member
	 * @return
	 */
	public boolean isExistEmail(Member member){
		if(memberDao.selectByExample(member).size()!=0){
			return true;
		}else{
			return false;
		}
	}

	/**
	 * Add User
	 * @param member
	 */
	public void create(Member member) {
		if(member.getMemberName()==null){
			member.setMemberName("");
		}
		member.setMemberMoney(0.);
		memberDao.insert(member);		
	}

	/**
	 * Paging search
	 * @param member
	 * @param propertyNames
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public PageBean findLikeByEntityByPage(Member member,
			String[] propertyNames, int currentPage, int pageSize) {
		return memberDao.selectLikeByEntityByPage(member, propertyNames,
				currentPage, pageSize);
	}

	/**
	 * Edit User Info
	 * @param curMember
	 * @param newMember
	 * @return
	 */
	public Member modifyInfo(Member curMember, Member newMember) {
		Member member = memberDao.selectById(curMember.getMemberId());

		if (newMember.getMemberName().toString().length() == 0) {
			member.setMemberName(null);
		}else{
			member.setMemberName(newMember.getMemberName());
		}

		member.setMemberGender(newMember.getMemberGender());
		
		if(newMember.getMemberPhone().toString().length() == 0) {
			member.setMemberPhone(null);
		}else{
			member.setMemberPhone(newMember.getMemberPhone());
		}

		memberDao.update(member);

		return member;
	}

	/**
	 * Edit User Profile Picture
	 * @param curMember
	 * @param newMember
	 * @return
	 */
	public Member modifyPhoto(Member curMember,Member newMember){
		Member member = memberDao.selectById(curMember.getMemberId());
		member.setMemberPhoto(newMember.getMemberPhoto());
		memberDao.update(member);		
		return member;
	}
	
	/**
	 * Check Original Password
	 * @param member
	 * @return
	 */
	public boolean checkOldPwd(Member curMember,Member member){
		if(member.getMemberPwd().trim().equals(curMember.getMemberPwd().trim())){
			return true;
		}else{
			return false;
		}
	}

	/**
	 * Edit User Password
	 * @param curMember
	 * @param newMember
	 * @return
	 */
	public Member modifyPwd(Member curMember, Member newMember) {
		Member member = memberDao.selectById(curMember.getMemberId());
		member.setMemberPwd(newMember.getMemberPwd());
		memberDao.update(member);		
		return member;
	}
	
	/**
	 * Delete User
	 * @param member
	 */
	public void remove(Member member){
		memberDao.delete(memberDao.selectById(member.getMemberId()));		
	}
	
	/**
	 * Search User by ID
	 * @param member
	 * @return
	 */
	public Member findById(Member member){
		return memberDao.selectById(member.getMemberId());
	}
	
	/**
	 * Edit User
	 * @param member
	 */
	public void modify(Member member){
		Member oldMember=memberDao.selectById(member.getMemberId());
		
		oldMember.setMemberEmail(member.getMemberEmail());
		oldMember.setMemberName(member.getMemberName());
		oldMember.setMemberPwd(member.getMemberPwd());
		oldMember.setMemberGender(member.getMemberGender());
		oldMember.setMemberPhone(member.getMemberPhone());
		
		memberDao.update(oldMember);	
	}
}
