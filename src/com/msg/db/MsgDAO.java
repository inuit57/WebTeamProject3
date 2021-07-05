package com.msg.db;

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

import com.faq.db.FAQDTO;

public class MsgDAO {
	
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
	
	
	//msgWrite(MsgDTO mdto)
	public void msgWrite(MsgDTO mdto){

	    	int num = 0;
			try {
				// 1 드라이버 로드
				// 2 디비 연결
				// => 한번에 처리 하는 메서드로 변경
				conn = getConnection();		
				
				// 3 sql (글번호를 계산하는 구문)
				sql = "select max(msg_idx) from msg";
				
				pstmt = conn.prepareStatement(sql);
				
				// 4 sql 실행
				rs = pstmt.executeQuery();
				
				// 5 데이터 처리
				//  max(num) - sql 함수를 실행했을경우 커서이동 가능(데이터여부 상관없음)
				//  num     - sql 컬럼의 경우  커서 이동 불가능
				if(rs.next()){
					//num = rs.getInt("max(num)")+1;
					num = rs.getInt(1)+1;
				}
				
				System.out.println(" 글번호  : "+num);
				
				////////////////////////////////////////////////////
				
				// 3 sql 작성 (insert) & pstmt 객체 생성
				sql = "insert into msg(msg_idx, recv_nick, send_nick, msg_content, msg_chk, msg_date) values(?,?,?,?,?,now())";
				
				pstmt = conn.prepareStatement(sql);
				
				// ?
				pstmt.setInt(1, num);
				pstmt.setString(2, mdto.getRecv_nick());
				pstmt.setString(3, mdto.getSend_nick());
				pstmt.setString(4, mdto.getMsg_content());
				pstmt.setInt(5, 0);
				
				
				// 4 sql 실행	
				
				pstmt.executeUpdate();
				
				System.out.println(" sql 구문 실행완료  : 글쓰기 완료! ");
				
			} catch (SQLException e) {
				System.out.println("디비 연결 실패!!");
				e.printStackTrace();
			} finally{
				// 자원해제 
				closeDB();		
			}
		
	}//msgWrite(MsgDTO mdto)
	
	
	//msgWrite(MsgDTO mdto)
	/**
	 * 
	 *  찜목록의 상품에 변동사항이 생길 경우, 시스템적으로 보내주는 메시지 
	 *  보내야 하는 회원들의 목록을 받아서 각각 insert를 해주는 식으로 구현 
	 */
	public void msgWrite(List<String> memberList){

    	int num = 0;
		try {
			// 1 드라이버 로드
			// 2 디비 연결
			// => 한번에 처리 하는 메서드로 변경
			conn = getConnection();		
			
			// 3 sql (글번호를 계산하는 구문)
			sql = "select max(msg_idx) from msg";
			
			pstmt = conn.prepareStatement(sql);
			
			// 4 sql 실행
			rs = pstmt.executeQuery();
			
			// 5 데이터 처리
			//  max(num) - sql 함수를 실행했을경우 커서이동 가능(데이터여부 상관없음)
			//  num     - sql 컬럼의 경우  커서 이동 불가능
			if(rs.next()){
				//num = rs.getInt("max(num)")+1;
				num = rs.getInt(1)+1;
			}
			////////////////////////////////////////////////////
			
			// 3 sql 작성 (insert) & pstmt 객체 생성
			for(int i =0 ; i< memberList.size() ; i++){
				sql = "insert into msg(msg_idx, recv_nick, send_nick, msg_content, msg_chk, msg_date) values(?,?,?,?,?,now())";
				
				pstmt = conn.prepareStatement(sql);

				pstmt.setInt(1, num);
				pstmt.setString(2, memberList.get(i));
				pstmt.setString(3, "system");
				pstmt.setString(4, "찜목록해두신 상품이 판매완료 되었습니다."); 
				// 삭제된 경우에는 다른 메시지를 띄워주도록 ?? 
				pstmt.setInt(5, 0);
				
				// 4 sql 실행	
				pstmt.executeUpdate();
				num++; 
			}
			
		} catch (SQLException e) {
			System.out.println("디비 연결 실패!!");
			e.printStackTrace();
		} finally{
			// 자원해제 
			closeDB();		
		}
			
	}//msgWrite(MsgDTO mdto)
	
	
	//getMsgList(msgTag, tag)
	 public List getMsgList(String msgTag, String user_nick){
	    	List msgLisg = new ArrayList();
	    	
	    	StringBuffer SQL = new StringBuffer();
	    	
	    	try {
				conn = getConnection();
				
				SQL.append("select * from msg");
				
				if (msgTag.equals("recv")) {
					SQL.append(" where recv_nick=? order by msg_idx desc");
				}else if(msgTag.equals("send")){
					SQL.append(" where send_nick=? order by msg_idx desc");
				}
	
				pstmt = conn.prepareStatement(SQL + "");
				
				if(msgTag.equals("recv")){
					pstmt.setString(1, user_nick);
				}else if(msgTag.equals("send")){
					pstmt.setString(1, user_nick);
				}
				rs = pstmt.executeQuery();
	
				while (rs.next()) {
					MsgDTO mdto = new MsgDTO();
					mdto.setMsg_idx(rs.getInt("msg_idx"));
					mdto.setProd_num(rs.getInt("prod_num"));
					mdto.setRecv_nick(rs.getString("recv_nick"));
					mdto.setSend_nick(rs.getString("send_nick"));
					mdto.setMsg_content(rs.getString("msg_content"));
					mdto.setMsg_chk(rs.getInt("msg_chk"));
					mdto.setMsg_date(rs.getDate("msg_date"));
					
					// 리스트 한칸에 상품 1개를 저장
					msgLisg.add(mdto);
	
				} // while
	
	
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}
	
	    	return msgLisg;
	    }
	//getMsgList(msgTag, tag)
	
	
	//getRecvChk()
	 public int getRecvChk(String user_nick){
		int num = 0;
		try {
			// 1 드라이버 로드
			// 2 디비 연결
			// => 한번에 처리 하는 메서드로 변경
			conn = getConnection();		
			
			// 3 sql (글번호를 계산하는 구문)
			sql = "select count(msg_idx) from msg where msg_chk=0 and recv_nick=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_nick);
			
			// 4 sql 실행
			rs = pstmt.executeQuery();
			
			
			if(rs.next()){
				num = rs.getInt(1);
			}
			
			
			
		} catch (SQLException e) {
			System.out.println("디비 연결 실패!!");
			e.printStackTrace();
		} finally{
			// 자원해제 
			closeDB();		
		}
		
		return num;
	 }
	//getRecvChk()
	
	
	 
	 
	 //updateMsgChk(msg_idx)
	 public void updateMsgChk(int msg_idx){
			try {
				// 1 드라이버 로드
				// 2 디비 연결
				// => 한번에 처리 하는 메서드로 변경
				conn = getConnection();		
				
				// 3 sql (글번호를 계산하는 구문)
				sql = "update msg set msg_chk=1 where msg_idx=?";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, msg_idx);
				
				// 4 sql 실행
				pstmt.executeUpdate();
				
			} catch (SQLException e) {
				System.out.println("디비 연결 실패!!");
				e.printStackTrace();
			} finally{
				// 자원해제 
				closeDB();		
			}
			
	 }
	 //updateMsgChk(msg_idx)
	
	
	 
	 // msgDel(msg_idx)
	 public void msgDel(String msg_idx){
		 try {
				// 1 드라이버 로드
				// 2 디비 연결
				// => 한번에 처리 하는 메서드로 변경
				conn = getConnection();		
				
				// 3 sql (글번호를 계산하는 구문)
				sql = "delete from msg where msg_idx=?";
				
				pstmt = conn.prepareStatement(sql);
				
				//?
				pstmt.setString(1, msg_idx);
				
				// 4 sql 실행
				pstmt.executeUpdate();
				
				
			} catch (SQLException e) {
				System.out.println("디비 연결 실패!!");
				e.printStackTrace();
			} finally{
				closeDB();			
			}
	 }
	 // msgDel(msg_idx)
	 
	 
	 
	 
}
