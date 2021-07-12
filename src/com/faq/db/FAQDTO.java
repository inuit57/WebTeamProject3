package com.faq.db;

public class FAQDTO {
	
	private int faq_idx;      // FAQ 글번호
	private String faq_cate;  // FAQ 카테고리
	private String user_nick;  // FAQ 작성자
	private String faq_sub;   // FAQ 제목
	private String faq_content; // FAQ 내용
	
	
	
	public int getFaq_idx() {
		return faq_idx;
	}
	public void setFaq_idx(int faq_idx) {
		this.faq_idx = faq_idx;
	}
	public String getFaq_cate() {
		return faq_cate;
	}
	public void setFaq_cate(String faq_cate) {
		this.faq_cate = faq_cate;
	}
	public String getUser_nick() {
		return user_nick;
	}
	public void setUser_nick(String user_nick) {
		this.user_nick = user_nick;
	}
	public String getFaq_sub() {
		return faq_sub;
	}
	public void setFaq_sub(String faq_sub) {
		this.faq_sub = faq_sub;
	}
	public String getFaq_content() {
		return faq_content;
	}
	public void setFaq_content(String faq_content) {
		this.faq_content = faq_content;
	}
	@Override
	public String toString() {
		return "FAQDTO [faq_idx=" + faq_idx + ", faq_cate=" + faq_cate + ", user_nick=" + user_nick + ", faq_sub="
				+ faq_sub + ", faq_content=" + faq_content  + "]";
	}
	
	
	
	
	
	
	
	
	
}
