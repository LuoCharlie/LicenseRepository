package com.opensource.Dao;

import java.util.ArrayList;
import java.util.List;
import com.opensource.Domain.description;
import com.opensource.Domain.type;

public class descriptionDao extends BaseDao<description>
{
	public List<description> getByList(String type,String[] names) {
		System.out.println("description");
		String sql = "";
		for(int i = 0; i<names.length-1;i++)
		{
			sql += "SELECT name, description from license_discription where type ='"+type+"'"+" and name='"+names[i]+"' union all ";
		}
		sql +=  "SELECT name, description from license_discription where type ='"+type+"'"+" and name='"+names[names.length-1]+"';";
		System.out.println(sql);
		return this.getList(sql);
	}
}
