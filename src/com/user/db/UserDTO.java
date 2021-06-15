package com.user.db;

import java.sql.Timestamp;

public class UserDTO {
	
	private int user_num; //회원번호
	private String user_id; //아이디
	private String user_nickname; //닉네임
	private String user_pw; //비밀번호
	private Timestamp user_joindate; //회원가입 한 날짜
	private int user_coin; //코인 *현금으로 충전
	private String user_phone; //휴대폰 번호
	private String user_address; //주소
	private String user_addressPlus; //상세주소
	private String user_bankName; //은행명
	private String user_bankAccount; //은행 계좌번호
	private String user_picture; //프로필 사진 기본 'default_image.png'
	private int user_auth; //권한 // '0':일반 사용자  //'1':운영자
	private int user_grade; //회원등급 *어디다 쓰는지 모르겠음
	private int user_use_yn; //User 탈퇴 시 '1' 처리
	
	public int getUser_num() {
		return user_num;
	}
	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_nickname() {
		return user_nickname;
	}
	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	public Timestamp getUser_joindate() {
		return user_joindate;
	}
	public void setUser_joindate(Timestamp user_joindate) {
		this.user_joindate = user_joindate;
	}
	public int getUser_coin() {
		return user_coin;
	}
	public void setUser_coin(int user_coin) {
		this.user_coin = user_coin;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getUser_address() {
		return user_address;
	}
	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}
	public String getUser_addressPlus() {
		return user_addressPlus;
	}
	public void setUser_addressPlus(String user_addressPlus) {
		this.user_addressPlus = user_addressPlus;
	}
	public String getUser_bankName() {
		return user_bankName;
	}
	public void setUser_bankName(String user_bankName) {
		this.user_bankName = user_bankName;
	}
	public String getUser_bankAccount() {
		return user_bankAccount;
	}
	public void setUser_bankAccount(String user_bankAccount) {
		this.user_bankAccount = user_bankAccount;
	}
	public String getUser_picture() {
		return user_picture;
	}
	public void setUser_picture(String user_picture) {
		this.user_picture = user_picture;
	}
	public int getUser_auth() {
		return user_auth;
	}
	public void setUser_auth(int user_auth) {
		this.user_auth = user_auth;
	}
	public int getUser_grade() {
		return user_grade;
	}
	public void setUser_grade(int user_grade) {
		this.user_grade = user_grade;
	}
	public int getUser_use_yn() {
		return user_use_yn;
	}
	public void setUser_use_yn(int user_use_yn) {
		this.user_use_yn = user_use_yn;
	}
	
	
	
}
