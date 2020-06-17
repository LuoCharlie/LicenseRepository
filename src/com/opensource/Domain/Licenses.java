package com.opensource.Domain;

public class Licenses
{
	private String id;
	private String name;
	private String abbreviation;
	private String abstractName;
	private String right;
	private String obligation;
	private String prohibition;
	private String owner;
	private String history;
	private String origation;
	private String translation;
	private int type;
	private String originURL;
	private String SPDX;
	private int admin;
	public String getId()
	{
		return id;
	}
	public void setId(String id)
	{
		this.id = id;
	}
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
	public String getHistory()
	{
		return history;
	}
	public void setHistory(String history)
	{
		this.history = history;
	}
	public String getOrigation()
	{
		return origation;
	}
	public void setOrigation(String origation)
	{
		this.origation = origation;
	}
	public String getTranslation()
	{
		return translation;
	}
	public void setTranslation(String translation)
	{
		this.translation = translation;
	}
	public int getType()
	{
		return type;
	}
	public void setType(int type)
	{
		this.type = type;
	}
	public String getOriginURL()
	{
		return originURL;
	}
	public void setOriginURL(String originURL)
	{
		this.originURL = originURL;
	}
	public String getSPDX()
	{
		return SPDX;
	}
	public void setSPDX(String sPDX)
	{
		SPDX = sPDX;
	}
	public int getAdmin()
	{
		return admin;
	}
	public void setAdmin(int admin)
	{
		this.admin = admin;
	}
	public String toString(){
		String temp = "name:"+name
					+",  abbreviation:"+abbreviation
					+",  abstractName:"+abstractName
					+",  right:"+right
					+",  obligation:"+obligation
					+",  prohibition: "+prohibition
					+",  owner:"+owner
					+",  history:"+history
					+",  origation:"+origation
					+",  type:"+type
					+",  translation:"+translation
					+",  originURL:"+originURL
					+",  SPDX:"+SPDX
					+",  admin:"+admin;

        return temp;
    }
}
