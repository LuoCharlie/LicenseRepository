package com.opensource.Dao;

import java.text.Collator;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import com.opensource.Domain.Licenses;

public class LicensesDao extends BaseDao<Licenses>
{
	private static Comparator<Object> comparator=Collator.getInstance(java.util.Locale.CHINA); 
	public Licenses addOne(Licenses Licenses) {
		String sql = "insert into licenses(`name`,abbreviation,abstract,`right`,obligation,"
				+ "prohibition,owner,history,origation,translation,`type`,originURL,SPDX,admin) "
				+ "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		String r[]  = ((String) Licenses.getRight()).split("-");
        String o[]  = ((String) Licenses.getObligation()).split("-");
        String p[]  = ((String) Licenses.getProhibition()).split("-");
        String listr = "";
        String listo = "";
        String listp = "";
		ArrayList <String> right = new ArrayList<String>();
        for(int j=0;j<r.length;j++){
        	right.add(r[j]);
        }
        Collections.sort(right,comparator);
        for(int j=0;j<right.size()-1;j++){
        	listr += right.get(j)+",";
        }
        listr += right.get(right.size()-1);
        ArrayList <String> obligation = new ArrayList<String>();
        for(int j=0;j<o.length;j++){
        	obligation.add(o[j]);
        }
        Collections.sort(obligation,comparator);
        for(int j=0;j<obligation.size()-1;j++){
        	listo += obligation.get(j)+",";
        }
        listo += obligation.get(obligation.size()-1);
        ArrayList <String> prohibition = new ArrayList<String>();
        for(int j=0;j<p.length;j++){
        	prohibition.add(p[j]);
        }
        Collections.sort(prohibition,comparator);
        for(int j=0;j<prohibition.size()-1;j++){
        	listp += prohibition.get(j)+",";
        }
		Object params[] = {
				Licenses.getName(),
				Licenses.getAbbreviation(), 
				Licenses.getAbstractName(),
				listr,
				listo,
				listp,
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
		String sql = "update licenses set `name`=?,abbreviation=?,abstract=?,`right`=?,"
				+ "obligation=?,prohibition=?,owner=?,history=?,origation=?,translation=?,"
				+ "`type`=?,originURL=?,SPDX=?,admin=? where `name`=?;";
		String r[]  = ((String) Licenses.getRight()).split("-");
        String o[]  = ((String) Licenses.getObligation()).split("-");
        String p[]  = ((String) Licenses.getProhibition()).split("-");
        String listr = "";
        String listo = "";
        String listp = "";
		ArrayList <String> right = new ArrayList<String>();
        for(int j=0;j<r.length;j++){
        	right.add(r[j]);
        }
        Collections.sort(right,comparator);
        for(int j=0;j<right.size()-1;j++){
        	listr += right.get(j)+",";
        }
        listr += right.get(right.size()-1);
        ArrayList <String> obligation = new ArrayList<String>();
        for(int j=0;j<o.length;j++){
        	obligation.add(o[j]);
        }
        Collections.sort(obligation,comparator);
        for(int j=0;j<obligation.size()-1;j++){
        	listo += obligation.get(j)+",";
        }
        listo += obligation.get(obligation.size()-1);
        ArrayList <String> prohibition = new ArrayList<String>();
        for(int j=0;j<p.length;j++){
        	prohibition.add(p[j]);
        }
        Collections.sort(prohibition,comparator);
        for(int j=0;j<prohibition.size()-1;j++){
        	listp += prohibition.get(j)+",";
        }
		System.out.println(sql);
		Object params[] = {
			Licenses.getName(),
			Licenses.getAbbreviation(), 
			Licenses.getAbstractName(),
			listr,
			listo,
			listp,
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
		String sql = "delete from licenses where name=?";
		Object params[] = {name};
		System.out.println("LicensesDao");
		return this.setOne(sql,params);
	}
	
	public  List<Licenses> addList(List<List> data)
	{
		System.out.println("data:"+data.toString());
		String sql = "insert into licenses(`name`,abbreviation,abstract,`right`,obligation,"
				+ "prohibition,owner,history,origation,translation,`type`,originURL,SPDX,admin) "
				+ "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		
		Object[][] params = new Object[data.size()][14];
		for (int i = 0; i < data.size(); i++) 
		{    
			List temp = data.get(i);    
			params[i] = new Object[14];    
			params[i][0] = temp.get(0);    
			params[i][1] = temp.get(1);    
			params[i][2] = temp.get(2);
			String r[]  = ((String) temp.get(3)).split("-");
	        String o[]  = ((String) temp.get(4)).split("-");
	        String p[]  = ((String) temp.get(5)).split("-");
	        String listr = "";
	        String listo = "";
	        String listp = "";
			ArrayList <String> right = new ArrayList<String>();
	        for(int j=0;j<r.length;j++){
	        	right.add(r[j]);
	        }
	        Collections.sort(right,comparator);
	        for(int j=0;j<right.size()-1;j++){
	        	listr += right.get(j)+",";
	        }
	        listr += right.get(right.size()-1);
	        ArrayList <String> obligation = new ArrayList<String>();
	        for(int j=0;j<o.length;j++){
	        	obligation.add(o[j]);
	        }
	        Collections.sort(obligation,comparator);
	        for(int j=0;j<obligation.size()-1;j++){
	        	listo += obligation.get(j)+",";
	        }
	        listo += obligation.get(obligation.size()-1);
	        ArrayList <String> prohibition = new ArrayList<String>();
	        for(int j=0;j<p.length;j++){
	        	prohibition.add(p[j]);
	        }
	        Collections.sort(prohibition,comparator);
	        for(int j=0;j<prohibition.size()-1;j++){
	        	listp += prohibition.get(j)+",";
	        }
	        listp += prohibition.get(prohibition.size()-1);
			params[i][3] = listr; 
			params[i][4] = listo; 
			params[i][5] = listp; 
			params[i][6] = temp.get(6); 
			params[i][7] = temp.get(7); 
			params[i][8] = temp.get(8);
			params[i][9] = temp.get(9); 
			params[i][10] = temp.get(10); 
			params[i][11] = temp.get(11); 
			params[i][12] = temp.get(12);
			params[i][13] = temp.get(13);
		}
		return this.setList(sql,params);
	}

}
