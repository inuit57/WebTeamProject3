package com.auction.db;

import java.sql.Timestamp;

public class AuctionDTO {

	private int auct_num;
	private String user_nick;
	private int auct_status;
	private String auct_sub;
	private String auct_content;
	private int auct_price;
	private String auct_img;
	private Timestamp auct_date;
	private String auct_ip;
	private int auct_count;
	public int getAuct_num() {
		return auct_num;
	}
	public void setAuct_num(int auct_num) {
		this.auct_num = auct_num;
	}
	public String getUser_nick() {
		return user_nick;
	}
	public void setUser_nick(String user_nick) {
		this.user_nick = user_nick;
	}
	public int getAuct_status() {
		return auct_status;
	}
	public void setAuct_status(int auct_status) {
		this.auct_status = auct_status;
	}
	public String getAuct_sub() {
		return auct_sub;
	}
	public void setAuct_sub(String auct_sub) {
		this.auct_sub = auct_sub;
	}
	public String getAuct_content() {
		return auct_content;
	}
	public void setAuct_content(String auct_content) {
		this.auct_content = auct_content;
	}
	public int getAuct_price() {
		return auct_price;
	}
	public void setAuct_price(int auct_price) {
		this.auct_price = auct_price;
	}
	public String getAuct_img() {
		return auct_img;
	}
	public void setAuct_img(String auct_img) {
		this.auct_img = auct_img;
	}
	public Timestamp getAuct_date() {
		return auct_date;
	}
	public void setAuct_date(Timestamp auct_date) {
		this.auct_date = auct_date;
	}
	public String getAuct_ip() {
		return auct_ip;
	}
	public void setAuct_ip(String auct_ip) {
		this.auct_ip = auct_ip;
	}
	public int getAuct_count() {
		return auct_count;
	}
	public void setAuct_count(int auct_count) {
		this.auct_count = auct_count;
	}
	@Override
	public String toString() {
		return "AuctionDTO [auct_num=" + auct_num + ", user_nick=" + user_nick + ", auct_status=" + auct_status
				+ ", auct_sub=" + auct_sub + ", auct_content=" + auct_content + ", auct_price=" + auct_price
				+ ", auct_img=" + auct_img + ", auct_date=" + auct_date + ", auct_ip=" + auct_ip + ", auct_count="
				+ auct_count + "]";
	}
	
	
	
	
}
