package com.ncet.lib.service;

import java.sql.SQLException;
import java.util.List;

import com.ncet.lib.entity.Books;
import com.ncet.lib.entity.Student;
import com.ncet.lib.utils.MyBooks;

public interface StudentService {
	Student studentLogin(String username, String password)throws ClassNotFoundException, SQLException;
	List<Books> searchBookByName(String name) throws ClassNotFoundException, SQLException;
	List<Books> searchBookByAuthor(String author) throws ClassNotFoundException, SQLException;
	List<Books> searchBookByNameAndAuthor(String name,String author) throws ClassNotFoundException, SQLException;
	List<Books> readAllBooks() throws ClassNotFoundException, SQLException;
	String requestBook(int bookId,int sid) throws ClassNotFoundException, SQLException;
	List<MyBooks> myBooks(String rollno) throws ClassNotFoundException, SQLException;
}

