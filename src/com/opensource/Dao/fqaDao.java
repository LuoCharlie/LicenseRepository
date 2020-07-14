package com.opensource.Dao;

import java.util.ArrayList;
import java.util.List;
import com.opensource.Domain.fqa;

public class fqaDao extends BaseDao<fqa>
{
	public List<fqa> getPage(int offset, int pageSize) {
		return this.getList("SELECT * FROM fqa ORDER BY id ASC LIMIT ? OFFSET ?",  pageSize, offset);
	}
	
	public fqa getCount() {
		return this.getOne("select count(*) as count from fqa;");
	}
	
	public fqa addOne(fqa fqa) {
		String sql = "insert into license_fqa(question,answer,admin,date) values(?,?,?,?)";
		Object params[] = {fqa.getQuestion(),fqa.getAnswer(), fqa.getAdmin(),fqa.getDate()};
		System.out.println("fqaDao");
		return this.setOne(sql,params);
	}
	
	public fqa alterOne(fqa fqa) {
		String sql = "update license_fqa set question=?,answer=?,admin=?,date=? where question=?";
		Object params[] = {fqa.getQuestion(),fqa.getAnswer(), fqa.getAdmin(),fqa.getDate(),fqa.getQuestion()};
		System.out.println("fqaDao");
		return this.setOne(sql,params);
	}
	
	public fqa deleteOne(String question) {
		String sql = "delete from license_fqa where question=?";
		Object params[] = {question};
		System.out.println("fqaDao");
		return this.setOne(sql,params);
	}
	
	public List<fqa> addList(List<List> data) {
		System.out.println("data:"+data.toString());
		String sql = "insert into license_fqa(question,answer,admin,date) values(?,?,?,?)";
		
		Object[][] params = new Object[data.size()][];
		
		for (int i = 0; i < data.size(); i++) 
		{    
			List temp = data.get(i);    
			params[i] = new Object[4];    
			params[i][0] = temp.get(0).toString();    
			params[i][1] = temp.get(1).toString();    
			params[i][2] = temp.get(2).toString();    
			params[i][3] = temp.get(3).toString();    
		}
		return this.setList(sql,params);
	}
}
