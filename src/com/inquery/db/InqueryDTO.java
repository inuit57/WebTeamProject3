package com.inquery.db;

public class InqueryDTO {

	private int inq_num;
	private String user_nick;
	private String inq_sub;
	private String inq_content;
	private int inq_lev;
	private String inq_img;
	private String inq_date;
	private int inq_ref;
	private String inq_check;
	
	
	public String getInq_check() {
		return inq_check;
	}
	public void setInq_check(String inq_check) {
		this.inq_check = inq_check;
	}
	public int getInq_ref() {
		return inq_ref;
	}
	public void setInq_ref(int inq_ref) {
		this.inq_ref = inq_ref;
	}
	public int getInq_num() {
		return inq_num;
	}
	public void setInq_num(int inq_num) {
		this.inq_num = inq_num;
	}
	public String getUser_nick() {
		return user_nick;
	}
	public void setUser_nick(String user_nick) {
		this.user_nick = user_nick;
	}
	public String getInq_sub() {
		return inq_sub;
	}
	public void setInq_sub(String inq_sub) {
		this.inq_sub = inq_sub;
	}
	public String getInq_content() {
		return inq_content;
	}
	public void setInq_content(String inq_content) {
		this.inq_content = inq_content;
	}
	public int getInq_lev() {
		return inq_lev;
	}
	public void setInq_lev(int inq_lev) {
		this.inq_lev = inq_lev;
	}
	public String getInq_img() {
		return inq_img;
	}
	public void setInq_img(String inq_img) {
		this.inq_img = inq_img;
	}
	public String getInq_date() {
		return inq_date;
	}
	public void setInq_date(String inq_date) {
		this.inq_date = inq_date;
	}
	
	
	@Override
	public String toString() {
		return "InqueryDTO [inq_num=" + inq_num + ", user_nick=" + user_nick + ", inq_sub=" + inq_sub + ", inq_content="
				+ inq_content + ", inq_lev=" + inq_lev + ", inq_img=" + inq_img + ", inq_date=" + inq_date
				+ ", inq_ref=" + inq_ref + ", inq_check=" + inq_check + "]";
	}
	
	
	
	
	
	
	
}
