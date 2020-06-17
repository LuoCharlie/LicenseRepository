package com.opensource.Dao;

import java.util.List;
import com.opensource.Domain.fqa;

public class fqaDao extends BaseDao<fqa>
{
	public List<fqa> getPage(int offset, int pageSize) {
		return this.getList("SELECT * FROM testfqa ORDER BY id ASC LIMIT ? OFFSET ?",  pageSize, offset);
	}
	
	public fqa getCount() {
		return this.getOne("select count(*) as count from testfqa;");
	}
	
	public fqa addOne(fqa fqa) {
		String sql = "insert into testfqa(question,answer,admin,date) values(?,?,?,?)";
		Object params[] = {fqa.getQuestion(),fqa.getAnswer(), fqa.getAdmin(),fqa.getDate()};
		System.out.println("fqaDao");
		return this.setOne(sql,params);
	}
	
	public fqa alterOne(fqa fqa) {
		String sql = "update testfqa set question=?,answer=?,admin=?,date=? where question=?";
		Object params[] = {fqa.getQuestion(),fqa.getAnswer(), fqa.getAdmin(),fqa.getDate(),fqa.getQuestion()};
		System.out.println("fqaDao");
		return this.setOne(sql,params);
	}
	
	public fqa deleteOne(String question) {
		String sql = "delete from testfqa where question=?";
		Object params[] = {question};
		System.out.println("fqaDao");
		return this.setOne(sql,params);
	}
}
