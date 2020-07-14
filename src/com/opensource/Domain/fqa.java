package com.opensource.Domain;

import java.sql.Date;

public class fqa
{	
	private int count;
	public int getCount()
	{
		return count;
	}
	public void setCount(int count)
	{
		this.count = count;
	}
	private int id;
	public int getId()
	{
		return id;
	}
	public void setId(int id)
	{
		this.id = id;
	}
	public String getAdmin()
	{
		return admin;
	}
	public void setAdmin(String admin)
	{
		this.admin = admin;
	}
	private String question;
	private String answer;
	private Date date;
	private String admin;
	public String getQuestion()
	{
		return question;
	}
	public void setQuestion(String question)
	{
		this.question = question;
	}
	public String getAnswer()
	{
		return answer;
	}
	public void setAnswer(String answer)
	{
		this.answer = answer;
	}
	public Date getDate()
	{
		return date;
	}
	public void setDate(Date date)
	{
		this.date = date;
	}
	
}
