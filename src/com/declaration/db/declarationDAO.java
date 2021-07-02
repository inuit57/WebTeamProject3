package com.declaration.db;

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

public class declarationDAO {
	
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
    
    /********************************************************************/
   
    
    /********************************************************************/
    // declWrite(dcDTO); - 신고글 작성하기
    public void declWrite(declarationDTO dcDTO){
    	
    	int num = 0;
    	
    	try {
    		conn = getConnection();
    	
    		sql = "select max(decl_num) from declaration_board";
    	
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1) + 1;
			}
			
			sql = "insert into declaration_board values(?,?,?,?,?,?,?,now(),?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setInt(2, dcDTO.getBoard_type());
			pstmt.setInt(3, dcDTO.getBoard_num());
			pstmt.setString(4, dcDTO.getUser_nick());
			pstmt.setString(5, dcDTO.getBoard_sub());
			pstmt.setInt(6, dcDTO.getDecl_reason());
			pstmt.setString(7, dcDTO.getDecl_content());
			pstmt.setString(8, dcDTO.getDecl_writer());
			pstmt.setInt(9, dcDTO.getDecl_state());
			
			pstmt.executeUpdate();
			
			System.out.println("DAO : 신고글 작성완료");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    }
    
    // declWrite(dcDTO); - 신고글 작성하기
    /********************************************************************/
    
    
    /********************************************************************/
    // getDecl_normal_list - 일반게시판 신고글 목록
    public List getDecl_normal_list(int startRow, int pageSize){
    	List decl_normal_list = new ArrayList();
    	
    	try {
    		conn = getConnection();
    	
//    		sql = "select * from declaration_board natural join "
//    				+ "(select board_num, count(board_num) cnt "
//    				+ " from declaration_board "
//    				+ " group by(board_num)) board_cnt "
//    				+ "where board_type = 0 "
//    				+ "order by cnt desc; ";
    		
    		// 신고테이블에서 일반게시글타입인 전체글과 신고당한 게시글번호의 개수을 조회하는데
    		// group by절을 이용해 같은 번호끼리 묶어주고 갯수가 많은 순서대로 정렬해줌
    		//										=> 많이 신고당한 순으로 보여주기 위함
    		sql = "select *, count(board_num) cnt "
    				+ "from declaration_board "
    				+ "where board_type=0 "
    				+ "group by board_num "
    				+ "order by cnt desc "
    				+ "limit ?,?";
    	
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, startRow -1);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				declarationDTO dcDTO = new declarationDTO();
				
				dcDTO.setDecl_num(rs.getInt("decl_num"));
				dcDTO.setBoard_type(rs.getInt("board_type"));
				dcDTO.setBoard_num(rs.getInt("board_num"));
				dcDTO.setUser_nick(rs.getString("user_nick"));
				dcDTO.setBoard_sub(rs.getString("board_sub"));
				dcDTO.setDecl_state(rs.getInt("decl_state"));
				dcDTO.setDecl_reason(rs.getInt("decl_reason"));
				dcDTO.setDecl_content(rs.getString("decl_content"));
				dcDTO.setDecl_date(rs.getString("decl_date"));
				dcDTO.setDecl_writer(rs.getString("decl_writer"));
				
				decl_normal_list.add(dcDTO);
				
			}
				System.out.println("*****************************************************************");
				System.out.println("DAO : 일반게시판 신고글 신고순으로 조회");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    	return decl_normal_list;
    }
    
    // getDecl_normal_list - 일반게시판 신고글 목록
    /********************************************************************/
    
    
    /********************************************************************/
    // getDecl_normal_list(state, startRow, pageSize) - state 숫자값에 따라 처리된글만 보여줄지 결정
    public List getDecl_normal_list(int state, int startRow, int pageSize){
    	List decl_normal_list = new ArrayList();
    	
    	StringBuffer SQL = new StringBuffer();
    	
    	try {
    		conn = getConnection();
    	
//    		sql = "select * from declaration_board natural join "
//    				+ "(select board_num, count(board_num) cnt "
//    				+ " from declaration_board "
//    				+ " group by(board_num)) board_cnt "
//    				+ "where board_type = 0 "
//    				+ "order by cnt desc; ";
    		
    		// 신고테이블에서 일반게시글타입인 전체글과 신고당한 게시글번호의 개수을 조회하는데
    		// group by절을 이용해 같은 번호끼리 묶어주고 갯수가 많은 순서대로 정렬해줌
    		//										=> 많이 신고당한 순으로 보여주기 위함
//    		sql = "select *, count(board_num) cnt "
//    				+ "from declaration_board "
//    				+ "where board_type=0 "
//    				+ "group by board_num "
//    				+ "order by cnt desc "
//    				+ "limit ?,?";
    		
    		SQL.append("select *,count(board_num) cnt from declaration_board ");
    		
    		if(state == 1){
    			SQL.append(" where board_type=0 and decl_state=1 group by board_num order by cnt desc limit ?,?");
    		} else {
    			SQL.append(" where board_type=0 and decl_state=2 group by board_num order by cnt desc limit ?,?");
    		}
    		
    	
			pstmt = conn.prepareStatement(SQL+"");
			
			pstmt.setInt(1, startRow -1);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				declarationDTO dcDTO = new declarationDTO();
				
				dcDTO.setDecl_num(rs.getInt("decl_num"));
				dcDTO.setBoard_type(rs.getInt("board_type"));
				dcDTO.setBoard_num(rs.getInt("board_num"));
				dcDTO.setUser_nick(rs.getString("user_nick"));
				dcDTO.setBoard_sub(rs.getString("board_sub"));
				dcDTO.setDecl_state(rs.getInt("decl_state"));
				dcDTO.setDecl_reason(rs.getInt("decl_reason"));
				dcDTO.setDecl_content(rs.getString("decl_content"));
				dcDTO.setDecl_date(rs.getString("decl_date"));
				dcDTO.setDecl_writer(rs.getString("decl_writer"));
				dcDTO.setDecl_state(rs.getInt("decl_state"));
				
				decl_normal_list.add(dcDTO);
				
			}
				System.out.println("*****************************************************************");
				System.out.println("DAO : 일반게시판 신고글 신고순으로 조회");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    	return decl_normal_list;
    }
    // getDecl_normal_list(state, startRow, pageSize) - state 숫자값에 따라 처리된글만 보여줄지 결정
    /********************************************************************/
    
    
    /********************************************************************/
    // getDecl_normal_reason - 일반게시판 신고사유
    public List getDecl_normal_reason(int board_num){
    	List decl_normal_reason = new ArrayList();
    	
    	try {
    		conn = getConnection();
    	
//    		sql = "select * from declaration_board natural join "
//    				+ "(select board_num, count(board_num) cnt "
//    				+ " from declaration_board "
//    				+ " group by(board_num)) board_cnt "
//    				+ "where board_type = 0 "
//    				+ "order by cnt desc; ";
    		
    		// 신고테이블에서 일반게시글타입인 전체글과 신고당한 게시글번호의 개수을 조회하는데
    		// group by절을 이용해 같은 번호끼리 묶어주고 갯수가 많은 순서대로 정렬해줌
    		//										=> 많이 신고당한 순으로 보여주기 위함
    		sql = "select * "
    				+ "from declaration_board "
    				+ "where board_type=0 and board_num=? ";
    	
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, board_num);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				declarationDTO dcDTO = new declarationDTO();
				
				dcDTO.setDecl_num(rs.getInt("decl_num"));
				dcDTO.setBoard_type(rs.getInt("board_type"));
				dcDTO.setBoard_num(rs.getInt("board_num"));
				dcDTO.setUser_nick(rs.getString("user_nick"));
				dcDTO.setDecl_reason(rs.getInt("decl_reason"));
				dcDTO.setDecl_content(rs.getString("decl_content"));
				dcDTO.setDecl_date(rs.getString("decl_date"));
				dcDTO.setDecl_writer(rs.getString("decl_writer"));
				
				decl_normal_reason.add(dcDTO);
				
			}
				System.out.println("DAO : 일반게시판 신고글 신고순으로 조회");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    	return decl_normal_reason;
    }
    
    // getDecl_normal_list - 일반게시판 신고글 사유
    /********************************************************************/
    
    
    /********************************************************************/
    // getDecl_normal_count(int board_num)
    // 이 함수에 board_num을 매개변수로 받아서 DB에있는 board_num검색해서
    // 일반게시판글 신고횟수 가져오기
    public int getDecl_normal_count(int board_num){
    	int decl_noamal_cnt = 0;
    	
    	try {
    		conn = getConnection();
    		
    		// 신고테이블에서 게시글번호는 ?번이며 일반게시판타입인 글의 개수를 가져옴
    		// 
    		sql = "select count(board_num) cnt from declaration_board where board_num=? and board_type=0";
    	
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, board_num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				decl_noamal_cnt = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    	return decl_noamal_cnt;
    	
    }
    // getDecl_normal_count(int board_num)
    // 일반게시판글 신고횟수 가져오기
    /********************************************************************/
    
    
    /********************************************************************/
    // 신고DB에 총 갯수 가져오기 - normal
    public int decl_normal_listCount(){
    	
    	int decl_normal_listcnt = 0;
    	
    	try {
    		conn = getConnection();
    	
    		sql = "select count(*) from (select *, count(board_num) cnt from declaration_board where board_type=0 group by board_num) d";
    	
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				decl_normal_listcnt = rs.getInt(1);
			}
			
			System.out.println("신고DB 게시글 개수 조회 완료");
			System.out.println(decl_normal_listcnt + "개");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	return decl_normal_listcnt;
    	
    }
    // 신고DB에 총 갯수 가져오기 - normal
    /********************************************************************/
    
    /********************************************************************/
    // decl_normal_delete(int board_num) - 일반게시판 관리자가 삭제
    public void decl_normal_delete(int board_num){
    	
    	try {
    		conn = getConnection();
    	
    		sql = "delete from declaration_board where board_num=? and board_type=0";
    	
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, board_num);
			
			pstmt.executeUpdate();
			
			System.out.println("declDAO : 신고된글 삭제처리");
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    }
    // decl_normal_delete(int board_num) - 일반게시판 관리자가 삭제
    /********************************************************************/
   
    
    /********************************************************************/
    // 신고DB에 총 갯수 가져오기 - prod
    public int decl_prod_listCount(){
    	
    	int decl_prod_listcnt = 0;
    	
    	try {
    		conn = getConnection();
    	
    		sql = "select count(*) from (select *, count(board_num) cnt from declaration_board where board_type=1 group by board_num) d";
    	
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				decl_prod_listcnt = rs.getInt(1);
			}
			
			System.out.println("신고DB 게시글 개수 조회 완료");
			System.out.println(decl_prod_listcnt + "개");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	return decl_prod_listcnt;
    	
    }
    // 신고DB에 총 갯수 가져오기 - prod
    /********************************************************************/
    
    
    /********************************************************************/
    // getDecl_prod_list - 상품게시판 신고글 목록
    public List getDecl_prod_list(int startRow, int pageSize){
    	List decl_prod_list = new ArrayList();
    	
    	try {
    		conn = getConnection();
    	
//    		sql = "select * from declaration_board natural join "
//    				+ "(select board_num, count(board_num) cnt "
//    				+ " from declaration_board "
//    				+ " group by(board_num)) board_cnt "
//    				+ "where board_type = 0 "
//    				+ "order by cnt desc; ";
    		
    		// 신고테이블에서 일반게시글타입인 전체글과 신고당한 게시글번호의 개수을 조회하는데
    		// group by절을 이용해 같은 번호끼리 묶어주고 갯수가 많은 순서대로 정렬해줌
    		//										=> 많이 신고당한 순으로 보여주기 위함
    		sql = "select *, count(board_num) cnt "
    				+ "from declaration_board "
    				+ "where board_type=1 "
    				+ "group by board_num "
    				+ "order by cnt desc "
    				+ "limit ?,?";
    	
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, startRow -1);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				declarationDTO dcDTO = new declarationDTO();
				
				dcDTO.setDecl_num(rs.getInt("decl_num"));
				dcDTO.setBoard_type(rs.getInt("board_type"));
				dcDTO.setBoard_num(rs.getInt("board_num"));
				dcDTO.setUser_nick(rs.getString("user_nick"));
				dcDTO.setDecl_reason(rs.getInt("decl_reason"));
				dcDTO.setDecl_content(rs.getString("decl_content"));
				dcDTO.setDecl_date(rs.getString("decl_date"));
				dcDTO.setDecl_writer(rs.getString("decl_writer"));
				
				decl_prod_list.add(dcDTO);
				
			}
				System.out.println("*****************************************************************");
				System.out.println("DAO : 상품게시판 신고글 신고순으로 조회");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    	return decl_prod_list;
    }
    
    // getDecl_prod_list - 상품게시판 신고글 목록
    /********************************************************************/
   
    
    /********************************************************************/
    // getDecl_prod_count(board_num)
    // 이 함수에 board_num을 매개변수로 받아서 DB에있는 board_num검색해서
    // 상품게시판글 신고횟수 가져오기
    public int getDecl_prod_count(int num){
    	int decl_prod_cnt = 0;
    	
    	try {
    		conn = getConnection();
    		
    		// 신고테이블에서 게시글번호는 ?번이며 일반게시판타입인 글의 개수를 가져옴
    		// 
    		sql = "select count(board_num) cnt from declaration_board where board_num=? and board_type=1";
    	
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				decl_prod_cnt = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    	return decl_prod_cnt;
    	
    }
    // getDecl_prod_count(board_num)
    /********************************************************************/
    
    /********************************************************************/
    // getDecl_prod_reason - 상품게시판 신고사유
    public List getDecl_prod_reason(int num){
    	List decl_prod_reason = new ArrayList();
    	
    	try {
    		conn = getConnection();
    	
//    		sql = "select * from declaration_board natural join "
//    				+ "(select board_num, count(board_num) cnt "
//    				+ " from declaration_board "
//    				+ " group by(board_num)) board_cnt "
//    				+ "where board_type = 0 "
//    				+ "order by cnt desc; ";
    		
    		// 신고테이블에서 일반게시글타입인 전체글과 신고당한 게시글번호의 개수을 조회하는데
    		// group by절을 이용해 같은 번호끼리 묶어주고 갯수가 많은 순서대로 정렬해줌
    		//										=> 많이 신고당한 순으로 보여주기 위함
    		sql = "select * "
    				+ "from declaration_board "
    				+ "where board_type=1 and board_num=? ";
    	
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				declarationDTO dcDTO = new declarationDTO();
				
				dcDTO.setDecl_num(rs.getInt("decl_num"));
				dcDTO.setBoard_type(rs.getInt("board_type"));
				dcDTO.setBoard_num(rs.getInt("board_num"));
				dcDTO.setUser_nick(rs.getString("user_nick"));
				dcDTO.setDecl_reason(rs.getInt("decl_reason"));
				dcDTO.setDecl_content(rs.getString("decl_content"));
				dcDTO.setDecl_date(rs.getString("decl_date"));
				dcDTO.setDecl_writer(rs.getString("decl_writer"));
				
				decl_prod_reason.add(dcDTO);
				
			}
				System.out.println("*****************************************************************");
				System.out.println("DAO : 상품게시판 신고글 신고순으로 조회");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    	return decl_prod_reason;
    }
    
    // getDecl_normal_list - 상품게시판 신고글 사유
    /********************************************************************/
    
    
    /********************************************************************/
    // decl_prod_delete(num) - 상품게시판 관리자가 삭제
    public void decl_prod_delete(int num){
    	
    	try {
    		conn = getConnection();
    	
    		sql = "delete from declaration_board where board_num=? and board_type=1";
    	
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
			System.out.println("declDAO : 신고된글 삭제처리");
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    }
    // decl_prod_delete(num) - 상품게시판 관리자가 삭제
    /********************************************************************/
    
    
    /********************************************************************/
    // decl_state_update(board_num); - 신고된 글 삭제시 상태 업데이트
    public void decl_state_update(int board_num){
    	
    	try {
    		conn = getConnection();
    	
    		sql = "update declaration_board set decl_state=2 where board_type=0 and board_num=?";
    	
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, board_num);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    }
    // decl_state_update(board_num); - 신고된 글 삭제시 상태 업데이트
    /********************************************************************/
    
    
    /********************************************************************/
    // decl_normal_listCount(state)
    public int decl_normal_listCount(int state){
    	
    	int decl_normal_listcnt = 0;
    	
    	try {
    		conn = getConnection();
    	
    		sql = "select count(*) from (select *, count(board_num) cnt from declaration_board where board_type=0 and decl_state=? group by board_num) d";
    	
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, state);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				decl_normal_listcnt = rs.getInt(1);
			}
			
			System.out.println("신고DB 게시글 개수 조회 완료");
			System.out.println(decl_normal_listcnt + "개");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	return decl_normal_listcnt;
    	
    }
    // decl_normal_listCount(state)
    /********************************************************************/
    /********************************************************************/
    /********************************************************************/
    /********************************************************************/

}
