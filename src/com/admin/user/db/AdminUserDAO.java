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

import com.inquery.db.InqueryDTO;
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
  
//adminInqueryCount(sk,sv)
public int adminUserCount(String sk, String sv){
	
	int cnt = 0;
	

	try {
		// 1,2 드라이버로드, 디비연결
		conn = getConnection();
		
		// 3 sql 작성 & pstmt 객체 생성
		sql = "select count(*) from member where "+sk+" like '%"+sv+"%'";
		pstmt = conn.prepareStatement(sql);

		
		// 4 sql 실행			
		rs = pstmt.executeQuery();
		
		// 5 데이터 처리
		if(rs.next()){
			cnt = rs.getInt(1);
			//cnt = rs.getInt("count(*)");
		}
		System.out.println("SQL 구문 실행완료! ");
		System.out.println("글 개수 : "+cnt+"개");
		
	} catch (Exception e) {
		System.out.println(" 게시판 글 개수_에러 발생! ");
		e.printStackTrace();
	} finally{
		// 자원 해제
		closeDB();
	}
	
			
	return cnt;
}// adminInqueryCount(sk,sv)
    
  
  
    
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
    		
    		if(auth==1){
    			SQL.append(" where user_auth=1 limit ?,?");
    		}else{
    			SQL.append(" where user_auth=2 limit ?,?");
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
    
 // userSearchList(sk,sv,starRow,pageSize)
    public List userSearchList(String sk,String sv,int startRow,int pageSize){
    	
    List auList = new ArrayList();
    UserDTO uDTO = new UserDTO();
    try {
    	conn = getConnection();
    	
    	sql = "select * from member where "+sk+" like '%"+sv+"%' ";
    	
    	sql+= " limit ?,?";
    	
    	
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
			
			auList.add(uDTO);
		}
		System.out.println("검색 완료!@@@@@@@@@@");
		
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		closeDB();
	}
    
    return auList;
    	
    }// userSearchList(sk,sv,startRow,pageSize)
    
    // activateUser(user_nickname)
    public void activateUser(String user_nick){
    	
    	try {
    		conn = getConnection();
    		
    		
    		sql = "update member set user_use_yn=case  "
    				+ "when user_use_yn=1 then 2 "
    				+ "when user_use_yn=2 then 1 end"
    				+ " where user_nickname=?";
    			
    		
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, user_nick);
			
			
			pstmt.executeUpdate();
			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
    	System.out.println("유저 "+user_nick+" 회원  활성화상태 변경 완료");
    	
    }// activateUser(user_nickname)
    
    // changeUserGrade(user_grade)
    public void changeUserGrade(int user_grade,String user_nickname){
    	
    	try {
    		conn = getConnection();
    		
    		sql = "update member set user_grade=? where user_nickname=?";
    		
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, user_grade);
			pstmt.setString(2, user_nickname);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}

    	
    	
    }// changeUserGrade(user_grade)
    
    
    
    
}
