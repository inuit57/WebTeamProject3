package com.chat.db;

public class chatDTO {
	private int prod_num;
	private String chat_seller;
	private String chat_buyer;
	private String chat_roomid;
	public int getProd_num() {
		return prod_num;
	}
	public void setProd_num(int prod_num) {
		this.prod_num = prod_num;
	}
	public String getChat_seller() {
		return chat_seller;
	}
	public void setChat_seller(String chat_seller) {
		this.chat_seller = chat_seller;
	}
	public String getChat_buyer() {
		return chat_buyer;
	}
	public void setChat_buyer(String chat_buyer) {
		this.chat_buyer = chat_buyer;
	}
	public String getChat_roomid() {
		return chat_roomid;
	}
	public void setChat_roomid(String chat_roomid) {
		this.chat_roomid = chat_roomid;
	}
	
}
