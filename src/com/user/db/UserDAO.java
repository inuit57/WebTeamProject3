
package com.user.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class UserDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = "";
	
	// 디비연결 필요정보 
	public Connection getConnection(){
		try {
			//Context 객체를 생성 
			Context initCTX  = new InitialContext();
			 
			DataSource ds =
			(DataSource)initCTX.lookup("java:comp/env/jdbc/MarketDB");
			
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		} catch (NamingException e) {
			e.printStackTrace();
		} 
		return conn ; 
	} //getConnection() end
	
	//DB close() 시작
	public void closeDB(){
		try {
			if(rs!=null) rs.close(); 
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close(); 
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void insertUser(UserDTO udto) {
		//회원가입 시 정보 DB INSERT
		try {
			conn = getConnection();
			
			sql = "INSERT INTO user(user_id,user_nickname,user_pw,user_joindate,user_coin,user_phone,user_address,user_address_plus,user_bankname,user_bankaccount,user_picture,user_auth,user_grade,user_use_yn) "
					+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, udto.getUser_id());
			pstmt.setString(2, udto.getUser_nickname());
			pstmt.setString(3, udto.getUser_pw());
			pstmt.setTimestamp(4, udto.getUser_joindate());
			pstmt.setInt(5, udto.getUser_coin());
			pstmt.setString(6, udto.getUser_phone());
			pstmt.setString(7, udto.getUser_address());
			pstmt.setString(8, udto.getUser_addressPlus());
			pstmt.setString(9, udto.getUser_bankName());
			pstmt.setString(10, udto.getUser_bankAccount());
			pstmt.setString(11, udto.getUser_picture());
			pstmt.setInt(12, udto.getUser_auth());
			pstmt.setInt(13, udto.getUser_grade());
			pstmt.setInt(14, udto.getUser_use_yn());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.toString());
			System.out.println("UserDAO insertUser() Function Error - KBH");
		} finally {
			closeDB();
		}
		
	}

}

