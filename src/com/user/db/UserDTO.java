package com.user.db;

import java.sql.Timestamp;

public class UserDTO {
	
	private int num; //회원번호
	private String id; //아이디
	private String nickname; //닉네임
	private String pw; //비밀번호
	private Timestamp joindate; //회원가입 한 날짜
	private int coin; //코인 *현금으로 충전
	private String phone; //휴대폰 번호
	private String address; //주소
	private String addressPlus; //상세주소
	private String bankName; //은행명
	private String bankAccount; //은행 계좌번호
	private String picture; //프로필 사진 기본 'default_image.png'
	private int auth; //권한 // '0':일반 사용자  //'1':운영자
	private int grade; //회원등급 *어디다 쓰는지 모르겠음
	private int use_yn; //User 탈퇴 시 '1' 처리
	
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public Timestamp getJoindate() {
		return joindate;
	}
	public void setJoindate(Timestamp joindate) {
		this.joindate = joindate;
	}
	public int getCoin() {
		return coin;
	}
	public void setCoin(int coin) {
		this.coin = coin;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddressPlus() {
		return addressPlus;
	}
	public void setAddressPlus(String addressPlus) {
		this.addressPlus = addressPlus;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getBankAccount() {
		return bankAccount;
	}
	public void setBankAccount(String bankAccount) {
		this.bankAccount = bankAccount;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	public int getAuth() {
		return auth;
	}
	public void setAuth(int auth) {
		this.auth = auth;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public int getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(int use_yn) {
		this.use_yn = use_yn;
	}
	
	
}
