package com.auction.db;

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

public class AuctionDAO {

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
	
	//insertAuction(aDTO) 경매게시판 상품 글 등록하기
	public void insertAuction(AuctionDTO aDTO) {
		
		int num = 0;
		
		try {
			
			conn = getConnection();
			sql = "select max(auct_num) from prod_auct";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				num = rs.getInt(1)+1;
			}
			
			sql = "insert into prod_auct "
					+ "values(?,?,?,?,?,?,?,now(),?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, aDTO.getUser_nick());
			pstmt.setInt(3, aDTO.getAuct_status());
			pstmt.setString(4, aDTO.getAuct_sub());
			pstmt.setString(5, aDTO.getAuct_content());
			pstmt.setInt(6, aDTO.getAuct_price());
			pstmt.setString(7, aDTO.getAuct_img());
			pstmt.setString(8, aDTO.getAuct_ip());
			pstmt.setInt(9, aDTO.getAuct_count());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
	}//insertAuction(aDTO) 경매게시판 상품 글 등록하기
	
	
	//getAuctionList(auc) 경매게시판 리스트 가져오기 (경매상태)
	public List getAuctionList(String auc) {
		
		List AuctionList = new ArrayList();
		
		try {
			conn = getConnection();
			
			if(auc.equals("all")) {
				sql = "select * from prod_auct order by auct_num desc";
			}else {
				sql = "select * from prod_auct where auct_status=? order by auct_num desc";
			}
			
			pstmt = conn.prepareStatement(sql);
			
			if(! auc.equals("all")) {
				pstmt.setString(1, auc);
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				AuctionDTO aDTO = new AuctionDTO();
				
				aDTO.setAuct_content(rs.getString("auct_content"));
				aDTO.setAuct_count(rs.getInt("auct_count"));
				aDTO.setAuct_date(rs.getTimestamp("auct_date"));
				aDTO.setAuct_img(rs.getString("auct_img"));
				aDTO.setAuct_ip(rs.getString("auct_ip"));
				aDTO.setAuct_num(rs.getInt("auct_num"));
				aDTO.setAuct_price(rs.getInt("auct_price"));
				aDTO.setAuct_status(rs.getInt("auct_status"));
				aDTO.setAuct_sub(rs.getString("auct_sub"));
				aDTO.setUser_nick(rs.getString("user_nick"));
				
				AuctionList.add(aDTO);
				
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return AuctionList;
	}//getAuctionList(auc) 경매게시판 리스트 가져오기 (경매상태)
	
	
	//getAuctionList(num) 경매 상품 정보가져오기 (디테일)
	public AuctionDTO getAuction(int num) {
		
		AuctionDTO aDTO = null;
		
		try {
			
			conn = getConnection();
			sql = "select * from prod_auct where auct_num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				aDTO = new AuctionDTO();
				
				aDTO.setAuct_content(rs.getString("auct_content"));
				aDTO.setAuct_count(rs.getInt("auct_count"));
				aDTO.setAuct_date(rs.getTimestamp("auct_date"));
				aDTO.setAuct_img(rs.getString("auct_img"));
				aDTO.setAuct_ip(rs.getString("auct_ip"));
				aDTO.setAuct_num(rs.getInt("auct_num"));
				aDTO.setAuct_price(rs.getInt("auct_price"));
				aDTO.setAuct_status(rs.getInt("auct_status"));
				aDTO.setAuct_sub(rs.getString("auct_sub"));
				aDTO.setUser_nick(rs.getString("user_nick"));
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return aDTO;
	}//getAuctionList(num) 경매 상품 정보가져오기 (디테일)
	
	
	//updateCount(aDTO) 조회수 
	public void updateCount(int num) {
		
		try {
			
			conn = getConnection();
			sql = "update prod_auct set auct_count=auct_count+1 where auct_num=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);

			pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
	}//updateCount(aDTO) 조회수 
	
	
	
	
	
	
	
	
	
	
	
}