package com.prod.db;

import java.sql.Timestamp;

public class ProdDTO {

	private int prod_num;
	private String user_nickname;
	private int prod_category;
	private int prod_status;
	private String prod_sub;
	private String prod_content;
	private int prod_price;
	private String prod_img;
	private Timestamp prod_date;
	private String prod_ip;
	private int prod_count;
	
	public int getProd_num() {
		return prod_num;
	}
	public void setProd_num(int prod_num) {
		this.prod_num = prod_num;
	}
	public String getUser_nickname() {
		return user_nickname;
	}
	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}
	public int getProd_category() {
		return prod_category;
	}
	public void setProd_category(int prod_category) {
		this.prod_category = prod_category;
	}
	public int getProd_status() {
		return prod_status;
	}
	public void setProd_status(int prod_status) {
		this.prod_status = prod_status;
	}
	public String getProd_sub() {
		return prod_sub;
	}
	public void setProd_sub(String prod_sub) {
		this.prod_sub = prod_sub;
	}
	public String getProd_content() {
		return prod_content;
	}
	public void setProd_content(String prod_content) {
		this.prod_content = prod_content;
	}
	public int getProd_price() {
		return prod_price;
	}
	public void setProd_price(int prod_price) {
		this.prod_price = prod_price;
	}
	public String getProd_img() {
		return prod_img;
	}
	public void setProd_img(String prod_img) {
		this.prod_img = prod_img;
	}
	public Timestamp getProd_date() {
		return prod_date;
	}
	public void setProd_date(Timestamp prod_date) {
		this.prod_date = prod_date;
	}
	public String getProd_ip() {
		return prod_ip;
	}
	public void setProd_ip(String prod_ip) {
		this.prod_ip = prod_ip;
	}
	public int getProd_count() {
		return prod_count;
	}
	public void setProd_count(int prod_count) {
		this.prod_count = prod_count;
	}
	
	
	
	
}
