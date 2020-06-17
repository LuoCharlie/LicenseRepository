package com.opensource.Dao;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapHandler;

import com.opensource.Domain.fqa;

public abstract class BaseDao<T> {
	
	protected Class<T> clazz;
	public BaseDao() {
		// ����  reflection
		Type superClass = getClass().getGenericSuperclass();
		if (superClass instanceof ParameterizedType) {
			ParameterizedType parameteriedType = (ParameterizedType)superClass;
			Type[] typeArgs = parameteriedType.getActualTypeArguments();
			if (typeArgs != null && typeArgs.length > 0) {
				if (typeArgs[0] instanceof Class) {
					clazz = (Class<T>) typeArgs[0];
				}
			}
		}
	}
	
	public List<T> getList(String sql, Object ...args) {
		QueryRunner runner = new QueryRunner(DBUtil.getDataSource());
		BeanListHandler<T> beanListHandler = new BeanListHandler<T>(clazz);
		try {
			System.out.println("baseDao");
			return runner.query(sql, beanListHandler, args);
		} catch (SQLException e) {
			e.printStackTrace();
			return new ArrayList<T>();
		}
	}
	
	@SuppressWarnings("unchecked")
	public T getOne(String sql, Object ...args) {
		QueryRunner runner = new QueryRunner(DBUtil.getDataSource());
		BeanHandler<T> beanHandler = new BeanHandler<T>(clazz);
		try {
			return runner.query(sql, beanHandler, args);
		} catch (SQLException e) {
			e.printStackTrace();
			return (T) new BeanHandler<T>(clazz);
		}
	}
	
	public T setOne(String sql, Object ...args) {
		QueryRunner runner = new QueryRunner(DBUtil.getDataSource());
		try {
			runner.update(sql, args);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public List<T> setList(String sql, Object ...args) {
		QueryRunner runner = new QueryRunner(DBUtil.getDataSource());
		BeanHandler<T> beanHandler = new BeanHandler<T>(clazz);
		try {
			runner.update(sql, beanHandler, args);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
}