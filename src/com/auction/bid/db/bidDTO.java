package com.auction.bid.db;

import java.sql.Timestamp;

public class bidDTO {

	private int bid_num;
	private int auct_num;
	private String user_nick;
	private int user_coin;
	private Timestamp bid_date;
	private Timestamp bid_suc;
	private int bid_coin;
	
	
	
	public int getBid_coin() {
		return bid_coin;
	}
	public void setBid_coin(int bid_coin) {
		this.bid_coin = bid_coin;
	}
	public int getBid_num() {
		return bid_num;
	}
	public void setBid_num(int bid_num) {
		this.bid_num = bid_num;
	}
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
	public int getUser_coin() {
		return user_coin;
	}
	public void setUser_coin(int user_coin) {
		this.user_coin = user_coin;
	}
	public Timestamp getBid_date() {
		return bid_date;
	}
	public void setBid_date(Timestamp bid_date) {
		this.bid_date = bid_date;
	}
	public Timestamp getBid_suc() {
		return bid_suc;
	}
	public void setBid_suc(Timestamp bid_suc) {
		this.bid_suc = bid_suc;
	}
	@Override
	public String toString() {
		return "bidDTO [bid_num=" + bid_num + ", auct_num=" + auct_num + ", user_nick=" + user_nick + ", user_coin="
				+ user_coin + ", bid_date=" + bid_date + ", bid_suc=" + bid_suc + ", bid_coin=" + bid_coin + "]";
	}
	
}
