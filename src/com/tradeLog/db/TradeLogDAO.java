package com.tradeLog.db;

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

public class TradeLogDAO {
	
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
	
	// 생각해볼 것. 
	// trade_user (== buyer) 
	// trade_target(== seller)   
	
	
	// 충전시 동작하는 함수 
	// buyer (session에 저장된 user_nick)  
	// coin :  충전 금액을 기록  + member의 coin을 증가
	// type = 0 
	
	/**
	 * 충전 시 동작하는 함수
	 * 
	 * type : 0 
	 * 
	 * @param user_nick  : session에 저장된 유저명. 
	 * @param coin : 증가시켜주는 코인량 
	 */
	public void chargeLog(String user_nick, int coin){
		try {
			conn = getConnection(); 
			sql = "insert into trade_log(trade_user, trade_coin , trade_type, trade_date) "
					+ " values(?, ?, 0 , now() ) "; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_nick);
			pstmt.setInt(2, coin);
			
			pstmt.executeUpdate(); 
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		} 
	}
	
	/**
	 * 
	 * 유저 이름을 받아서 해당 유저의 결제 내역 출력
	 * 
	 * @param user_nick : 결제 내역을 가져올 유저 이름
	 * @return 해당 유저의 모든 결제 내역 
	 */
	public List<TradeLogDTO> getLogList(String user_nick){
		List<TradeLogDTO> tradeLogList = new ArrayList<TradeLogDTO>(); 
		
		try {
			conn = getConnection(); 
			sql = "select * from trade_log where trade_user = ?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_nick);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				TradeLogDTO tldto = new TradeLogDTO(); 
				tldto.setTrade_coin(rs.getInt("trade_coin"));
				tldto.setTrade_date(rs.getTimestamp("trade_date"));
				tldto.setTrade_no(rs.getInt("trade_no"));
				tldto.setTrade_target(rs.getString("trade_target"));
				tldto.setTrade_type(rs.getInt("trade_type"));
				//tldto.setTrade_user(rs.getString("trade_user"));
				
				tradeLogList.add(tldto); 
				System.out.println("코인 : " + tldto.getTrade_coin());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		} 
		
		return tradeLogList; 
	}
	
	
	// 금액을 걸어놓을 때 동작하는 함수 
	// buyer(구매자명 = 본인?)
	// seller (판매자명) 
	// coin :  구매 시 지불하는 금액을 기록  + 지불된 금액만큼 member 의 coin을 차감.  
	// type = 1  ( 1이라면 -로 표기해줄 것) 
	// prod_num : 상품 글의 번호 ( 같은 판매자의 여러 상품들 중 하나를 구분하기 위함) 
	// 참고 : 이 시점에서 판매자에게 금액이 지불되는 것은 아니다. 이후 동작에서 처리된다. 
	
	
	// 금액을 실제로 지불할 때 동작하는 함수 
	// buyer (구매자명)
	// seller (판매자명 = 본인) 
	// coin : 구매시 지불되는 금액 + member 테이블의 coin 업데이트
	// type = 2 ( 2라면 +로 표기해줄 것) 
	// prod_num : 상품 글의 번호 
	// 참고 : 동명의 테이블을 조회해서 {buyer , seller , prod_num } 을 조건으로 했을 때, 
	// 일치하는 정보가 있을 경우에 동작을 시켜주도록 한다. 단, 환불한 경우가 있는지도 확인해야 한다. 
	
	
	
	// 금액을 환불해줄 때 동작하는 함수 
	// 사용자가 마음을 바꿔서 구매를 취소하는 등에 동작해줄 함수 
	
	// 금액을 걸어놓을 때 동작하는 함수의 동작에서 반대로 동작하도록 한다. 
	// buyer (구매자명)
	// seller (판매자명 = 본인) 
	// coin : 환불시 지불되는 금액  + member 테이블의 coin 업데이트
	// type = 3 ( 3이라면 +로 표기해줄 것) 
	// prod_num : 상품 글의 번호 
	// 생각 거리 : 환불 시 기존에 저장해둔 금액을 걸었던 기록을 남겨둘지 생각해볼 것 
}
