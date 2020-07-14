package com.opensource.Dao;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBUtil
{
	private static DataSource dataSource = null;
	private static Connection conn = null;  
	static {
		try {
			Context ctx = new InitialContext();
			Context dbCtx = (Context) ctx.lookup("java:/comp/env");
			dataSource = (DataSource) dbCtx.lookup("jdbc/MyDB"); 
		} catch(Exception ex) {
			ex.printStackTrace();
		}
	}
	
	public static Connection getConnection() throws SQLException {
		conn = dataSource.getConnection();
		return conn;
	}
	
	public static DataSource getDataSource() {
		return dataSource;
	}
	 public void close() throws Exception{  
	        if(conn!=null){  
	            conn.close();  
	        }  
	 }  
}
