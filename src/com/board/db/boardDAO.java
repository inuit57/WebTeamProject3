package com.board.db;

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

public class boardDAO {
	
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
    
	// insertBoard(bDTO);
    public void insertBoard(boardDTO bDTO){
    	int num = 0;
    	
    	try {
	    	conn = getConnection();
	    	
	    	sql = "select max(board_num) from normal_board";
    	
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1) + 1;
			}
			
			sql = "insert into normal_board values(?,?,?,?,?,?,now(),?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, bDTO.getBoard_area());
			pstmt.setString(3, bDTO.getUser_nick());
			pstmt.setInt(4, bDTO.getBoard_count());
			pstmt.setString(5, bDTO.getBoard_sub());
			pstmt.setString(6, bDTO.getBoard_content());
			pstmt.setString(7, bDTO.getBoard_file());
			pstmt.setString(8, bDTO.getBoard_ip());
			
			
			pstmt.executeUpdate();
			
			System.out.println("DAO : 게시판 글쓰기 완료");
			System.out.println();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    }
    
	// insertBoard(bDTO);   
    
    /********************************************************************/
    
    
    /********************************************************************/

    // getBoardList()
    public List getBoardList(){
    	
    	
    	List boardList = new ArrayList();
    	
    	try {
    		conn = getConnection();
    	
    		sql = "select * from normal_board order by board_num desc";
    	
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				boardDTO dto = new boardDTO();
				
				dto.setBoard_num(rs.getInt("board_num"));
				dto.setBoard_area(rs.getString("board_area"));
				dto.setUser_nick(rs.getString("user_nick"));
				dto.setBoard_count(rs.getInt("board_count"));
				dto.setBoard_date(rs.getString("board_date"));
				dto.setBoard_file(rs.getString("board_file"));
				dto.setBoard_ip(rs.getString("board_ip"));
				dto.setBoard_sub(rs.getString("board_sub"));
				dto.setBoard_content(rs.getString("board_content"));
				
				boardList.add(dto);
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    	return boardList;
    }
    
    
    // getBoardList()
    
  
   public ArrayList getBoardList(int startRow, int pageSize, String nick) {
    	
    	ArrayList boardList = new ArrayList();
    	
    	boardDTO bDTO = null;
    	
    	try {
    		conn = getConnection();
    	
    		sql = "select * from normal_board WHERE user_nick=? limit ?,? ";
    	
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, nick);
			pstmt.setInt(2, startRow -1);
			pstmt.setInt(3, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				bDTO = new boardDTO();
				
				bDTO.setBoard_num(rs.getInt("board_num"));
				bDTO.setBoard_area(rs.getString("board_area"));
				bDTO.setUser_nick(rs.getString("user_nick"));
				bDTO.setBoard_count(rs.getInt("board_count"));
				bDTO.setBoard_date(rs.getString("board_date"));
				bDTO.setBoard_file(rs.getString("board_file"));
				bDTO.setBoard_ip(rs.getString("board_ip"));
				bDTO.setBoard_sub(rs.getString("board_sub"));
				bDTO.setBoard_content(rs.getString("board_content"));
			
				boardList.add(bDTO);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    	return boardList;
    	
    }
    // getBoardList(startRow, pageSize)
  
    /********************************************************************/
    
    // getBoardCount();
    public int getBoardCount(){
    	
    	int cnt = 0;
    	
    	try {
    		conn = getConnection();
    	
    		sql = "select count(*) from normal_board";
    	
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				cnt = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    	return cnt;
    }
    
    // getBoardCount();
    
    /********************************************************************/
    
    // getBoardList(startRow, pageSize)
    public ArrayList getBoardList(int startRow, int pageSize) {
    	
    	ArrayList boardList = new ArrayList();
    	
    	boardDTO bDTO = null;
    	
    	try {
    		conn = getConnection();
    	
    		sql = "select * from normal_board order by board_num desc limit ?,? ";
    	
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, startRow -1);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				bDTO = new boardDTO();
				
				bDTO.setBoard_num(rs.getInt("board_num"));
				bDTO.setBoard_area(rs.getString("board_area"));
				bDTO.setUser_nick(rs.getString("user_nick"));
				bDTO.setBoard_count(rs.getInt("board_count"));
				bDTO.setBoard_date(rs.getString("board_date"));
				bDTO.setBoard_file(rs.getString("board_file"));
				bDTO.setBoard_ip(rs.getString("board_ip"));
				bDTO.setBoard_sub(rs.getString("board_sub"));
				bDTO.setBoard_content(rs.getString("board_content"));
			
				boardList.add(bDTO);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    	return boardList;
    	
    }
    // getBoardList(startRow, pageSize)
    
    /********************************************************************/
    
    
    /********************************************************************/
    
    // updateReadcount(board_num)
    public void updateReadcount(int board_num){
    	
    	try {
    		conn = getConnection();
    	
    		sql = "update normal_board set board_count = board_count+1 where board_num=?";
    	
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, board_num);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    }
    
    // updateReadcount(board_num)

    /********************************************************************/
    

    /********************************************************************/

    // getContent(board_num)
    public boardDTO getContent(int board_num){
    	
    	boardDTO bDTO = null;
    	
    	try {
    		conn = getConnection();
    	
    		sql = "select * from normal_board where board_num=?";
    	
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, board_num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				bDTO = new boardDTO();
				
				bDTO.setBoard_num(rs.getInt("board_num"));
				bDTO.setBoard_area(rs.getString("board_area"));
				bDTO.setUser_nick(rs.getString("user_nick"));
				bDTO.setBoard_count(rs.getInt("board_count"));
				bDTO.setBoard_date(rs.getString("board_date"));
				bDTO.setBoard_file(rs.getString("board_file"));
				bDTO.setBoard_ip(rs.getString("board_ip"));
				bDTO.setBoard_sub(rs.getString("board_sub"));
				bDTO.setBoard_content(rs.getString("board_content"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    	System.out.println("DAO : 게시글 컨텐츠 가져오기 완료");
    	return bDTO;
    	
    }
    // getContent(board_num)
    
    /********************************************************************/
    
    
    /********************************************************************/

    // modifyBoard(bDTO)
    public void modifyBoard(boardDTO bDTO){
    	
    	try {
    		conn = getConnection();
    	
    		sql = "update normal_board set board_sub=?, board_area=?, board_content=? where board_num=?";
    	
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, bDTO.getBoard_sub());
			pstmt.setString(2, bDTO.getBoard_area());
			pstmt.setString(3, bDTO.getBoard_content());
			pstmt.setInt(4, bDTO.getBoard_num());
			
			pstmt.executeUpdate();
			
			System.out.println("DAO : 일반게시글 수정완료");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    }
    // modifyBoard(bDTO)
    
    /********************************************************************/
    
    
    /********************************************************************/
    // deleteBoard(board_num)
    public void deleteBoard(int board_num){
    	
    	try {
    		conn = getConnection();
    	
    		sql = "delete from normal_board where board_num=?";
    	
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, board_num);
			
			pstmt.executeUpdate();
			
			System.out.println("DAO : 게시글 삭제완료");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    	
    }
    // deleteBoard(board_num)
    
    /********************************************************************/
    
    
    /********************************************************************/
    // + sk + " like '%" + sv + "%' order by board_num desc";
    // boardSearch(sk,sv)
    public List boardSearch(String sk, String[] sv){
    	
    	ArrayList boList = new ArrayList();
    	boardDTO bDTO = null;
    	
    	try {
    		conn = getConnection();
    	
    		sql = "select * from normal_board where " + sk + " like '%" + sv[0] + "%' ";
    		
    		for(int i = 1; i < sv.length; i++){
    			sql+="or "+sk+" like '%"+sv[i]+"%'";
    		}
    		
    		sql += " order by board_num desc";
    		
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				bDTO = new boardDTO();
				
				bDTO.setBoard_num(rs.getInt("board_num"));
				bDTO.setBoard_area(rs.getString("board_area"));
				bDTO.setUser_nick(rs.getString("user_nick"));
				bDTO.setBoard_count(rs.getInt("board_count"));
				bDTO.setBoard_sub(rs.getString("board_sub"));
				bDTO.setBoard_content(rs.getString("board_content"));
				bDTO.setBoard_date(rs.getString("board_date"));
				bDTO.setBoard_file(rs.getString("board_file"));
				bDTO.setBoard_ip(rs.getString("board_ip"));
				
				boList.add(bDTO);
				
				System.out.println("DAO : 게시글 검색완료");
				
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    	return boList;
    	
    }
    // boardSearch(sk,sv)
    
    /********************************************************************/
    
    
    /********************************************************************/
    // getBoardCount(sk, sv) 검색한 글의 개수 가져오는 함수
    public int getBoardCount(String sk, String[] sv){
    	
    	int cnt = 0;
    	
    	try {
    		conn = getConnection();
    	
    		sql = "select * from normal_board where " + sk + " like '%" + sv[0] + "%' ";
    		
    		for(int i = 1; i < sv.length; i++){
    			sql+="or "+sk+" like '%"+sv[i]+"%'";
    		}
    	
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				cnt = rs.getInt(1);
			}
			
			System.out.println("검색한 글개수" + cnt);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    	return cnt;
    }
    
    // getBoardCount(sk, sv) 검색한 글의 개수 가져오는 함수
    /********************************************************************/

}

