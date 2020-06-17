package com.opensource.Dao;

import com.opensource.Domain.Licenses;

public class LicensesDao extends BaseDao<Licenses>
{
	
	public Licenses addOne(Licenses Licenses) {
		String sql = "insert into licenses_copy(`name`,abbreviation,abstract,`right`,obligation,"
				+ "prohibition,owner,history,origation,translation,`type`,originURL,SPDX,admin) "
				+ "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		Object params[] = {
				Licenses.getName(),
				Licenses.getAbbreviation(), 
				Licenses.getAbstractName(),
				Licenses.getRight(),
				Licenses.getObligation(),
				Licenses.getProhibition(),
				Licenses.getOwner(),
				Licenses.getHistory(),
				Licenses.getOrigation(),
				Licenses.getTranslation(),
				Licenses.getType(),
				Licenses.getOriginURL(),
				Licenses.getSPDX(),
				Licenses.getAdmin()
				};
		System.out.println("addOne");
		return this.setOne(sql,params);
	}
	
	public Licenses alterOne(String name,Licenses Licenses) {
		String sql = "update licenses_copy set `name`=?,abbreviation=?,abstract=?,`right`=?,"
				+ "obligation=?,prohibition=?,owner=?,history=?,origation=?,translation=?,"
				+ "`type`=?,originURL=?,SPDX=?,admin=? where `name`=?;";
		System.out.println(sql);
		Object params[] = {
			Licenses.getName(),
			Licenses.getAbbreviation(), 
			Licenses.getAbstractName(),
			Licenses.getRight(),
			Licenses.getObligation(),
			Licenses.getProhibition(),
			Licenses.getOwner(),
			Licenses.getHistory(),
			Licenses.getOrigation(),
			Licenses.getTranslation(),
			Licenses.getType(),
			Licenses.getOriginURL(),
			Licenses.getSPDX(),
			Licenses.getAdmin(),
			name
			};
		System.out.println("setOne");
		return this.setOne(sql,params);
	}
	
	public Licenses deleteOne(String name) {
		String sql = "delete from licenses_copy where name=?";
		Object params[] = {name};
		System.out.println("LicensesDao");
		return this.setOne(sql,params);
	}

}
