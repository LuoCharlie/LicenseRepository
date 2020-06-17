package com.opensource.Dao;

import com.opensource.Domain.detailLicense;

public class detailDao extends BaseDao<detailLicense>
{
	public detailLicense getByName(String name) {
		System.out.println("detailDao");
		return this.getOne("SELECT * FROM detail WHERE name=?", name);
	}
}
