package com.ncet.lib.service;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

import com.ncet.lib.entity.Admin;
import com.ncet.lib.entity.Books;
import com.ncet.lib.entity.Student;

public interface AdminService {
	Admin adminLogin(String username, String password)throws ClassNotFoundException, SQLException;
	int findStudentByRollno(String rollno) throws ClassNotFoundException, SQLException;
	int getNextStudentId() throws ClassNotFoundException, SQLException;
	String createStudent(Student student) throws ClassNotFoundException, SQLException;
	Student searchStudent(String rollno) throws ClassNotFoundException, SQLException;
	String updateStudent(String rollno,String name,long phno,String gmail, String username, String password) throws ClassNotFoundException, SQLException;
	String deleteStudent(String rollno) throws ClassNotFoundException, SQLException;
	List<Student> readAllStudents()throws ClassNotFoundException, SQLException;
	
	
	int getNextBookId() throws ClassNotFoundException, SQLException;
	int findBookByNameAndAuthorAndEdition(String name,String author,String edition) throws ClassNotFoundException, SQLException;
	String createBook(Books book) throws ClassNotFoundException, SQLException;
	List<Books> searchBookByName(String name) throws ClassNotFoundException, SQLException;
	List<Books> searchBookByAuthor(String author) throws ClassNotFoundException, SQLException;
	List<Books> searchBookByNameAndAuthor(String name,String author) throws ClassNotFoundException, SQLException;
	String updateBookQuantity(int book_id,int qty) throws ClassNotFoundException, SQLException;
	String deleteBookByNameAndAuthorAndEdition(String name, String author,String edition) throws ClassNotFoundException, SQLException;
	String deleteBookById(int book_id) throws ClassNotFoundException, SQLException;
	List<Books> readAllBooks()throws ClassNotFoundException, SQLException;
	String issueBook(int tid,LocalDate issued_on,String remarks) throws ClassNotFoundException, SQLException;
	String returnBook(int tid,String remarks) throws ClassNotFoundException, SQLException;
	Student getStudentByTransId(int tid) throws ClassNotFoundException, SQLException;
	
	

}
