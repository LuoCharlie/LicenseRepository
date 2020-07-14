package com.opensource.Domain;

import java.sql.Date;

public class article
{
	private int id;
	private String title;
	private String content;
	private Date date;
	private int click;
	private String admin;
	private int count;
	private String introduction;
	public String getIntroduction()
	{
		return introduction;
	}
	public void setIntroduction(String introduction)
	{
		this.introduction = introduction;
	}
	public int getCount()
	{
		return count;
	}
	public void setCount(int count)
	{
		this.count = count;
	}
	public int getId()
	{
		return id;
	}
	public void setId(int id)
	{
		this.id = id;
	}
	public String getTitle()
	{
		return title;
	}
	public void setTitle(String title)
	{
		this.title = title;
	}
	public String getContent()
	{
		return content;
	}
	public void setContent(String content)
	{
		this.content = content;
	}
	public Date getDate()
	{
		return date;
	}
	public void setDate(Date date)
	{
		this.date = date;
	}
	public int getClick()
	{
		return click;
	}
	public void setClick(int click)
	{
		this.click = click;
	}
	public String getAdmin()
	{
		return admin;
	}
	public void setAdmin(String admin)
	{
		this.admin = admin;
	}
}
