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
			
			sql = "insert into declaration_board values(?,?,?,?,?,?,now(),?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setInt(2, dcDTO.getBoard_type());
			pstmt.setInt(3, dcDTO.getBoard_num());
			pstmt.setString(4, dcDTO.getUser_nick());
			pstmt.setInt(5, dcDTO.getDecl_reason());
			pstmt.setString(6, dcDTO.getDecl_content());
			pstmt.setString(7, dcDTO.getDecl_writer());
			
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
    public List getDecl_normal_list(){
    	List decl_normal_list = new ArrayList();
    	
    	try {
    		conn = getConnection();
    	
    		sql = "select * from declaration_board natural join "
    				+ "(select board_num, count(board_num) cnt "
    				+ " from declaration_board "
    				+ " group by(board_num)) board_cnt "
    				+ "where board_type = 0 "
    				+ "order by cnt desc; ";
    	
			pstmt = conn.prepareStatement(sql);
			
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
