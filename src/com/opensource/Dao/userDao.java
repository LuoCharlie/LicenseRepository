package com.opensource.Dao;

import java.util.List;
import com.opensource.Domain.user;

public class userDao extends BaseDao<user>
{
	public user getUser(String type,String name) {
		String sql = "SELECT * FROM "+type+" where name=\""+name+"\";";
		if(this.getOne(sql)!=null)
		{
			System.out.println("userDao不为空");
			return this.getOne(sql);
		}
		else
		{
			System.out.println("userDao空");
			return new user();
		}
	}
	
	public user addUser(String type,user user) {
		String sql = "insert into "+type+"(name,password) values(?,?)";
		Object[] params = {user.getName(),user.getPassword()};
			return this.setOne(sql,params);
	}
}
