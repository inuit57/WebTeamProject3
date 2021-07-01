package com.user.mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SMTPAuthenticatior extends Authenticator{
	
	PasswordAuthentication passAuth;
	
	public SMTPAuthenticatior() {
		passAuth = new PasswordAuthentication("mataradamin@gmail.com", "@imf2dan@");
	
	}
	
	public PasswordAuthentication getPasswordAuthentication() {
		return passAuth;
	}

}
