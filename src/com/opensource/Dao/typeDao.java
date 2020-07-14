package com.opensource.Dao;

import java.util.List;

import com.opensource.Domain.type;

public class typeDao extends BaseDao<type>
{
	public List<type> getList() {
		System.out.println("typeDao:getList");
		return this.getList("SELECT * FROM type");
	}
}