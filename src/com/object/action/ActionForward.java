
package com.object.action;

public class ActionForward {
	// 페이지를 이동시 이동 경로를 저장할 객체 
	
	// 이동할 주소 
	private String path ; 
	
	// 이동하는 방식
	private boolean isRedirect ;
	// true : sendRedirect 방식 이동
	// false : forward 방식 이동 ( f- f) 

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public boolean isRedirect() {
		return isRedirect;
	}

	public void setRedirect(boolean isRedirect) {
		this.isRedirect = isRedirect;
	} 
	
	
	
}

