package com.wish.db;

import java.sql.Timestamp;

public class WishDTO {
	
	private int wish_num;
	private int prod_num;
	private String user_nick;
	private Timestamp wish_date;
	
	public int getWish_num() {
		return wish_num;
	}
	public void setWish_num(int wish_num) {
		this.wish_num = wish_num;
	}
	public int getProd_num() {
		return prod_num;
	}
	public void setProd_num(int prod_num) {
		this.prod_num = prod_num;
	}
	public String getUser_nick() {
		return user_nick;
	}
	public void setUser_nick(String user_nick) {
		this.user_nick = user_nick;
	}
	public Timestamp getWish_date() {
		return wish_date;
	}
	public void setWish_date(Timestamp wish_date) {
		this.wish_date = wish_date;
	}
	@Override
	public String toString() {
		return "WishDTO [wish_num=" + wish_num + ", prod_num=" + prod_num + ", user_nick=" + user_nick + ", wish_date="
				+ wish_date + "]";
	}
	
	
	

	
	

}
