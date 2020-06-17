package com.opensource.Dao;

import com.opensource.Domain.downloadLicense;
import java.util.List;

public class downloadDao extends BaseDao<downloadLicense>
{
	public List<downloadLicense> getList() {
		System.out.println("downloadDao");
		return this.getList("SELECT * FROM download");
	}
	public downloadLicense getOne(String name) {
		System.out.println("downloadLicense");
		return this.getOne("SELECT * FROM download WHERE name=?", name);
	} 
}
