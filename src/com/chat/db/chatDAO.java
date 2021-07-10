package com.chat.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class chatDAO {
	
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
	
	public String getRoomId(int prod_num, String seller, String user_nick) {
		
		String result = null;
		
		try {
			conn = getConnection();
			sql = "SELECT chat_roomid FROM chat WHERE prod_num=? AND chat_seller=? AND chat_buyer=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, prod_num);
			pstmt.setString(2, seller);
			pstmt.setString(3, user_nick);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getString(1);
			} else {
				result = null;
			}
			
		} catch (Exception e) {
			System.out.println(e.toString());
			System.out.println("chatDAO.getRoomID() function error - KBH");
		} finally {
			closeDB();
		}
		
		return result;
	}
	
	public void createRoomId(int prod_num, String seller, String user_nick) {
		try {
			conn = getConnection();
			sql = "INSERT chat VALUES (?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, prod_num);
			pstmt.setString(2, seller);
			pstmt.setString(3, user_nick);
			pstmt.setString(4, prod_num + seller + user_nick);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println(e.toString());
			System.out.println("chatDAO.createRoomId() function error - KBH");
		} finally {
			closeDB();
		}
	}
	
	public ArrayList<chatDTO> getRoomList(String seller, int prod_num) {
		ArrayList<chatDTO> arrlist = null;
		chatDTO cdto = null;
		try {
			conn = getConnection();
			sql = "SELECT * FROM chat WHERE chat_seller=? AND prod_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, seller);
			pstmt.setInt(2, prod_num);
			rs = pstmt.executeQuery();
			
			
			arrlist = new ArrayList<chatDTO>();
			
			while(rs.next()) {
				
				cdto = new chatDTO();
				
				cdto.setProd_num(rs.getInt(1));
				cdto.setChat_seller(seller);
				cdto.setChat_buyer(rs.getString(3));
				cdto.setChat_roomid(rs.getString(4));
				
				arrlist.add(cdto);
				
			}
			
		} catch (Exception e) {
			System.out.println(e.toString());
			System.out.println("chatDAO.getRoomList() function error - KBH");
		} finally {
			closeDB();
		}
		
		
		return arrlist;
	}
	
	public void deleteRoomId(String roomId) {
		try {
			
			System.out.println("dao roomId: " + roomId);
			
			conn = getConnection();
			sql = "DELETE FROM chat WHERE chat_roomid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, roomId);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.toString());
			System.out.println("chatDAO.deleteRoomId() function error - KBH");
		} finally {
			closeDB();
		}
	}
}
