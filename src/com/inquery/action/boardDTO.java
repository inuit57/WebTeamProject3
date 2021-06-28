package com.inquery.action;

import java.util.Date;

public class boardDTO {
	
	private int board_num;
	private String board_area;
	private String user_nick;
	private int board_count;
	private String board_sub;
	private String board_content;
	private String board_date;
	private String board_file;
	private String board_ip;
	
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public String getBoard_area() {
		return board_area;
	}
	public void setBoard_area(String board_area) {
		this.board_area = board_area;
	}
	public String getUser_nick() {
		return user_nick;
	}
	public void setUser_nick(String user_nick) {
		this.user_nick = user_nick;
	}
	public int getBoard_count() {
		return board_count;
	}
	public void setBoard_count(int board_count) {
		this.board_count = board_count;
	}
	public String getBoard_sub() {
		return board_sub;
	}
	public void setBoard_sub(String board_sub) {
		this.board_sub = board_sub;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	public String getBoard_date() {
		return board_date;
	}
	public void setBoard_date(String board_date) {
		this.board_date = board_date;
	}
	public String getBoard_file() {
		return board_file;
	}
	public void setBoard_file(String board_file) {
		this.board_file = board_file;
	}
	public String getBoard_ip() {
		return board_ip;
	}
	public void setBoard_ip(String board_ip) {
		this.board_ip = board_ip;
	}
	
	@Override
	public String toString() {
		return "boardDTO [board_num=" + board_num + ", board_area=" + board_area + ", user_nick=" + user_nick
				+ ", board_count=" + board_count + ", board_sub=" + board_sub + ", board_content=" + board_content
				+ ", board_date=" + board_date + ", board_file=" + board_file + ", board_ip=" + board_ip + "]";
	}
	

	
	
	
	
}
