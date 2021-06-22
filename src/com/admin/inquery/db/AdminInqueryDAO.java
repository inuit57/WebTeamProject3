package com.admin.inquery.db;

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

import com.inquery.db.InqueryDTO;


public class AdminInqueryDAO {
	

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
    
    // getAdminInqueryList()
    public List getAdminInqueryList(){
    	
    	List aiList = new ArrayList();
    	
    	try {
    		conn = getConnection();
    		
    		sql = "select * from inquery order by inq_ref";
    		
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				InqueryDTO inDTO = new InqueryDTO();
				
				inDTO.setInq_content(rs.getString("inq_content"));
				inDTO.setInq_date(rs.getString("inq_date"));
				inDTO.setInq_img(rs.getString("inq_img"));
				inDTO.setInq_lev(rs.getInt("inq_lev"));
				inDTO.setInq_num(rs.getInt("inq_num"));
				inDTO.setInq_sub(rs.getString("inq_sub"));
				inDTO.setUser_nick(rs.getString("user_nick"));
				inDTO.setInq_check(rs.getString("inq_check"));
				inDTO.setInq_ref(rs.getInt("inq_ref"));
				
				aiList.add(inDTO);
			}
			
			System.out.println("DAO : 어드민 전체 리스트 담기 완료 !!!!");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
	
    	return aiList;
    }// getAdminInqueryList()
	
	// getAdminInqueryList(check)
    public List getAdminInqueryList(String check){
    	
    	List aiList = new ArrayList();
   
    	StringBuffer SQL = new StringBuffer();
    	
    	
    	try {
    		conn = getConnection();
    		
    		SQL.append("select * from inquery");
    		
    		if(check.equals("0")){
    			SQL.append(" where inq_check=0");
    		}else{
    			SQL.append(" where inq_check=1 order by inq_ref");
    		}
    		
			pstmt = conn.prepareStatement(SQL+"");
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				InqueryDTO inDTO = new InqueryDTO();
				
				inDTO.setInq_content(rs.getString("inq_content"));
				inDTO.setInq_date(rs.getString("inq_date"));
				inDTO.setInq_img(rs.getString("inq_img"));
				inDTO.setInq_lev(rs.getInt("inq_lev"));
				inDTO.setInq_num(rs.getInt("inq_num"));
				inDTO.setInq_sub(rs.getString("inq_sub"));
				inDTO.setUser_nick(rs.getString("user_nick"));
				inDTO.setInq_check(rs.getString("inq_check"));
				inDTO.setInq_ref(rs.getInt("inq_ref"));
				
				aiList.add(inDTO);
				
				
			}
			
			System.out.println("DAO : 관리자 리스트 check 리스트 담기 완료!!!");
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	
    	
    	return aiList;
    	
    }// getAdminInqueryList(check)
	
    // adminReWrite(inDTO)
    public void adminReWrite(InqueryDTO inDTO){
    		int num = 0;
    	
    	try {
    		
    		conn = getConnection();
    		
    		sql = "select max(inq_num) from inquery";
    		
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1) + 1;
			}
			
			// 임시로 만듬 나중에 세션값 제어할때 다시 inq_lev 값 받아서 작성
			sql = "insert into inquery(inq_num,user_nick,inq_sub,inq_content, "
					+ "inq_lev,inq_img,inq_date,inq_ref,inq_check) values(?,?,?,?,1,?,now(),?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, inDTO.getUser_nick());
			pstmt.setString(3, inDTO.getInq_sub());
			pstmt.setString(4, inDTO.getInq_content());
			pstmt.setString(5, inDTO.getInq_img());;
			pstmt.setInt(6, inDTO.getInq_num());
			pstmt.setString(7, "1");
			
			pstmt.executeUpdate();
			
			
			System.out.println("답글 작성완료!!!!!!!!!");
			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    	
    }// adminReWrite(inDTO)
    
    // getInqueryContent(num)
    public InqueryDTO getInqueryContent(int num){
    		
    		InqueryDTO inDTO = new InqueryDTO();
    	
    	try {
    		
    		conn = getConnection();
    		
    		sql = "select * from inquery where inq_num=?";
    		
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				
				inDTO.setInq_num(rs.getInt("inq_num"));
				inDTO.setUser_nick(rs.getString("user_nick"));
				inDTO.setInq_sub(rs.getString("inq_sub"));
				inDTO.setInq_content(rs.getString("inq_content"));
				inDTO.setInq_lev(rs.getInt("inq_lev"));
				inDTO.setInq_img(rs.getString("inq_img"));
				inDTO.setInq_date(rs.getString("inq_date"));
				inDTO.setInq_ref(rs.getInt("inq_ref"));
				inDTO.setInq_check(rs.getString("inq_check"));
				
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
 	
    	return inDTO;
    }
    // getInqueryContent(num)
    
    // adminCheckUpdate(inDTO)
    public void adminCheckUpdate(InqueryDTO inDTO){
    	
    	try {
    		
    		conn = getConnection();
    		
    		sql = "update inquery set inq_check=1 where inq_num=?";
    		
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, inDTO.getInq_num());
			
			pstmt.executeUpdate();
			
			
			System.out.println("체크컬럼 값 변경 완료!!!!!!!!!!!!!");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    	
    }// adminCheckUpdate(inDTO)
    
    
    // adminModify(inDTO)
    public void adminModify(InqueryDTO inDTO){
    	
    	
    	try {
    		conn = getConnection();
    		
    		sql = "update inquery set inq_sub=?, inq_content=? where inq_num=?";
    		
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, inDTO.getInq_sub());
			pstmt.setString(2, inDTO.getInq_content());
			pstmt.setInt(3, inDTO.getInq_num());
			
			pstmt.executeUpdate();
			
			System.out.println("DAO : admin권한 글 수정 완료!!!!!!!!!!!!!!!!!!!");
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    	
    	
    } // adminModify(inDTO)
    
    
    // adminDelete(num)
    public void adminDelete(int num){
    	
    	try {
    		conn = getConnection();
    		
    		sql = "delete from inquery where inq_num=?";
    		
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
			
			System.out.println("관리자 권한 글 삭제 완료 !!!!!!!!!!!!!!!"+num+"번글");
			

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
  	
    }// adminDelete(num)
    
    // inquerySearchList(sk,sv)
    public List inquerySearchList(String sk,String sv){
    	
    List inList = new ArrayList();
    InqueryDTO inDTO = null;
    	
    try {
    	conn = getConnection();
    	
    	sql = "select * from inquery where "+sk+" like '%"+sv+"%'";
    	
		pstmt = conn.prepareStatement(sql);
		
		rs = pstmt.executeQuery();
		
		while(rs.next()){
			inDTO = new InqueryDTO();
			
			inDTO.setInq_num(rs.getInt("inq_num"));
			inDTO.setUser_nick(rs.getString("user_nick"));
			inDTO.setInq_sub(rs.getString("inq_sub"));
			inDTO.setInq_content(rs.getString("inq_content"));
			inDTO.setInq_lev(rs.getInt("inq_lev"));
			inDTO.setInq_img(rs.getString("inq_img"));
			inDTO.setInq_date(rs.getString("inq_date"));
			inDTO.setInq_ref(rs.getInt("inq_ref"));
			inDTO.setInq_check(rs.getString("inq_check"));
			
			inList.add(inDTO);
		}
		System.out.println("검색 완료!@@@@@@@@@@");
		
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		closeDB();
	}
    
    return inList;
    	
    }// inquerySearchList(sk,sv)
    

}
