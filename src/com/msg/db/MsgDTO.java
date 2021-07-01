package com.msg.db;

import java.sql.Date;

public class MsgDTO {

	private int msg_idx;
	private int prod_num;
	private String recv_nick;
	private String send_nick;
	private String msg_content;
	private int msg_chk;
	private Date msg_date;
	
	
	public int getProd_num() {
		return prod_num;
	}
	public void setProd_num(int prod_num) {
		this.prod_num = prod_num;
	}
	public int getMsg_idx() {
		return msg_idx;
	}
	public void setMsg_idx(int msg_idx) {
		this.msg_idx = msg_idx;
	}
	public String getRecv_nick() {
		return recv_nick;
	}
	public void setRecv_nick(String recv_nick) {
		this.recv_nick = recv_nick;
	}
	public String getSend_nick() {
		return send_nick;
	}
	public void setSend_nick(String send_nick) {
		this.send_nick = send_nick;
	}
	public String getMsg_content() {
		return msg_content;
	}
	public void setMsg_content(String msg_content) {
		this.msg_content = msg_content;
	}
	public int getMsg_chk() {
		return msg_chk;
	}
	public void setMsg_chk(int msg_chk) {
		this.msg_chk = msg_chk;
	}
	public Date getMsg_date() {
		return msg_date;
	}
	public void setMsg_date(Date msg_date) {
		this.msg_date = msg_date;
	}
	
	
	
	@Override
	public String toString() {
		return "MsgDTO [msg_idx=" + msg_idx + ", recv_nick=" + recv_nick + ", send_nick=" + send_nick + ", msg_content="
				+ msg_content + ", msg_chk=" + msg_chk + "msg_date=" + msg_date + "]";
	}
	
	
	
	
	
}
