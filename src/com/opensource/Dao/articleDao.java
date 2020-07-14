package com.opensource.Dao;

import java.util.List;

import com.opensource.Domain.article;

public class articleDao extends BaseDao <article>
{
	public List<article> getPage(int offset, int pageSize) {
		return this.getList("SELECT * FROM article ORDER BY id ASC LIMIT ? OFFSET ?",  pageSize, offset);
	}
	
	public article getCount() {
		return this.getOne("select count(*) as count from article;");
	}
	
	public article getOne(int id) {
		article temp = this.getOne("SELECT * FROM article WHERE id=?", id);
		addCount(temp.getId(),temp.getClick());
		return this.getOne("SELECT * FROM article WHERE id=?", id);
	}
	
	public article addOne(article article) {
		String sql = "insert into article(title,content,introduction,admin,date) values(?,?,?,?,?)";
		Object params[] = {article.getTitle(),article.getContent(),article.getIntroduction(), article.getAdmin(),article.getDate()};
		System.out.println("articleDao");
		return this.setOne(sql,params);
	}
	
	public article alterOne(int id,article article) {
		String sql = "update article set title=?,content=?,introduction=?,admin=?,date=? where id=?";
		Object params[] = {article.getTitle(),article.getContent(),article.getIntroduction(), article.getAdmin(),article.getDate(),id};
		System.out.println("articleDao");
		return this.setOne(sql,params);
	}
	
	public article addCount(int id,int click) {
		click++;
		String sql = "update article set click=? where id=?";
		Object params[] = {click,id};
		System.out.println("articleDao");
		return this.setOne(sql,params);
	}
	
	public article deleteOne(int id) {
		String sql = "delete from article where id=?";
		Object params[] = {id};
		System.out.println("deleteOne-articleDao");
		return this.setOne(sql,params);
	}
	
	public List<article> addList(List<List> data) {
		System.out.println("data:"+data.toString());
		String sql = "insert into article(title,introduction,content,admin,date) values(?,?,?,?,?)";
		
		Object[][] params = new Object[data.size()][];
		
		for (int i = 0; i < data.size(); i++) 
		{    
			List temp = data.get(i);    
			params[i] = new Object[5];    
			params[i][0] = temp.get(0).toString();    
			params[i][1] = temp.get(1).toString();    
			params[i][2] = temp.get(2).toString();    
			params[i][3] = temp.get(3).toString();   
			params[i][4] = temp.get(4).toString(); 
		}
		return this.setList(sql,params);
	}
}
