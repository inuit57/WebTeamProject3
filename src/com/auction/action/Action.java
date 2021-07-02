
package com.auction.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface Action {

	// 상수, 추상메서드 
	// 동일한 동작을 수행하는 객체는 반드시 해당메서드(추상)을 구현해야 함(오버라이딩) 
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response ) throws Exception; 
}

