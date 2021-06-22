
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

			sql = "INSERT INTO user(user_id,user_nickname,user_pw,user_joindate,user_coin,user_phone,user_address,user_address_plus,user_bankname,user_bankaccount,user_picture,user_auth,user_grade,user_use_yn) "
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

	public boolean checkNick(String a) {
		// 닉네임 조회하는 함수
		boolean tmp = false;

		try {
			conn = getConnection();
			sql = "SELECT user_nickname FROM user WHERE user_nickname=?";
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

	public boolean checkId(String a) {
		// 아이디(이메일) 조회하는 함수
		boolean tmp = false;

		try {
			conn = getConnection();
			sql = "SELECT user_id FROM user WHERE user_id=?";
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

	public boolean Login(String id, String pw) {

		boolean b = false;

		try {
			conn = getConnection();
			sql = "SELECT user_pw, user_use_yn FROM user WHERE user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1).equals(pw)) {
					if (rs.getInt(2) == 0) {
						b = true;
					} else {
						b = false;
					}
				} else {
					b = false;
				}
			} else {
				b = false;
			}
		} catch (Exception e) {
			System.out.println(e.toString());
			System.out.println("UserDAO.Login() function error - KBH");
		} finally {
			closeDB();
		}

		return b;
	}

	public UserDTO getUserInfo(String id) {

		UserDTO udto = new UserDTO();

		try {
			conn = getConnection();
			sql = "SELECT * FROM user WHERE user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				udto.setUser_id(rs.getString("user_id"));
				udto.setUser_pw(rs.getString("user_pw"));
				udto.setUser_joindate(rs.getTimestamp("user_joindate"));
				udto.setUser_phone(rs.getString("user_phone"));
				udto.setUser_address(rs.getString("user_address"));
				udto.setUser_addressPlus(rs.getString("user_address_plus"));
				udto.setUser_picture(rs.getString("user_picture"));
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
			sql = "UPDATE user SET user_use_yn=1 WHERE user_id=?";
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
			sql = "UPDATE user SET user_phone=?, user_address=?, user_address_plus=?, user_picture=? WHERE user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, udto.getUser_phone());
			pstmt.setString(2, udto.getUser_address());
			pstmt.setString(3, udto.getUser_addressPlus());
			pstmt.setString(4, udto.getUser_picture());
			pstmt.setString(5, udto.getUser_id());
			
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
			sql = "UPDATE user SET user_pw=? WHERE user_id=?";
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
	
	

}
