package com.user.action;

import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.user.db.UserDAO;
import com.user.mail.SMTPAuthenticatior;
import com.user.mail.random;

public class UserEmailSendAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
		String id = request.getParameter("id");

		UserDAO udao = new UserDAO();
		
		boolean result = udao.checkId(id);
		
		
		ActionForward forward = new ActionForward();
		
		if(!result){
			
			
			
			session.setAttribute("id", id);
			String subject = "OOO마켓 인증메일입니다.";
			random r = new random();
			String content = r.randomNum();
			session.setAttribute("content", content);
			response.setContentType("text/html;charset=UTF-8");
			String username="mataradamin@gmail.com";
			
			
			try {
				Properties properties = System.getProperties();
				properties.put("mail.smtp.starttls.enable", "true");
				properties.put("mail.smtp.host","smtp.gmail.com");
				properties.put("mail.smtp.auth","true");
				properties.put("mail.smtp.port","587");
				
				
				Authenticator auth = new SMTPAuthenticatior();
				
				Session s = Session.getDefaultInstance(properties, auth);
				Message message = new MimeMessage(s);
				Address sender_address = new InternetAddress(username);
				Address user_mail_address = new InternetAddress(id);
				message.setHeader("content-type", "text/html;charset=UTF-8");
				message.setFrom(sender_address);
				message.setReplyTo(new Address[]{sender_address});
				message.addRecipient(Message.RecipientType.TO, user_mail_address);
				message.setSubject(subject);
				message.setContent("인증 번호는 "+content+" 입니다.","text/html;charset=UTF-8");
				message.setSentDate(new java.util.Date());
				message.saveChanges();
				Transport.send(message);
			} catch (Exception e) {
				System.out.println("SMTP 서버가 잘못설정되었거나 서비스에 문제가 있습니다.");
				e.printStackTrace();
			}
			
			forward.setPath("./UserEmailChk.us");
			forward.setRedirect(true);
			
			
		}else{
			session.setAttribute("id", id);
			forward.setPath("./UserEmail.us");
			forward.setRedirect(true);
		}
		return forward;
	}

}
