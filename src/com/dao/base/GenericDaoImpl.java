package com.dao.base;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;

import java.lang.reflect.Type;
import java.util.List;

import org.apache.commons.beanutils.PropertyUtils;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.pojo.Movie;
import com.util.PageBean;

public class GenericDaoImpl<T, PK extends Serializable> extends
		HibernateDaoSupport implements IGenericDao<T, PK> {
	private Class<T> entityClass;

	public GenericDaoImpl() {
		this.entityClass = null;
		Class c = getClass();
		Type t = c.getGenericSuperclass();
		if (t instanceof ParameterizedType) {
			Type[] p = ((ParameterizedType) t).getActualTypeArguments();
			this.entityClass = (Class<T>) p[0];
		}
	}

	// -------------------- CRUD --------------------
	//get entity by id
	public T selectById(PK id) {
		return getHibernateTemplate().get(entityClass, id);
	}

	// get all entity
	public List<T> selectAll() {
		return (List<T>) getHibernateTemplate().loadAll(entityClass);
	}

	// save entity to database
	public void insert(T entity) {
		getHibernateTemplate().save(entity);
	}

	// update entity
	public void update(T entity) {
		getHibernateTemplate().update(entity);
	}

	// delete entity
	public void delete(T entity) {
		getHibernateTemplate().delete(entity);
	}

	// -------------------------------- Criteria ------------------------------

	// create detached criteria
	public DetachedCriteria createDetachedCriteria() {
		return DetachedCriteria.forClass(this.entityClass);
	}

	// create executable criteria
	public Criteria createCriteria() {
		return this.createDetachedCriteria().getExecutableCriteria(
				this.getSession());
	}

	
	// public List<T> selectEqualByEntity(T entity, String[] propertyNames) {
	// Criteria criteria = this.createCriteria();
	// Example exam = Example.create(entity);
	// exam.excludeZeroes();
	// String[] defPropertys = getSessionFactory().getClassMetadata(
	// entityClass).getPropertyNames();
	// for (String defProperty : defPropertys) {
	// int ii = 0;
	// for (ii = 0; ii < propertyNames.length; ++ii) {
	// if (defProperty.equals(propertyNames[ii])) {
	// criteria.addOrder(Order.asc(defProperty));
	// break;
	// }
	// }
	// if (ii == propertyNames.length) {
	// exam.excludeProperty(defProperty);
	// }
	// }
	// criteria.add(exam);
	// return (List<T>) criteria.list();
	// }

	// select data Like By Entity By Page
	public PageBean selectLikeByEntityByPage(T entity, String[] propertyNames,int currentPage , int pageSize) {
		Criteria criteria = this.createCriteria();
		for (String property : propertyNames) {
			try {
				Object value = PropertyUtils.getProperty(entity, property);
				if (value instanceof String) {
					criteria.add(Restrictions.like(property, (String) value,
							MatchMode.ANYWHERE));
					criteria.addOrder(Order.asc(property));
				} 
//				else {
//					criteria.add(Restrictions.eq(property, value));
//					criteria.addOrder(Order.asc(property));
//				}
				criteria.setFirstResult((currentPage - 1) * pageSize);
				criteria.setMaxResults(pageSize);
			} catch (Exception ex) {
				// ignore invalid
			}
		}
		List<T> lstLikeEntity =(List<T>) criteria.list();
		
		Criteria criteria_totalRows = createCriteria();
		
		for (String property : propertyNames) {
			try {
				Object value = PropertyUtils.getProperty(entity, property);
				if (value instanceof String) {
					criteria_totalRows.add(Restrictions.like(property, (String) value,
							MatchMode.ANYWHERE));
				} 
			} catch (Exception ex) {
				// ignore invalid
			}
		}
		criteria_totalRows.setProjection(Projections.rowCount());
		
		int totalRows = Integer.parseInt(criteria_totalRows.uniqueResult()
				.toString());
		
		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(currentPage);
		pageBean.setPageSize(pageSize);
		pageBean.setTotalRows(totalRows);
		pageBean.setData(lstLikeEntity);

		return pageBean;
	}

	// select by example to search consistent object
	public List<T> selectByExample(T entity) {
		Criteria criteria = this.createCriteria();
		criteria.add(Example.create(entity));
		return criteria.list();
	}
	
	//paging
	public PageBean selectByPage( int currentPage , int pageSize  ){
		Criteria criteria_data=createCriteria();
		criteria_data.setFirstResult((currentPage - 1) * pageSize);
		criteria_data.setMaxResults(pageSize);
		
		List<T> entityClass=criteria_data.list();
		
		Criteria criteria_totalRows=createCriteria();
		criteria_totalRows.setProjection(Projections.rowCount());
		int totalRows=Integer.parseInt(criteria_totalRows.uniqueResult().toString());
		
		PageBean pageBean=new PageBean();
		pageBean.setCurrentPage(currentPage);
		pageBean.setPageSize(pageSize);
		pageBean.setTotalRows(totalRows);
		pageBean.setData(entityClass);
		
		return pageBean;		
	}
}
