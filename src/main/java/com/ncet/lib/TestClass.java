package com.ncet.lib;

import java.sql.SQLException;

import com.ncet.lib.exception.CommonException;
import com.ncet.lib.service.AdminService;
import com.ncet.lib.serviceImpl.AdminServiceImpl;
import com.ncet.lib.utils.SendMail;

public class TestClass {
public static void main(String[] args) {
	/*
	 * String
	 * msg="Your requested book is succefully genereted with Trans ID : 101\n Please get your book at Library Admin\nKeep Learnig will make shining the world\nThank You !"
	 * ; SendMail.sendEmail("shivayad.g07@gmail.com", "Book Trans Id Genereated",
	 * msg);
	 */
	
	AdminService aserv=new AdminServiceImpl();
	try {
		System.out.println(aserv.getStudentByTransId(114));
	} catch (ClassNotFoundException | SQLException | CommonException e) {
		e.printStackTrace();
	}
	
}
}
