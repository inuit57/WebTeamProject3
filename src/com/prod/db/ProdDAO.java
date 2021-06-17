package com.prod.db;

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

public class ProdDAO {
	
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
	
	//insertProduct(pDTO) 중고거래 상품 글 등록
	public void insertProduct(ProdDTO pDTO){
		
		int num = 0; 
		
		try {
			
			conn = getConnection();
			sql = "select max(prod_num) from prod_trade";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				num = rs.getInt(1)+1;
			}
			
			sql = "insert into prod_trade "
					+ "values(?,?,?,?,?,?,?,?,now(),?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, pDTO.getUser_nick());
			pstmt.setInt(3, pDTO.getProd_category());
			pstmt.setInt(4, pDTO.getProd_status());
			pstmt.setString(5, pDTO.getProd_sub());
			pstmt.setString(6, pDTO.getProd_content());
			pstmt.setInt(7, pDTO.getProd_price());
			pstmt.setString(8, pDTO.getProd_img());
			pstmt.setString(9, pDTO.getProd_ip());
			pstmt.setInt(10, pDTO.getProd_count());
			
			pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
	}//insertProduct(pDTO) 중고거래 상품 글 등록
	
	
	//productList() 중고거래 상품 글 리스트
	public List getProductList() {
		List productList = new ArrayList();
		
		try {
			
			conn = getConnection();
			sql = "select * prod_trade";
			
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProdDTO pDTO = new ProdDTO();
				
				pDTO.setProd_category(rs.getInt("prod_category"));
				pDTO.setProd_content(rs.getString("prod_content"));
				pDTO.setProd_count(rs.getInt("prod_count"));
				pDTO.setProd_date(rs.getTimestamp("prod_date"));
				pDTO.setProd_img(rs.getString("prod_img"));
				pDTO.setProd_ip(rs.getString("prod_ip"));
				pDTO.setProd_num(rs.getInt("prod_num"));
				pDTO.setProd_price(rs.getInt("prod_price"));
				pDTO.setProd_status(rs.getInt("prod_status"));
				pDTO.setProd_sub(rs.getString("prod_sub"));
				pDTO.setUser_nick(rs.getString("user_nick"));
				
				productList.add(pDTO);
				
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return productList;
	}//productList() 중고거래 상품 글 리스트
	
	//getProductList(item) 상품 카테고리 글 리스트
	public List getProductList(String item) {
	
		List productList = new ArrayList();
		
		StringBuffer SQL = new StringBuffer();
		
		try {
			
			conn = getConnection();
			SQL.append("select * from prod_trade");
			
			if(item.equals("all")) {
			}else {
				SQL.append(" where prod_category=?");
			}
			
			pstmt = conn.prepareStatement(SQL+"");
			
			if(item.equals("all")) {
			}else {
				pstmt.setString(1, item);
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProdDTO pDTO = new ProdDTO();
				
				pDTO.setProd_category(rs.getInt("prod_category"));
				pDTO.setProd_content(rs.getString("prod_content"));
				pDTO.setProd_count(rs.getInt("prod_count"));
				pDTO.setProd_date(rs.getTimestamp("prod_date"));
				pDTO.setProd_img(rs.getString("prod_img"));
				pDTO.setProd_ip(rs.getString("prod_ip"));
				pDTO.setProd_num(rs.getInt("prod_num"));
				pDTO.setProd_price(rs.getInt("prod_price"));
				pDTO.setProd_status(rs.getInt("prod_status"));
				pDTO.setProd_sub(rs.getString("prod_sub"));
				pDTO.setUser_nick(rs.getString("user_nick"));
				
				productList.add(pDTO);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return productList;
	}//getProductList(item) 상품 카테고리 글 리스트
	
	
	
	
	
	
	
	
	
	
	

}
