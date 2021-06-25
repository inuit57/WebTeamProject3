package com.board.comment.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.sql.DataSource;


public class boardCommentDAO {
	
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

    // insertBoardComment(board_num, bcDAO)
    public void insertBoardComment(int board_num, boardCommentDTO bcDTO){
    	
    	int cmt_num = 0;
    	
    	try {
    		conn = getConnection();
    	
    		sql = "select max(cmt_num) from normal_board_comment";
    	
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				cmt_num = rs.getInt(1) + 1;
			}
			
				sql = "insert into normal_board_comment values(?,?,?,?,now(),?,?,?,?)";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, cmt_num);
				pstmt.setString(2, bcDTO.getUser_nick());
				pstmt.setString(3, bcDTO.getCmt_content());
				pstmt.setInt(4, board_num);
				pstmt.setInt(5, bcDTO.getCmt_ref());
				pstmt.setInt(6, bcDTO.getCmt_lev());
				pstmt.setInt(7, bcDTO.getCmt_seq());
				pstmt.setString(8, bcDTO.getCmt_ip());
				
				pstmt.executeUpdate();
				
				System.out.println("DAO : 댓글작성완료");
				System.out.println(bcDTO.getCmt_content());
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    }
    // insertBoardComment(board_num, bcDAO)
    
    /********************************************************************/
    
    
    /********************************************************************/
    
    // getCommentList(); - 한번에 다들고오는 함수
    public ArrayList getCommentList(){
    	
    	ArrayList commentList = new ArrayList();
    	
    	boardCommentDTO bcDTO = null;
    	
    	try {
			
			conn = getConnection();
			
			sql = "select * from normal_board_comment";
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				bcDTO = new boardCommentDTO();
				
				bcDTO.setCmt_num(rs.getInt("cmt_num"));
				bcDTO.setUser_nick(rs.getString("user_nick"));
				bcDTO.setCmt_content(rs.getString("cmt_content"));
				bcDTO.setCmt_date(rs.getString("cmt_date"));
				bcDTO.setCmt_ip(rs.getString("cmt_ip"));
				
				commentList.add(bcDTO);
			}
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}
    	
    	return commentList;
    }
    
    // getCommentList();
    
    /********************************************************************/

    
    /********************************************************************/
    // getBoardCommentCount
    public int getBoardCommentCount(int board_num){
    	
    	int cnt = 0;
    	
    	try {
    		conn = getConnection();
    	
    		sql="select count(*) from normal_board_comment where board_num=?";
    	
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, board_num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				cnt = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	System.out.println("@게시글번호 : " + board_num);
    	return cnt;
    }
    // getBoardCommentCount
    /********************************************************************/
  
    
    /********************************************************************/
    // getBoardCommentList(startRow, pageSize)
    public ArrayList getBoardCommentList(int startRow, int pageSize){
    	
    	ArrayList boardCommentList = new ArrayList();
    	
    	boardCommentDTO bcDTO = null;
    	
    	try {
    		conn = getConnection();
    	
    		sql="select * from normal_board_comment limit ?,?";
    	
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, startRow - 1);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				bcDTO = new boardCommentDTO();
				
				bcDTO.setCmt_num(rs.getInt("cmt_num"));
				bcDTO.setUser_nick(rs.getString("user_nick"));
				bcDTO.setCmt_content(rs.getString("cmt_content"));
				bcDTO.setBoard_num(rs.getInt("board_num"));
				bcDTO.setCmt_date(rs.getString("cmt_date"));
				bcDTO.setCmt_ref(rs.getInt("cmt_ref"));
				bcDTO.setCmt_lev(rs.getInt("cmt_lev"));
				bcDTO.setCmt_seq(rs.getInt("cmt_seq"));
				bcDTO.setCmt_ip(rs.getString("cmt_ip"));
				
				boardCommentList.add(bcDTO);
				
			}
			System.out.println("@@@@@@@@@@@@@2222222@@@@@@@@@@@@@@@@");
			System.out.println(startRow);
			System.out.println(pageSize);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    	return boardCommentList;
    }
    // getBoardCommentList(startRow, pageSize)
    /********************************************************************/
    
    
    /********************************************************************/
    
    // getCommentList(int board_num); - 해당 번호의 댓글만 가져오는함수
    public ArrayList getCommentList(int board_num){
    	
    	ArrayList commentList = new ArrayList();
    	
    	boardCommentDTO bcDTO = null;
    	
    	try {
			
			conn = getConnection();
			
			sql = "select * from normal_board_comment  where board_num=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, board_num);

			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				bcDTO = new boardCommentDTO();
				
				bcDTO.setCmt_num(rs.getInt("cmt_num"));
				bcDTO.setUser_nick(rs.getString("user_nick"));
				bcDTO.setCmt_content(rs.getString("cmt_content"));
				bcDTO.setCmt_date(rs.getString("cmt_date"));
				bcDTO.setCmt_ip(rs.getString("cmt_ip"));
				
				commentList.add(bcDTO);
			}
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}
    	
    	return commentList;
    }
    
    // getCommentList();
    
    
    /********************************************************************/
    
    
    /********************************************************************/
    
    // BoardCommentModify(bcDTO)
    public void BoardCommentModify(boardCommentDTO bcDTO){
    	
    	try {
    		conn = getConnection();
    	
    		sql="update normal_board_comment set cmt_content=?, cmt_date=now() where cmt_num=?";
    	
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, bcDTO.getCmt_content());
			pstmt.setInt(2, bcDTO.getCmt_num());
			
			pstmt.executeUpdate();
			
			System.out.println("DAO : 댓글수정완료");
			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    	
    }
    
    // BoardCommentModify(bcDTO)
    
    /********************************************************************/
    
    /********************************************************************/

    // boardCommentDelete(cmt_num)
    public void boardCommentDelete(int cmt_num){
    	
    	try {
    		conn = getConnection();
    	
    		sql="delete from normal_board_comment where cmt_num=?";
    	
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, cmt_num);
			
			pstmt.executeUpdate();
			
			System.out.println("DAO : 댓글 삭제완료");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    }
    // boardCommentDelete(cmt_num)
    
    /********************************************************************/
    
    
    /********************************************************************/
    /********************************************************************/
    /********************************************************************/
    /********************************************************************/
    /********************************************************************/
    /********************************************************************/
    /********************************************************************/








































}
