package com.auction.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
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
		int bidNum = 0;
		
		
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
		
		//-------
		try {
			
			conn = getConnection();
			
			sql = "select max(bid_num) from auct_bid";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bidNum = rs.getInt(1)+1;
			}
			
			//4번 유저코인 member user_coin
			sql = "insert into auct_bid "
					+ " value(?,?,0,0,now(),now(), "
					+ "?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bidNum);
			pstmt.setInt(2, num);
			pstmt.setInt(3, aDTO.getAuct_price());
		
			
			pstmt.executeUpdate();
			
		}catch(SQLException e) {
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
	
	//deleteAuction(num); 경매게시글 삭제하기
	public void deleteAuction(int num) {
		
			try {
				conn = getConnection();
				sql = "delete from prod_auct where auct_num=?";
				System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@삭제화이팅");
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				
				pstmt.executeUpdate();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				closeDB();
			}
		
	}//deleteAuction(num); 경매게시글 삭제하기
	
	//getAuctionUpdate(aDTO) 경매게시글 수정하기
	public void getAuctionUpdate(AuctionDTO aDTO) {
		
		try {
			conn = getConnection();
			
			//거래여부,글제목,상품가격,이미지,글내용 where auct_num
			sql = "update prod_auct set "
					+ "auct_status=?, auct_sub=?, auct_price=?, "
					+ "auct_img=?, auct_content=? "
					+ "where auct_num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, aDTO.getAuct_status());
			pstmt.setString(2, aDTO.getAuct_sub());
			pstmt.setInt(3, aDTO.getAuct_price());
			pstmt.setString(4, aDTO.getAuct_img());
			pstmt.setString(5, aDTO.getAuct_content());
			pstmt.setInt(6, aDTO.getAuct_num());

			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
	}//getAuctionUpdate(aDTO) 경매게시글 수정하기
	
	//경매 낙찰 완료 변경 메소드
		public void updateStatus(int auct_num, int status){
			
			try {
				
				conn = getConnection();
				sql = "update prod_auct set auct_status=? where auct_num=?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, status);
				pstmt.setInt(2, auct_num);
				
				pstmt.executeUpdate();
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				closeDB();
			}
			
		}//경매 낙찰 완료 변경 메소드
	
		public String timeForToday(int num){
			Timestamp now_t = new Timestamp(System.currentTimeMillis()); 
			Timestamp auct_t ; 
			long betweenTime  = 0L ; 
			
			String timeForToday =""; 
			
			System.out.println(now_t);
			
			try {
				conn = getConnection();
				sql = "select auct_date from prod_auct where auct_num=?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery(); 
				
				if(rs.next()){
					auct_t = rs.getTimestamp(1); 
					betweenTime = (long)Math.floor((now_t.getTime() - auct_t.getTime()) / 1000 / 60);
					long betweenTimeHour = (long)Math.floor(betweenTime / 60);
					long betweenTimeDay = (long)Math.floor(betweenTime / 60 / 24);
					
					if (betweenTime < 1) timeForToday = "방금전";
					else if (betweenTime < 60) {
			        	timeForToday = betweenTime +"분전";
					}else if (betweenTimeHour < 24) {
			        	timeForToday = betweenTimeHour+ "시간전";
			        }else if (betweenTimeDay < 365) {
			        	timeForToday = betweenTimeDay +"일전";
			        }else{
			        	timeForToday = (long)Math.floor(betweenTimeDay / 365)+"년전";
			        }
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				closeDB();
			} 
			
			return timeForToday; 
		}
	
	
}
