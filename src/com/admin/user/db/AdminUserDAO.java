package com.admin.user.db;

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

import com.user.db.UserDTO;


public class AdminUserDAO {
	

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = "";
	
	
	private Connection getConnection(){
    	
    	try {
    		// Context 객체를 생성 (프로젝트 정보를 가지고있는 객체)
			Context initCTX = new InitialContext();
			
			// DB연동 정보를 불러오기(context.xml)
			DataSource ds = 
			(DataSource) initCTX.lookup("java:comp/env/jdbc/MarketDB");
			
			conn = ds.getConnection();
			
			System.out.println(" 드라이버 로드, 디비연결 성공!");
			System.out.println(conn);
			
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	
    	return conn;
    }
    
    // 자원해제코드 - finally 구문에서 사용
    public void closeDB(){
    	try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }
    
    
    public List getAdminUserList(){
    	List auList = new ArrayList();
    	
    	try {
    		
    		conn = getConnection();
    		
    		sql = "select * from member";
    		
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				UserDTO uDTO = new UserDTO();
				uDTO.setUser_num(rs.getInt("user_num"));
				uDTO.setUser_id(rs.getString("user_id"));
				uDTO.setUser_nickname(rs.getString("user_nickname"));
				uDTO.setUser_pw(rs.getString("user_pw"));
				uDTO.setUser_joindate(rs.getTimestamp("user_joindate"));
				uDTO.setUser_coin(rs.getInt("user_coin"));
				uDTO.setUser_phone(rs.getString("user_phone"));
				uDTO.setUser_address(rs.getString("user_address"));
				uDTO.setUser_addressPlus(rs.getString("user_address_plus"));
				uDTO.setUser_bankName(rs.getString("user_bankname"));
				uDTO.setUser_bankAccount(rs.getString("user_bankaccount"));
				uDTO.setUser_picture(rs.getString("user_picture"));
				uDTO.setUser_auth(rs.getInt("user_auth"));
				uDTO.setUser_grade(rs.getInt("user_grade"));
				uDTO.setUser_use_yn(rs.getInt("user_use_yn"));
				
				auList.add(uDTO);
			
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	

    	return auList;
    }
    
    
    // getAdminUserList(auth)
    public List getAdminUserList(int auth){
    	
    		List auList = new ArrayList();
    	
    	try {
    		
    		conn = getConnection();
    		
    		sql = "select * from member where user_auth=?";
    		
    	
    		
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, auth);
			
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				UserDTO uDTO = new UserDTO();
				uDTO.setUser_num(rs.getInt("user_num"));
				uDTO.setUser_id(rs.getString("user_id"));
				uDTO.setUser_nickname(rs.getString("user_nickname"));
				uDTO.setUser_pw(rs.getString("user_pw"));
				uDTO.setUser_joindate(rs.getTimestamp("user_joindate"));
				uDTO.setUser_coin(rs.getInt("user_coin"));
				uDTO.setUser_phone(rs.getString("user_phone"));
				uDTO.setUser_address(rs.getString("user_address"));
				uDTO.setUser_addressPlus(rs.getString("user_address_plus"));
				uDTO.setUser_bankName(rs.getString("user_bankname"));
				uDTO.setUser_bankAccount(rs.getString("user_bankaccount"));
				uDTO.setUser_picture(rs.getString("user_picture"));
				uDTO.setUser_auth(rs.getInt("user_auth"));
				uDTO.setUser_grade(rs.getInt("user_grade"));
				uDTO.setUser_use_yn(rs.getInt("user_use_yn"));
				
				auList.add(uDTO);
			
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
 	
    	return auList;
    }// getAdminUserList(auth)
    
    // adminUserCount()
    public int adminUserCount() {
    	
    	int cnt = 0;
    	
    	try {
			
    		conn = getConnection();
    		
    		sql = "select count(*) from member";
    		
    		pstmt = conn.prepareStatement(sql);
    		
    		rs = pstmt.executeQuery();
    		
    		if(rs.next()) {
    			cnt = rs.getInt(1);
    		}
    		
    		System.out.println("SQL 구문 실행완료! ");
			System.out.println("회원 수  : "+cnt+"개");
    		
    		
		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			closeDB();
		}
    	
    	
    	
    	return cnt;
    }// adminUserCount()
    
    // adminUserCount(auth)
  public int adminUserCount(int auth) {
    	
    	int cnt = 0;
    	
    	try {
			
    		conn = getConnection();
    		
    		sql = "select count(*) from member where user_auth=?";
    		
    		pstmt = conn.prepareStatement(sql);
    		
    		pstmt.setInt(1, auth);
    		
    		rs = pstmt.executeQuery();
    		
    		if(rs.next()) {
    			cnt = rs.getInt(1);
    		}
    		
    		System.out.println("SQL 구문 실행완료! ");
			System.out.println("회원 수  : "+cnt+"개");
    		
    		
		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			closeDB();
		}
    	
    	
    	
    	return cnt;
    }
    // adminUserCount(auth)
    
    
    
    // getAdminUserList(startRow,pageSize)
    public List getAdminUserList(int startRow,int pageSize) {
    	
    	ArrayList usList = new ArrayList();
    	
    	UserDTO uDTO;
    	
    	
    	try {
    		conn = getConnection();
    		
    		sql = "select * from member limit ?,?";
    		
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				uDTO = new UserDTO();
				uDTO.setUser_num(rs.getInt("user_num"));
				uDTO.setUser_id(rs.getString("user_id"));
				uDTO.setUser_nickname(rs.getString("user_nickname"));
				uDTO.setUser_pw(rs.getString("user_pw"));
				uDTO.setUser_joindate(rs.getTimestamp("user_joindate"));
				uDTO.setUser_coin(rs.getInt("user_coin"));
				uDTO.setUser_phone(rs.getString("user_phone"));
				uDTO.setUser_address(rs.getString("user_address"));
				uDTO.setUser_addressPlus(rs.getString("user_address_plus"));
				uDTO.setUser_bankName(rs.getString("user_bankname"));
				uDTO.setUser_bankAccount(rs.getString("user_bankaccount"));
				uDTO.setUser_picture(rs.getString("user_picture"));
				uDTO.setUser_auth(rs.getInt("user_auth"));
				uDTO.setUser_grade(rs.getInt("user_grade"));
				uDTO.setUser_use_yn(rs.getInt("user_use_yn"));
				
				usList.add(uDTO);
			
			}	
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    	return usList;
    }// getAdminUserList(startRow,pageSize)
    
    // getAdminUserList(auth,startRow,pageSize);
    public List getAdminUserList(int auth,int startRow,int pageSize) {
    	
    	List usList = new ArrayList();
    	
    	StringBuffer SQL = new StringBuffer();
    	
    	try {
    		conn = getConnection();
    		
    		SQL.append("select * from member");
    		
    		if(auth==0){
    			SQL.append(" where user_auth=0 limit ?,?");
    			System.out.println("@@@@@@@@@@@check000000000");
    		}else{
    			SQL.append(" where user_auth=1 limit ?,?");
    			System.out.println("@@@@@@@@@@@@@@check111111111111");
    		}
    		
  	
			pstmt = conn.prepareStatement(SQL+"");
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				UserDTO uDTO = new UserDTO();
				uDTO.setUser_num(rs.getInt("user_num"));
				uDTO.setUser_id(rs.getString("user_id"));
				uDTO.setUser_nickname(rs.getString("user_nickname"));
				uDTO.setUser_pw(rs.getString("user_pw"));
				uDTO.setUser_joindate(rs.getTimestamp("user_joindate"));
				uDTO.setUser_coin(rs.getInt("user_coin"));
				uDTO.setUser_phone(rs.getString("user_phone"));
				uDTO.setUser_address(rs.getString("user_address"));
				uDTO.setUser_addressPlus(rs.getString("user_address_plus"));
				uDTO.setUser_bankName(rs.getString("user_bankname"));
				uDTO.setUser_bankAccount(rs.getString("user_bankaccount"));
				uDTO.setUser_picture(rs.getString("user_picture"));
				uDTO.setUser_auth(rs.getInt("user_auth"));
				uDTO.setUser_grade(rs.getInt("user_grade"));
				uDTO.setUser_use_yn(rs.getInt("user_use_yn"));
				
				usList.add(uDTO);
			
			}	
			
			
			
	    	} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}
    	
    	return usList;
    }// getAdminUserList(auth,startRow,pageSize);
    
}
