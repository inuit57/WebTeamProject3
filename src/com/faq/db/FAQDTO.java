package com.faq.db;

public class FAQDTO {
	
	private int faq_idx;
	private String user_nick;
	private String faq_content;
	
	
	
	public int getFaq_idx() {
		return faq_idx;
	}
	public void setFaq_idx(int faq_idx) {
		this.faq_idx = faq_idx;
	}
	public String getUser_nick() {
		return user_nick;
	}
	public void setUser_nick(String user_nick) {
		this.user_nick = user_nick;
	}
	public String getFaq_content() {
		return faq_content;
	}
	public void setFaq_content(String faq_content) {
		this.faq_content = faq_content;
	}
	@Override
	public String toString() {
		return "FAQDTO [faq_idx=" + faq_idx + ", user_nick=" + user_nick + ", faq_content=" + faq_content + "]";
	}
	
	
	
	
	
	
}
