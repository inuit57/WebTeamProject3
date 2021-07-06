package com.user.action;

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;
import com.user.mail.random;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class UserPhoneCodeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		
		  final String ACCOUNT_SID = "AC724debbbb1937daf3a2073b18562502d";
		  final String AUTH_TOKEN = "bfbbdcf57e88b975c6ec245bcb006c89";

		  Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
		  
		  
		  String user_phone = request.getParameter("user_phone");
		  String phone = "+82";
		  if(user_phone.length() == 11){
			 phone += user_phone.substring(1, 11);
			 
		  }else if(user_phone.length() == 10){
			 phone += user_phone.substring(1, 10);
		  }
		  
		  
		  random r = new random();
		  String content = r.randomNum();
		  
		  
		 
		  Message message = Message.creator(new PhoneNumber(phone),
		       new PhoneNumber("+13123134334"), 
             // 이 번호는 twilio가입하면 줍니다
		        "기억마켓의 인증번호는 " + content + " 입니다.").create();
             // xxxx는 나중에 random함수로 구현할 예정

		  System.out.println(message.getSid());
		    
		  PrintWriter out = response.getWriter();
		  out.print(content);
		  out.close();
		
		return null;
	}

}
