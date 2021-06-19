package com.board.comment.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
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
			(DataSource) initCTX.lookup("java:comp/env/jdbc/Marketdb");
			
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
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    }
    // insertBoardComment(board_num, bcDAO)
    
    /********************************************************************/
    
    
    /********************************************************************/
    
    /********************************************************************/
    
    
    /********************************************************************/
    
    /********************************************************************/
    
    
    /********************************************************************/
    
    /********************************************************************/
    /********************************************************************/
    /********************************************************************/
    /********************************************************************/
    /********************************************************************/
    /********************************************************************/
    /********************************************************************/
    /********************************************************************/
    /********************************************************************/








































}
