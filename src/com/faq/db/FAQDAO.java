package com.faq.db;

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



public class FAQDAO {

	
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

	
	
	
    
	
	//faqWrite(FAQDTO fdto)
    public void faqWrite(FAQDTO fdto){
    	int num = 0;
		try {
			// 1 드라이버 로드
			// 2 디비 연결
			// => 한번에 처리 하는 메서드로 변경
			conn = getConnection();		
			
			// 3 sql (글번호를 계산하는 구문)
			sql = "select max(faq_idx) from faq_board";
			
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
			sql = "insert into faq_board(faq_idx, faq_cate, user_nick, faq_sub, faq_content, faq_file, faq_date) values(?,?,?,?,?,?,now())";
			
			pstmt = conn.prepareStatement(sql);
			
			// ?
			pstmt.setInt(1, num);
			pstmt.setString(2, fdto.getFaq_cate());
			pstmt.setString(3, fdto.getUser_nick());
			pstmt.setString(4, fdto.getFaq_sub());
			pstmt.setString(5, fdto.getFaq_content());
			pstmt.setString(6, fdto.getFaq_file());
			
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
	}//faqWrite(FAQDTO fdto)
    
    
    
    
    
    
    //getFAQList()
    public List getFAQList(){
    	List faqList = new ArrayList();
    	try {
			conn = getConnection();
			sql = "select * from faq_board";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				FAQDTO fdto = new FAQDTO();
				fdto.setFaq_idx(rs.getInt("faq_idx"));
				fdto.setFaq_cate(rs.getString("faq_cate"));
				fdto.setUser_nick(rs.getString("user_nick"));
				fdto.setFaq_sub(rs.getString("faq_sub"));
				fdto.setFaq_content(rs.getString("faq_content"));
				fdto.setFaq_file(rs.getString("faq_file"));

				// 리스트 한칸에 상품 1개를 저장
				faqList.add(fdto);

			} // while

			System.out.println("DAO : 상품 정보 저장 완료(일반사용자 상품 목록)");

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

    	return faqList;
    }
    //getFAQList()
    
    
    
    
    
    
  //getFAQList(faq_cate)
    public List getFAQList(String faq_cate){
    	List faqList = new ArrayList();
    	
    	StringBuffer SQL = new StringBuffer();
    	
    	try {
			conn = getConnection();
			
			SQL.append("select * from faq_board");
			
			if (faq_cate.equals("all")) {
			} else {
				SQL.append(" where faq_cate=?");
			}

			pstmt = conn.prepareStatement(SQL + "");
			
			if (faq_cate.equals("all")) {
			} else {
				pstmt.setString(1, faq_cate);
			}
			rs = pstmt.executeQuery();

			while (rs.next()) {
				FAQDTO fdto = new FAQDTO();
				fdto.setFaq_idx(rs.getInt("faq_idx"));
				fdto.setFaq_cate(rs.getString("faq_cate"));
				fdto.setUser_nick(rs.getString("user_nick"));
				fdto.setFaq_sub(rs.getString("faq_sub"));
				fdto.setFaq_content(rs.getString("faq_content"));
				fdto.setFaq_file(rs.getString("faq_file"));

				// 리스트 한칸에 상품 1개를 저장
				faqList.add(fdto);

			} // while

			System.out.println("DAO : 상품 정보 저장 완료(일반사용자 상품 목록)");

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

    	return faqList;
    }
    //getFAQList(faq_cate)
    
    
    
    
    
    
    //faqDel(idx)
    public void faqDel(String idx){
    	try {
			// 1 드라이버 로드
			// 2 디비 연결
			// => 한번에 처리 하는 메서드로 변경
			conn = getConnection();		
			
			// 3 sql (글번호를 계산하는 구문)
			sql = "delete from faq_board where faq_idx=?";
			
			pstmt = conn.prepareStatement(sql);
			
			//?
			pstmt.setString(1, idx);
			
			// 4 sql 실행
			pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			System.out.println("디비 연결 실패!!");
			e.printStackTrace();
		} finally{
			closeDB();			
		}
    }
  //faqDel(idx)

    
    
    
    
    
}
