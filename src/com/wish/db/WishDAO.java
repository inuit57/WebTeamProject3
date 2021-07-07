package com.wish.db;

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

public class WishDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = "";
	private boolean ture;
	
	
	private Connection getConnection(){
		try {
			//Context 객체를 생성 (프로젝트 정보를 가지고있는객체)
			Context initCTX = new InitialContext();
			// DB연동 정보를 불러오기(context.xml)
			DataSource ds =
			(DataSource) initCTX.lookup("java:comp/env/jdbc/MarketDB");
			
			conn = ds.getConnection();
			
			System.out.println(" 드라이버 로드, 디비연결 성공! ");
			System.out.println(conn);
			
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return conn;
	}
	// getConnection() - 디비연결 끝
	
	// 자원해제코드 - finally 구문에서 사용
	public void closeDB(){
		try {
			if(rs != null){ rs.close(); }
			if(pstmt != null){ pstmt.close();}
			if(conn != null){ conn.close();}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	//좋아요 눌렀는지 안눌렀는지 체크 메소드 favoriteCheck(int num, String nick)
	public int favoriteCheck(int num, String nick) {
			
		int check = 0;
		
		try {
			
			conn = getConnection();
			//sql = "select prod_num from prod_wish where prod_num="+num+" and user_nick='"+nick+"'";
			sql = "select prod_num from prod_wish where prod_num=? and user_nick=?";
			pstmt = conn.prepareStatement(sql);
			
		    
			pstmt.setInt(1, num);
			pstmt.setString(2, nick);
			
			rs = pstmt.executeQuery();
			System.out.println(pstmt);
			
			if(rs.next()) {
				System.out.println("값이 있습니다만.....");
				check = 1;
				System.out.println("DAO: " +check);
				
				
			}else {
				check = 0;
				System.out.println("DAO: " +check);
			}
			
			System.out.println("데이터 검색완료");
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return check;
	}//좋아요 눌렀는지 안눌렀는지 체크 메소드
	
	
	//favoriteDelete()
	public void favoriteDelete(int num, String nick) {
		
		try {
			conn = getConnection();
			sql = "delete from prod_wish where prod_num=? and user_nick=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, nick);
			
			pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
	}//favoriteDelete()
	
	/**
	 *  
	 *  특정 상품을 삭제하였을 경우, 모든 찜목록에서 해당 상품 삭제 
	 *  
	 * @param prod_num : 상품 번호 
	 */
	public void favoriteDelete(int prod_num) {
		
		try {
			conn = getConnection();
			sql = "delete from prod_wish where prod_num=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, prod_num);
			
			pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
	}//favoriteDelete()
	
	//favoriteInsert() 
	public void favoriteInsert(int num, String nick) {
		
		int favInsert = 0;
		
		
		try {
			conn = getConnection();
			
			sql = "select max(wish_num) from prod_wish";
			pstmt = conn.prepareStatement(sql);
			
			rs =  pstmt.executeQuery();
			
			if(rs.next()) {
				favInsert = rs.getInt(1)+1;
			}
			
			sql = "insert into prod_wish(wish_num,prod_num, user_nick,wish_date) "
					+ "values(?,?,?,now())";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, favInsert);
			pstmt.setInt(2, num);
			pstmt.setString(3, nick);
			
			pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
	}//favoriteInsert() 

	
	//wishCount(num) 찜 횟수 계산
	public int wishCount(int num) {
		int wishCount = 0;
		
		try {
			
			conn = getConnection();
			
			sql = "select count(prod_num) from prod_wish where prod_num=?";
			
			pstmt =conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				wishCount = rs.getInt(1);
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return wishCount;
		
	}//wishCount(num) 찜 횟수 계산
	
	//wishList() 찜 목록 가져오기
	public List<WishDTO> wishList(String user_nick) {
		
		List<WishDTO> wishList = new ArrayList();
		
		try {
			
			conn = getConnection();
			
			sql = "select * from prod_wish where user_nick=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_nick);
			
			rs = pstmt.executeQuery(); 
			
			while(rs.next()) {
				WishDTO wDTO = new WishDTO();
				wDTO.setProd_num(rs.getInt("prod_num"));
				wDTO.setUser_nickname(rs.getString("user_nick"));
				wDTO.setWish_date(rs.getTimestamp("wish_date"));
				wDTO.setWish_num(rs.getInt("wish_num"));
				
				wishList.add(wDTO);
			}
			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return wishList;
		
	}//wishList() 찜 목록 가져오기
	
	
	
	
	
	// 해당 상품을 찜한 사람 List 가져오기 
	public List<String> getWishMembers(int prod_num){
		List<String> memberList = new ArrayList<>(); 
		
		try {
			conn = getConnection(); 
			
			sql = "select user_nick from prod_wish where prod_num = ? "; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, prod_num);
			rs = pstmt.executeQuery(); 
			
			while(rs.next()){
				memberList.add(rs.getString(1)); 
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return memberList; 
	} // public List<String> getWishMembers(int prod_num){
	
}
