
package com.user.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
			
			sql = "INSERT INTO user(id,nickname,pw,joindate,coin,phone,address,address_plus,bankname,bankaccount,picture,auth,grade,use_yn) "
					+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, udto.getId());
			pstmt.setString(2, udto.getNickname());
			pstmt.setString(3, udto.getPw());
			pstmt.setTimestamp(4, udto.getJoindate());
			pstmt.setInt(5, udto.getCoin());
			pstmt.setString(6, udto.getPhone());
			pstmt.setString(7, udto.getAddress());
			pstmt.setString(8, udto.getAddressPlus());
			pstmt.setString(9, udto.getBankName());
			pstmt.setString(10, udto.getBankAccount());
			pstmt.setString(11, udto.getPicture());
			pstmt.setInt(12, udto.getAuth());
			pstmt.setInt(13, udto.getGrade());
			pstmt.setInt(14, udto.getUse_yn());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.toString());
			System.out.println("UserDAO insertUser() Function Error - KBH");
		} finally {
			closeDB();
		}
		
	}

}

