package com.opensource.Dao;

import java.util.ArrayList;
import java.util.List;
import com.opensource.Domain.featureLicense;

public class  featureDao extends BaseDao<featureLicense>
{
	public List<featureLicense> getList() {
		System.out.println("featureDao:getList");
		return this.getList("SELECT * FROM feature");
	}
	
	public List<featureLicense> searchByFeature(ArrayList <String>rights,ArrayList <String>obligation,ArrayList <String>prohibition) {
		System.out.println("featureDao:searchByFeature");
		String r = "%";
    	for(int i=0;i<rights.size();i++){
        	r = r + rights.get(i) + "%";
        }
    	System.out.println(r);
    	String o = "%";
    	for(int i=0;i<obligation.size();i++){
        	o = o + obligation.get(i) + "%";
        }
    	System.out.println(o);
    	String p = "%";
    	for(int i=0;i<prohibition.size();i++){
        	p = p + prohibition.get(i) + "%";
        }
    	String sql;
    	Object params[] = {r,o,p};
    	sql = " select * from licenses where `right` like ? and obligation like ? and prohibition like ?";      
		return this.getList(sql,params);
	}
}
