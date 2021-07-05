package com.auction.bid.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class bidDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = "";
	
	
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
	
	//bidCheck(num, user_nick) 입찰을 했는지 안했는지 확인하는 메소드
	public int bidCheck(int num, String user_nick) {
		
		int check = 0;
		
		try {
			
			conn = getConnection();
			
			sql = "select auct_num from auct_bid where auct_num=? and user_nick=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, user_nick);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) { 
				check = 1; //값이 있다
			}else {
				check = 0; //값이 없다
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return check;
	}//bidCheck(num, user_nick) 입찰을 했는지 안했는지 확인하는 메소드
	
	
	//insertBid(num, nick) 입찰 등록하기
	public void updateBid(int num, String user_nick, int bidprice) {
		
		bidDTO bDTO = new bidDTO();
		
		try {
			conn = getConnection();
			sql = "update auct_bid set "
					+ "auct_num=?, user_nick=?, "
					+ "bid_coin=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, user_nick);
			pstmt.setInt(3, bidprice);
			
			pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
	}//insertBid(num, nick) 입찰 등록하기
	
	
	//deleteBid(num, user_nick, bidprice) 입찰 삭제하기
	public void deleteBid(int num, String user_nick) {
		
		try {
			
			conn = getConnection();
			sql = "delete from auct_bid where auct_num=? and user_nick=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, user_nick);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
	}//deleteBid(num, user_nick, bidprice) 입찰 삭제하기
	
	
	//getMaxPrice(num, bidprice) 경매 최고가
	public int getMaxPrice(int num) {
			
		int maxPrice = 0;
		
		try {
			
			conn = getConnection();
			sql = "select max(bid_coin) from auct_bid where auct_num=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			
			if(rs.next()) {
				maxPrice = rs.getInt(1);
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return maxPrice;
	}//getMaxPrice(num, bidprice) 경매 최고가
	
	

}
