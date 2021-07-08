package com.tradeLog.db;

import java.sql.Timestamp;

public class TradeLogDTO {
	private int trade_no ; 
	private String trade_user ;  // 본인 ( 구매자) - 충전 시에는 buyer가 내가 된다. 
	private String trade_target ;  // 대상
	private int trade_coin ; 
	private Timestamp trade_date; 
	private Timestamp trade_date2;
	private int trade_type ; // 0 : 충전 , 1 : 코인 차감 , 2 : 코인 증가
	
	public int getTrade_no() {
		return trade_no;
	}
	public void setTrade_no(int trade_no) {
		this.trade_no = trade_no;
	}
	public String getTrade_user() {
		return trade_user;
	}
	public void setTrade_user(String trade_user) {
		this.trade_user = trade_user;
	}
	public String getTrade_target() {
		return trade_target;
	}
	public void setTrade_target(String trade_target) {
		this.trade_target = trade_target;
	}
	public int getTrade_coin() {
		return trade_coin;
	}
	public void setTrade_coin(int trade_coin) {
		this.trade_coin = trade_coin;
	}
	public Timestamp getTrade_date() {
		return trade_date;
	}
	public void setTrade_date(Timestamp trade_date) {
		this.trade_date = trade_date;
	}
	public Timestamp getTrade_date2() {
		return trade_date2;
	}
	public void setTrade_date2(Timestamp trade_date2) {
		this.trade_date2 = trade_date2;
	}
	public int getTrade_type() {
		return trade_type;
	}
	public void setTrade_type(int trade_type) {
		this.trade_type = trade_type;
	}
	
}
