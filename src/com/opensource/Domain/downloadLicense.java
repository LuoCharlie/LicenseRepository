package com.opensource.Domain;

public class downloadLicense
{
	private String name;
	private String abbreviation;
	private String type;
	private String abstractName;
	private String right;
	public String getName()
	{
		return name;
	}
	public void setName(String name)
	{
		this.name = name;
	}
	public String getAbbreviation()
	{
		return abbreviation;
	}
	public void setAbbreviation(String abbreviation)
	{
		this.abbreviation = abbreviation;
	}
	public String getType()
	{
		return type;
	}
	public void setType(String type)
	{
		this.type = type;
	}
	public String getAbstractName()
	{
		return abstractName;
	}
	public void setAbstractName(String abstractName)
	{
		this.abstractName = abstractName;
	}
	public String getRight()
	{
		return right;
	}
	public void setRight(String right)
	{
		this.right = right;
	}
	public String getObligation()
	{
		return obligation;
	}
	public void setObligation(String obligation)
	{
		this.obligation = obligation;
	}
	public String getProhibition()
	{
		return prohibition;
	}
	public void setProhibition(String prohibition)
	{
		this.prohibition = prohibition;
	}
	public String getOwner()
	{
		return owner;
	}
	public void setOwner(String owner)
	{
		this.owner = owner;
	}
	public String getOriginURL()
	{
		return originURL;
	}
	public void setOriginURL(String originURL)
	{
		this.originURL = originURL;
	}
	private String obligation;
	private String prohibition;
	private String owner;
	private String originURL;
}
