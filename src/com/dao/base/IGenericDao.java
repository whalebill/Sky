package com.dao.base;

import java.io.Serializable;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;

import com.util.PageBean;

public interface IGenericDao<T, PK extends Serializable> {

	// -------------------- CRUD--------------------

	public abstract T selectById(PK id);

	public abstract List<T> selectAll();

	public abstract void insert(T entity);

	public abstract void update(T entity);

	public abstract void delete(T entity);

	// -------------------------------- Criteria ------------------------------

	public DetachedCriteria createDetachedCriteria();

	public Criteria createCriteria();

	public PageBean selectLikeByEntityByPage(T entity, String[] propertyNames,int currentPage , int pageSize);
	
	public List<T> selectByExample(T entity);

	public PageBean selectByPage( int currentPage , int pageSize  );
}
