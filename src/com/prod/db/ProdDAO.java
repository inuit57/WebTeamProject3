package com.prod.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
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
					+ "values(?,?,?,?,?"
					+ ",?,?,?,now(),?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, pDTO.getUser_nickname());
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
				pDTO.setUser_nickname(rs.getString("user_nick"));
				
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
		
		//StringBuffer SQL = new StringBuffer();
		try {
			
			conn = getConnection();
			//SQL.append("select * from prod_trade order by prod_num desc");
			
			 
			if(item.equals("all")) {
				sql = "select * from prod_trade order by prod_num desc" ;
			}else {
				//SQL.append(" where prod_category=?");
				sql = "select * from prod_trade where prod_category=? order by prod_num desc " ;
			}
			
			//pstmt = conn.prepareStatement(SQL+"");
			pstmt = conn.prepareStatement(sql);
			
//			if(item.equals("all")) {
//			}else {
//				pstmt.setString(1, item);
//			}
			if(! item.equals("all")) {
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
				pDTO.setUser_nickname(rs.getString("user_nick"));

				
				productList.add(pDTO);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return productList;
	}//getProductList(item) 상품 카테고리 글 리스트
	
	
	public List getProductList(ProdSearch prodSearch) {
		
		List productList = new ArrayList();
		
		//StringBuffer SQL = new StringBuffer();
		try {
			
			conn = getConnection();
			//SQL.append("select * from prod_trade order by prod_num desc");
			
			String item = prodSearch.getItem(); 
			String search_type = prodSearch.getSearch_type(); 
			String search_text = prodSearch.getSearch_text(); 
			String min_price = prodSearch.getMin_price(); 
			String max_price = prodSearch.getMax_price(); 
			
			System.out.println(prodSearch);
			
			
			// 아이템에 대한 처리 
			if(item.equals("all")) {
				sql = "select * from prod_trade where 1=1 " ;
			}else {
				//SQL.append(" where prod_category=?");
				sql = "select * from prod_trade where prod_category=? " ;
			}
			
			// 검색어가 있는 경우의 처리 
			if(search_text != null && !search_text.equals("")){
				if(search_type.equals("seller")){
					sql += " and user_nick like ? "; 
				}else{
					sql += " and prod_sub like ? or prod_content like ? ";
				}
			}
			
			//가격에 대한 처리
			sql += " and prod_price >= ?";
			if (max_price != null && !max_price.equals("")){
				sql+= " and prod_price <= ?";
			}
			
			sql +=" and prod_status != 3 order by prod_num desc";
			
			//pstmt = conn.prepareStatement(SQL+"");
			pstmt = conn.prepareStatement(sql);
			
			int index = 1; 
			
			if(! item.equals("all")) {
				pstmt.setString(index, item);
				index ++; 
			}
			
			if(search_text != null && !search_text.equals("")){
				if(search_type.equals("seller")){
					pstmt.setString(index, "%"+search_text+"%"); 
					index ++ ; 
				}else{
					pstmt.setString(index, "%"+search_text+"%");
					pstmt.setString(index+1, "%"+search_text+"%");
					
					index +=2; 
				}
			}
			System.out.println(pstmt);
			//최소가격
			pstmt.setInt(index, Integer.parseInt(min_price));
			index ++ ; 
			
			if (max_price != null && !max_price.equals("")){
				pstmt.setInt(index, Integer.parseInt(max_price));
				index ++; 
			}
			
			
			System.out.println(pstmt);
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
				pDTO.setUser_nickname(rs.getString("user_nick")); // user_nick으로 이건 되어있습니다. (엑셀문서상)

				
				productList.add(pDTO);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return productList;
	}//getProductList(item) 상품 카테고리 글 리스트
	
	//getProduct(num) 상품 가져오기
	public ProdDTO getProduct(int num) {
		ProdDTO pDTO = null;
		
		try {
			
			conn = getConnection();
			sql = "select * from prod_trade where prod_num=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				pDTO = new ProdDTO();
				
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
				pDTO.setUser_nickname(rs.getString("user_nick"));
				
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return pDTO;
	}//getProduct(num) 상품 가져오기
	

	//getProductCount() 디비에 저장된 중고거래 글 갯수 계산
	public int getProductCount() {
		int cnt = 0;
		
		try {
			
			conn = getConnection();
			sql = "select count(*) from prod_trade";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				cnt = rs.getInt(1);
				
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return cnt;
	}//getProductCount() 디비에 저장된 중고거래 글 갯수 계산
	
	
	//getProductList(startRow,pageSize) 원하는 만큼 거래글 가져오기
	public ArrayList getProductList(int startRow,int pageSize) {
		
		ArrayList productList = new ArrayList();
		ProdDTO pDTO = null;
		
		try {
			
			conn = getConnection();
			sql = "select * from prod_trade order by prod_num desc "
					+ "limit ?,?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				pDTO = new ProdDTO();
				
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
				pDTO.setUser_nickname(rs.getString("user_nick"));
				
				productList.add(pDTO);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return productList;
	}//getProductList(startRow,pageSize) 원하는 만큼 거래글 가져오기
	
	//getProductUpdate(pDAO) 중고거래 글 수정
	public void getProductUpdate(ProdDTO pDTO) {
		
		try {
			
			conn = getConnection();
			sql = "update prod_trade set "//카테고리, 거래여부, 이름, 가격, 글제목, 글내용, 파일
					+ "prod_category=?, prod_status=?, user_nick=?, "
					+ "prod_price=?, prod_sub=?, prod_content=?, prod_img=? "
					+ "where prod_num=?";
			pstmt = conn.prepareStatement(sql);
			System.out.println(pDTO.getProd_num());
			
			pstmt.setInt(1, pDTO.getProd_category());
			pstmt.setInt(2, pDTO.getProd_status());
			pstmt.setString(3, pDTO.getUser_nickname());
			pstmt.setInt(4, pDTO.getProd_price());
			pstmt.setString(5, pDTO.getProd_sub());
			pstmt.setString(6, pDTO.getProd_content());
			pstmt.setString(7, pDTO.getProd_img());
			pstmt.setInt(8, pDTO.getProd_num());
			
			pstmt.executeUpdate();
			
			
			
			System.out.println(pDTO.getProd_num());
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
	}//getProductUpdate(pDAO) 중고거래 글 수정
	
	//deleteProduct(num) 중고거래 글 삭제!!
	public void deleteProduct(int num) {
		
		try {
			
			conn = getConnection();
			sql = "delete from prod_trade where prod_num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
	}//deleteProduct(num) 중고거래 글 삭제!!
	
	//updateCount(num) 조회수 증가
	public void updateCount(int num) {
		
		try {
			
			conn = getConnection();
			
			sql = "update prod_trade set prod_count=prod_count+1 where prod_num=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeDB();
		}
	}//updateCount(pDTO) 조회수 증가
	
	
	public String timeForToday(int num){
		Timestamp now_t = new Timestamp(System.currentTimeMillis()); 
		Timestamp prod_t ; 
		long betweenTime  = 0L ; 
		
		String timeForToday =""; 
		
		System.out.println(now_t);
		
		try {
			conn = getConnection();
			sql = "select prod_date from prod_trade where prod_num=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery(); 
			
			if(rs.next()){
				prod_t = rs.getTimestamp(1); 
				betweenTime = (long)Math.floor((now_t.getTime() - prod_t.getTime()) / 1000 / 60);
				long betweenTimeHour = (long)Math.floor(betweenTime / 60);
				long betweenTimeDay = (long)Math.floor(betweenTime / 60 / 24);
				
				if (betweenTime < 1) timeForToday = "방금전";
				else if (betweenTime < 60) {
		        	timeForToday = betweenTime +"분전";
				}else if (betweenTimeHour < 24) {
		        	timeForToday = betweenTimeHour+ "시간전";
		        }else if (betweenTimeDay < 365) {
		        	timeForToday = betweenTimeDay +"일전";
		        }else{
		        	timeForToday = (long)Math.floor(betweenTimeDay / 365)+"년전";
		        }
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		} 
		
		return timeForToday; 
	}
	
	

}
