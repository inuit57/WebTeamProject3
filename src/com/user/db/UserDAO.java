
package com.user.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class UserDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = "";

	// 디비연결 필요정보
	public Connection getConnection() {
		try {
			// Context 객체를 생성
			Context initCTX = new InitialContext();

			DataSource ds = (DataSource) initCTX.lookup("java:comp/env/jdbc/MarketDB");

			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		} catch (NamingException e) {
			e.printStackTrace();
		}
		return conn;
	} // getConnection() end

	// DB close() 시작
	public void closeDB() {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void insertUser(UserDTO udto) {
		// 회원가입 시 정보 DB INSERT
		try {
			conn = getConnection();

			sql = "INSERT INTO member(user_id,user_nickname,user_pw,user_joindate,user_coin,user_phone,user_address,user_address_plus,user_bankname,user_bankaccount,user_picture,user_auth,user_grade,user_use_yn) "
					+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, udto.getUser_id());
			pstmt.setString(2, udto.getUser_nickname());
			pstmt.setString(3, udto.getUser_pw());
			pstmt.setTimestamp(4, udto.getUser_joindate());
			pstmt.setInt(5, udto.getUser_coin());
			pstmt.setString(6, udto.getUser_phone());
			pstmt.setString(7, udto.getUser_address());
			pstmt.setString(8, udto.getUser_addressPlus());
			pstmt.setString(9, udto.getUser_bankName());
			pstmt.setString(10, udto.getUser_bankAccount());
			pstmt.setString(11, udto.getUser_picture());
			pstmt.setInt(12, udto.getUser_auth());
			pstmt.setInt(13, udto.getUser_grade());
			pstmt.setInt(14, udto.getUser_use_yn());

			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.toString());
			System.out.println("UserDAO.insertUser() function Error - KBH");
		} finally {
			closeDB();
		}

	}
	
	public String getId(String nick){
		String id = null ; 
		try {
			conn = getConnection(); 
			sql = "select user_id from member where user_nickname=?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nick);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()){
				id = rs.getString(1); 
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return id;  
	}

	public boolean checkNick(String a) {
		// 닉네임 조회하는 함수
		boolean tmp = false;

		try {
			conn = getConnection();

			sql = "SELECT user_nickname FROM member WHERE user_nickname=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, a);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				tmp = true;
			} else {
				tmp = false;
			}
		} catch (Exception e) {
			System.out.println(e.toString());
			System.out.println("UserDAO.checkNick() function error - KBH");
		} finally {
			closeDB();
		}
		return tmp;
	}
	
	public String searchID(String user_phone) {
		// 폰번호에 따른 아이디 조회하는 함수
		String user_id = "";

		try {
			conn = getConnection();

			sql = "SELECT user_id FROM member WHERE user_phone=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_phone);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				user_id = rs.getString(1);
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		} finally {
			closeDB();
		}
		return user_id;
	}
	
	
	
	//checkPhone(user_phone)
	public boolean checkPhone(String user_phone) {
		// 전화번호 조회하는 함수
		boolean tmp = false;

		try {
			conn = getConnection();

			sql = "SELECT user_phone FROM member WHERE user_phone=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_phone);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				tmp = true;
			} else {
				tmp = false;
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		} finally {
			closeDB();
		}
		return tmp;
	}
	//checkPhone(user_phone)

	
	
	
	
	public boolean checkId(String a) {
		// 아이디(이메일) 조회하는 함수
		boolean tmp = false;

		try {
			conn = getConnection();
			sql = "SELECT user_id FROM member WHERE user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, a);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				tmp = true;
			} else {
				tmp = false;
			}
		} catch (Exception e) {
			System.out.println(e.toString());
			System.out.println("UserDAO.checkNick() function error - KBH");
		} finally {
			closeDB();
		}
		return tmp;
	}
	
	public String checkEmail(String a) {
		// 아이디(이메일) 조회하는 함수
		String user_nick = null;

		try {
			conn = getConnection();
			sql = "SELECT user_id, user_nickname FROM member WHERE user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, a);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				user_nick = rs.getString(2);
			} 
		} catch (Exception e) {
			System.out.println(e.toString());
			System.out.println("UserDAO.checkNick() function error - KBH");
		} finally {
			closeDB();
		}
		return user_nick;
	}

	public String Login(String id, String pw) {

	      boolean b = false;
	      String user_nick = null;
	      System.out.println("id :: " + id ); // ok 

	      try {
	         conn = getConnection();
	         sql = "SELECT user_pw, user_use_yn, user_nickname FROM member WHERE user_id=?";
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, id);
	         rs = pstmt.executeQuery();
	         if (rs.next()) {
	        	System.out.println("PW : " + rs.getString("user_pw"));
	            if (rs.getString(1).equals(pw)) {
	               if (rs.getInt(2) == 1) { // 1 : 사용 , 2 : 탈퇴된 회원 
	                  user_nick = rs.getString(3);
	                  System.out.println("user_nick : " + user_nick);
	               } else {
	                  b = false;
	               }
	            } else {
	               b = false;
	            }
	         } else {
	        	 System.out.println("찾는 회원 정보 없음!!");
	            b = false;
	         }
	      } catch (Exception e) {
	         System.out.println(e.toString());
	         System.out.println("UserDAO.Login() function error - KBH");
	      } finally {
	         closeDB();
	      }

	      return user_nick;
	   }

	public UserDTO getUserInfo(String user_nick) {

		UserDTO udto = new UserDTO();

		try {
			conn = getConnection();
			sql = "SELECT * FROM member WHERE user_nickname=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_nick);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				udto.setUser_nickname(rs.getString("user_nickname"));
				udto.setUser_id(rs.getString("user_id"));
				udto.setUser_pw(rs.getString("user_pw"));
				udto.setUser_joindate(rs.getTimestamp("user_joindate"));
				udto.setUser_phone(rs.getString("user_phone"));
				udto.setUser_address(rs.getString("user_address"));
				udto.setUser_addressPlus(rs.getString("user_address_plus"));
				udto.setUser_picture(rs.getString("user_picture"));
				udto.setUser_bankName(rs.getString("user_bankname"));
				udto.setUser_bankAccount(rs.getString("user_bankaccount"));
			}
		} catch (Exception e) {
			System.out.println(e.toString());
			System.out.println("UserDAO.getUserInfo() function error - KBH");
		} finally {
			closeDB();
		}

		return udto;
	}
	
	public void userDelete(String id) {
		try {
			conn = getConnection();
			sql = "UPDATE member SET user_use_yn=2 WHERE user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.toString());
			System.out.println("UserDAO.userDelete() function error - KBH");
		} finally {
			closeDB();
		}
	}
	
	public void userInfoEdit(UserDTO udto) {
		try {
			conn = getConnection();
			sql = "UPDATE member SET user_phone=?, user_address=?, user_address_plus=?, user_picture=? , user_nickname=? WHERE user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, udto.getUser_phone());
			pstmt.setString(2, udto.getUser_address());
			pstmt.setString(3, udto.getUser_addressPlus());
			pstmt.setString(4, udto.getUser_picture());
			pstmt.setString(5, udto.getUser_nickname());
			pstmt.setString(6, udto.getUser_id());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println(e.toString());
			System.out.println("UserDAO.UserInfoEdit() function error - KBH");
		} finally {
			closeDB();
		}
	}
	
	public void changePassword(String id,String new_pw) {
		try {
			conn = getConnection();
			sql = "UPDATE member SET user_pw=? WHERE user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, new_pw);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.toString());
			System.out.println("UserDAO.UserInfoEdit() function error - KBH");
		} finally {
			closeDB();
		}
		
	}
	
	public void updatePW(String user_pw, String user_phone , String user_id) {
		try {
			conn = getConnection();
			if(user_phone.equals("0")){
				sql = "UPDATE member SET user_pw=? WHERE user_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, user_pw);
				pstmt.setString(2, user_id);
			}else{
				sql = "UPDATE member SET user_pw=? WHERE user_phone=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, user_pw);
				pstmt.setString(2, user_phone);
			}
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		} finally {
			closeDB();
		}
		
	}
	
	public String getUserNick(String id) {
		
		String nick = null;
		
		try {
			conn = getConnection();
			sql = "SELECT user_nickname FROM user WHERE user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				nick = rs.getString(1);
			}
		} catch (Exception e) {
			System.out.println(e.toString());
			System.out.println("UserDAO.getUserNick() function error - KBH");
		}
		return nick;
	}
	
	public boolean isAdmin(String user_nick){
		
		try {
			conn = getConnection(); 
			sql = "select user_auth from member where user_nickname = ?" ; 
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, user_nick);
			rs = pstmt.executeQuery(); 
			
			if(rs.next()){
				if(rs.getInt(1) == 2){ // 일반회원 1 , 관리자 2 
					return true ; 
				}else{
					return false ; 
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		} 
		
		return false; 
	}
	
	
	public void changeBankAccount(String id, String bankName, String bankAccount) {
		
		int result = 0;
		
		try {
			conn = getConnection();
			sql = "UPDATE member SET user_bankname=?, user_bankaccount=? WHERE user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bankName);
			pstmt.setString(2, bankAccount);
			pstmt.setString(3, id);
			
			result = pstmt.executeUpdate();
			
			if(result==1) {
				sql= "update member set user_grade=2 where user_id=?";
				pstmt= conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.executeUpdate();
				
			}
			
		} catch (Exception e) {
			System.out.println(e.toString());
			System.out.println("UserDAO.changeBankAccount() function error - KBH");
		} finally {
			closeDB();
		}
	}
	
	public void charge(String user_nickname, int totalamount){
		try {
			conn = getConnection();
			sql = "SELECT user_coin FROM member WHERE user_nickname=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_nickname);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				System.out.println("=========================");
				System.out.println(totalamount);
				System.out.println(rs.getInt(1));
				totalamount += rs.getInt(1);
				System.out.println(totalamount);
			}
			
			sql = "UPDATE member SET user_coin=? WHERE user_nickname=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, totalamount);
			pstmt.setString(2, user_nickname);
			pstmt.executeUpdate();
		} catch (Exception e) {
			   e.printStackTrace();
		} finally {
			closeDB();
		}
		
	}
	
	
	
	public int getCoin(String user_nickname){
		int result = 0;
		try {
			conn = getConnection();
			sql = "SELECT user_coin FROM member WHERE user_nickname=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_nickname);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			} 
		} catch (Exception e) {
			System.out.println(e.toString());
			System.out.println("UserDAO.checkNick() function error - KBH");
		} finally {
			closeDB();
		}
		return result;
	}
	
	
	public String getProfile(String user_nickname){
		String user_profile = "";
		try {
			conn = getConnection();
			sql = "SELECT user_picture FROM member WHERE user_nickname=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_nickname);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				user_profile = rs.getString(1);
			}
		} catch (Exception e) {
			System.out.println(e.toString());
			System.out.println("UserDAO.checkNick() function error - KBH");
		} finally {
			closeDB();
		}
		return user_profile;
	}

	/**
	 * member 테이블에 있는 user 정보 중 coin을 증가/감소 시켜주는 함수 
	 * 
	 * @param user_nick  : 유저(대상)
	 * @param prod_price : 증가시킬 코인량
	 * @param isPlus : true (증가) , false(감소)
	 */
	public void updateCoin(String user_nick, int prod_price, boolean isPlus) {

		conn = getConnection();
		
		try {
			if(isPlus){ //증가
				sql = " update member set user_coin = user_coin + ? where user_nickname=?";
			}else{ // 감소
				sql = " update member set user_coin = user_coin - ? where user_nickname=?"; 
			}
		
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, prod_price);
			pstmt.setString(2, user_nick);
			
			pstmt.executeUpdate(); 
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB(); 
		} 
	}
	// checkGrade(user_nick) 유저 등급 가져오는 메서드
	public int checkGrade(String user_nick){
		int grade = 0;
		try {
			conn = getConnection();
			
			sql = "select user_grade from member where user_nickname=?";
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, user_nick);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				grade=rs.getInt("user_grade");
			}
			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return grade;
	}
	
	
}
