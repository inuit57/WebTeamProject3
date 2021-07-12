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

import com.prod.db.ProdDAO;
import com.user.db.UserDAO;

public class TradeLogDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = "";
	
	private ProdDAO prodDAO = new ProdDAO(); 
	private UserDAO userDAO = new UserDAO(); 
	
	
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
	
	
	/**
	 * 충전 시 동작하는 함수
	 * 
	 * type : 0(충전)
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
	// user_nick(구매자명 = 본인?)
	// target (판매자명) 
	// coin :  구매 시 지불하는 금액을 기록  + 지불된 금액만큼 member 의 coin을 차감.  
	// type = 1  ( 1이라면 -로 표기해줄 것) 
	// prod_num : 상품 글의 번호 ( 같은 판매자의 여러 상품들 중 하나를 구분하기 위함) 
	// 참고 : 이 시점에서 판매자에게 금액이 지불되는 것은 아니다. 이후 동작에서 처리된다. 
	
	/**
	 * 
	 * @param user_nick : 본인 이름  
	 * @param target : 거래자 명 
	 * @param prod_num : 상품 번호 
	 * @return : 성공(0) , 실패(-1 : 금액 부족) 
	 */
	public int wantBuyLog(String user_nick, String target, int prod_num){
		
		try{
			conn = getConnection(); 
			int price = prodDAO.getProduct(prod_num).getProd_price(); // 가격 얻어오기 
			int curr_coin = userDAO.getCoin(user_nick); 
			
			if( curr_coin < price){
				System.out.println("너 돈없자너~~~~~~~~~~~");
				return -1; 
			}
			// 금액 미리 차감
			userDAO.updateCoin(user_nick, price , false);
			sql = "insert into trade_log(trade_user,trade_target, trade_coin , trade_type, trade_date, prod_num) "
					+ " values(?,?, ?, 1 , now() ,?) "; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_nick);
			pstmt.setString(2, target);
			pstmt.setInt(3, price);
			pstmt.setInt(4, prod_num);
			
			pstmt.executeUpdate(); 
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		} 
		
		return 0 ; 
	}
	
	
	
	// 금액을 실제로 지불할 때 동작하는 함수 
	// target (구매자명)
	// user_nick (판매자명 = 본인) 
	// coin : 구매시 지불되는 금액 + member 테이블의 coin 업데이트
	// type = 2 ( 2라면 +로 표기해줄 것) 
	// prod_num : 상품 글의 번호 
	// 참고 : 동명의 테이블을 조회해서 {buyer , seller , prod_num } 을 조건으로 했을 때, 
	// 일치하는 정보가 있을 경우에 동작을 시켜주도록 한다. 단, 환불한 경우가 있는지도 확인해야 한다. 
	/**
	 * 
	 * "거래 완료" 시의 처리 동작
	 * 
	 *  거래로그에는 금액이 들어왔음을 기록하고 
	 *  코인도 증가시키는 동작을 처리. 
	 * 
	 * @param target : 구매자 이름
	 * @param user_nick : 판매자 이름 
 	 * @param prod_num : 상품 번호 
	 * @return 성공(0) , 실패( -1 : 거래 기록 없음) 
	 * 
	 *  환불하면 그냥 거래기록을 지워버리도록 하자. 
	 */
	public int buyConfirmLog(String target, String user_nick, int prod_num){
		
		conn = getConnection(); 
		
		// 거래 기록이 있는지 확인하기 
		try {
			sql = "select prod_num,trade_coin,trade_type from trade_log where trade_user = ? and trade_target = ? and prod_num = ? order by trade_date desc limit 1"; 
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, target);
			pstmt.setString(2, user_nick);
			pstmt.setInt(3, prod_num);
			
			rs = pstmt.executeQuery();
			
			// 거래 기록이 존재하는 경우 
			if(rs.next()){
				if(rs.getInt("trade_type") == 3){
					System.out.println("환불 처리된 상품입니다~~!!! ");
					return -2 ; //이미 환불된 상품 
				}
				
				int price = rs.getInt("trade_coin") ;
				
				sql = "insert into trade_log(trade_user,trade_target ,trade_coin , trade_type, trade_date, prod_num) "
						+ " values(?,?, ?, 2 , now() ,?) "; 
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, user_nick);
				pstmt.setString(2, target);
				pstmt.setInt(3, price);
				pstmt.setInt(4, prod_num);
				
				pstmt.executeUpdate(); 
				
				// 코인 추가 처리해주기 
				userDAO.updateCoin(user_nick, price, true);
				
			}else{
				System.out.println("거래 내역이 없습니다~~~~~!!! ");
				return -1; 
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		
		
		return 0; 
	}
	
	
	// 금액을 환불해줄 때 동작하는 함수 
	// 사용자가 마음을 바꿔서 구매를 취소하는 등에 동작해줄 함수 
	
	// 금액을 걸어놓을 때 동작하는 함수의 동작에서 반대로 동작하도록 한다. 
	// buyer (구매자명)
	// seller (판매자명 = 본인) 
	// coin : 환불시 지불되는 금액  + member 테이블의 coin 업데이트
	// type = 3 ( 3이라면 +로 표기해줄 것) 
	// prod_num : 상품 글의 번호 
	// 생각 거리 : 환불 시 기존에 저장해둔 금액을 걸었던 기록을 남겨둘지 생각해볼 것 
	// 환불하면 거래 기록에서도 지워버리는 것이 깔끔할 것 같다. 
	
	/**
	 * 
	 * 구매자 또는 판매자가 방에서 나갈 경우 동작시키기 
	 * 거래 기록이 존재한다면 거래 기록을 지워버려주기 (구매 기록) 
	 * 
	 * 그리고 코인도 다시 복구시켜주도록 하기 
	 * 
	 * @param user_nick 구매자명
	 * @param target 판매자명 
	 * @param prod_num 상품 번호 
	 * @return 0(성공) -1 (실패) 
	 */
	public int buyCancleLog(String user_nick, String target, int prod_num){
		
		conn = getConnection(); 
		// 거래 기록이 있는지 확인하기 
		try {
			//sql = "select trade_no, prod_num,trade_coin,trade_type from trade_log where trade_user = ? and trade_target = ? and prod_num = ? and trade_type= 1 "; 
			sql = "select prod_num,trade_coin,trade_type from trade_log where trade_user = ? and trade_target = ? and prod_num = ? order by trade_date desc limit 1";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, user_nick);
			pstmt.setString(2, target);
			pstmt.setInt(3, prod_num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if ( rs.getInt("trade_type") != 1){
					System.out.println("이미 환불된 상품입니다?! ");
					return -1 ; 
				}
				
				//int trade_no = rs.getInt("trade_no"); 
				int price = rs.getInt("trade_coin"); 
				
				//지우지 말고 insert 처리 해주자 그냥 
				//sql = " delete from trade_log where trade_no = ? "; 
//				pstmt = conn.prepareStatement(sql); 
//				pstmt.setInt(1, trade_no);

				sql = "insert into trade_log(trade_user,trade_target ,trade_coin , trade_type, trade_date, prod_num) "
						+ " values(?,?, ?, 3 , now() ,?) "; 
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, user_nick);
				pstmt.setString(2, target);
				pstmt.setInt(3, price);
				pstmt.setInt(4, prod_num);
				
				pstmt.executeUpdate(); 
				
				// 코인 복구 처리해주기 
				userDAO.updateCoin(user_nick, price, true);
			}else{
				System.out.println("결제 내역이 없습니다!!!!");
				return -1; 
			}
		
		}catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return 0; 
	}
	
	
	// 환불 대상자 목록 받기
	/**
	 * 
	 * 거래완료 되었을 경우에 채팅을 진행하고 있던 대상들을 조회해서 
	 * 환불 처리가 필요한 대상들을 찾아오는 함수 
	 * 
	 * @param target 판매자명
	 * @param prod_num 상품명 
	 * @return 거래가 완료되지 않은 대상들을 조회해오기 
	 */
	public List<String> getCancleUserList( String target, int prod_num ){
		
		List<String> userList = new ArrayList<String>() ; 
		
		conn = getConnection(); 
		
		// 거래 완료된 대상과 거래 취소한 대상은 빼야만 한다. 
		sql = "select trade_user from trade_log "
				+ "where trade_target = ? and prod_num = ? and trade_type = 1 "
				+ " and trade_user not in (select trade_target from trade_log where trade_user = ? and prod_num = ? and trade_type = 2) "  // 판매완료
				+ " and trade_user not in (select trade_user from trade_log where trade_target = ? and prod_num = ? and trade_type = 3)";  // 환불 

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, target);
			pstmt.setInt(2, prod_num);
			pstmt.setString(3, target);
			pstmt.setInt(4, prod_num);
			pstmt.setString(5, target);
			pstmt.setInt(6, prod_num);
			
			rs = pstmt.executeQuery(); 
			
			while(rs.next()){
				userList.add(rs.getString("trade_user")); 
				// user이름 추가 
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		} 
		
		return userList; 
	}
	
}
