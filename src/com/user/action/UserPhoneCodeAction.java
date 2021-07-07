package com.user.action;

import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.user.mail.random;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

public class UserPhoneCodeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		
	      String api_key = "NCS1VUHQ8LJEOKRF";
		  String api_secret = "VLEIXKVTNMA5U7PX4HB0NIABC7MSUVII";
		  Message coolsms = new Message(api_key, api_secret);
		  
		  
		  
		  random r = new random();
		  String content = r.randomNum();
		  
		  content = "1";
		  
		  
		  String user_phone = request.getParameter("user_phone");
		   
		   

		  HashMap<String, String> params = new HashMap<String, String>();
		    params.put("to", user_phone);	// 수신전화번호
		    params.put("from", "01084119664");	// 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
		    params.put("type", "SMS");
		    params.put("text",  "기억마켓의 인증번호는 " + content + " 입니다.");
		    params.put("app_version", "test app 1.2"); // application name and version

		    try {
		      JSONObject obj = (JSONObject) coolsms.send(params);
		      System.out.println(obj.toString());
		    } catch (CoolsmsException e) {
		      System.out.println(e.getMessage());
		      System.out.println(e.getCode());
		    }
		  
		  PrintWriter out = response.getWriter();
		  out.print(content);
		  out.close();
		
		return null;
	}

}
