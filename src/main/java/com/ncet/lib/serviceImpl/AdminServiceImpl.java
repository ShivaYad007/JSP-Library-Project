package com.ncet.lib.serviceImpl;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.ncet.lib.entity.Admin;
import com.ncet.lib.entity.Books;
import com.ncet.lib.entity.Student;
import com.ncet.lib.exception.CommonException;
import com.ncet.lib.repo.DBConnectionHelper;
import com.ncet.lib.service.AdminService;
import com.ncet.lib.utils.PasswordEncryptor;

public class AdminServiceImpl implements AdminService {
	Connection connection;
	PreparedStatement pst;

	@Override
	public int findStudentByRollno(String rollno) throws ClassNotFoundException, SQLException {
		connection = DBConnectionHelper.getConnection();
		String sql = "select count(*) from Student where roll_no=?";
		pst = connection.prepareStatement(sql);
		pst.setString(1, rollno);
		ResultSet rs = pst.executeQuery();
		int i = 0;
		if (rs.next()) {
			i = rs.getInt(1);
			return i;
		}
		return i;

	}

	@Override
	public int getNextStudentId() throws ClassNotFoundException, SQLException {
		connection = DBConnectionHelper.getConnection();
		String query = "SELECT MAX(sId) FROM student";
		pst = connection.prepareStatement(query);
		int nextId = 1;
		ResultSet rs = pst.executeQuery();
		if (rs.next()) {
			nextId = rs.getInt(1) + 1;
			return nextId;
		}
		return nextId;
	}

	@Override
	public Admin adminLogin(String username, String password) throws ClassNotFoundException, SQLException {
		connection = DBConnectionHelper.getConnection();
		String sql = "select * from admin where username=? and password=?";
		pst = connection.prepareStatement(sql);
		pst.setString(1, username);
		pst.setString(2, password);
		ResultSet rs = pst.executeQuery();
		Admin admin = null;
		if (rs.next()) {
			admin = new Admin();
			admin.setAid(rs.getInt(1));
			admin.setName(rs.getString(2));
			admin.setPhno(rs.getLong(3));
			admin.setGmail(rs.getString(4));
			admin.setUsername(rs.getString(5));
			admin.setPassword(rs.getString(6));
		}
		return admin;
	}

	@Override
	public String createStudent(Student student) throws ClassNotFoundException, SQLException {
		connection = DBConnectionHelper.getConnection();
		String query = "INSERT INTO student (sId, name, roll_no, phno, department, gmail_id, username, password, year_of_joining, year_of_ending,salt) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		int studentByRollno = findStudentByRollno(student.getRollno());
		String msg = null;
		if (studentByRollno == 1) {
			msg = "Student Library Account already present with this rollno <b>" + student.getRollno()+"</b>";
		} else {
			int id = getNextStudentId();
			pst = connection.prepareStatement(query);
			pst.setInt(1, id);
			pst.setString(2, student.getName());
			pst.setString(3, student.getRollno());
			pst.setLong(4, student.getPhno());
			pst.setString(5, student.getDepartment());
			pst.setString(6, student.getGmail());
			pst.setString(7, student.getUsername());
			String salt = PasswordEncryptor.generateSalt();
			String hashedPassword=null;
			try {
				hashedPassword = PasswordEncryptor.hashPassword(student.getPassword(), salt);
			} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
				e.printStackTrace();
			}
			pst.setString(8, hashedPassword);
			pst.setInt(9, student.getYearOfJoining());
			pst.setInt(10, student.getYearOfEnding());
			pst.setString(11, salt);
			pst.executeUpdate();
			msg = "Student Library Account created successfully! with id <b>" + id+"</b>";
		}

		return msg;
	}

	@Override
	public Student searchStudent(String rollno) throws ClassNotFoundException, SQLException {
		connection = DBConnectionHelper.getConnection();
		String sql = "select * from Student where roll_no=?";
		pst = connection.prepareStatement(sql);
		pst.setString(1, rollno);
		ResultSet rs = pst.executeQuery();
		Student std = null;
		if (rs.next()) {
			std = new Student();
			std.setSId(rs.getInt(1));
			std.setName(rs.getString(2));
			std.setRollno(rs.getString(3));
			std.setPhno(rs.getLong(4));
			std.setDepartment(rs.getString(5));
			std.setGmail(rs.getString(6));
			std.setUsername(rs.getString(7));
			std.setPassword(rs.getString(8));
			std.setYearOfJoining(rs.getInt(9));
			std.setYearOfEnding(rs.getInt(10));
			return std;
		}
		throw new CommonException("Student Library Account not found with this rollno <b>" + rollno+"</b>");
	}

	@Override
	public String updateStudent(String rollno, String name, long phno, String gmail, String username, String password)
			throws ClassNotFoundException, SQLException {
		String msg = "Student Library Account not found with this rollno " + rollno;
		connection = DBConnectionHelper.getConnection();
		String query = "UPDATE student SET name = ?, phno = ?, gmail_id = ?, username = ?, password = ? ,salt =? WHERE roll_no = ?";

		int studentByRollno = findStudentByRollno(rollno);
		if (studentByRollno == 1) {
			pst = connection.prepareStatement(query);
			pst.setString(1, name);
			pst.setLong(2, phno);
			pst.setString(3, gmail);
			pst.setString(4, username);
			
			String salt = PasswordEncryptor.generateSalt();
			String hashedPassword=null;
			try {
				hashedPassword = PasswordEncryptor.hashPassword(password, salt);
			} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
				e.printStackTrace();
			}
			pst.setString(5, hashedPassword);
			pst.setString(6, salt);
			pst.setString(7, rollno);

			int rowsUpdated = pst.executeUpdate();
			if (rowsUpdated > 0) {
				msg = "Student Library Account updated successfully.";
			} else {
				msg = "Failed to update Student Library Account.";
			}
		}
		return msg;
	}

	@Override
	public String deleteStudent(String rollno) throws ClassNotFoundException, SQLException {
		String msg = "Student Library Account not found with this rollno " + rollno;
		connection = DBConnectionHelper.getConnection();
		int studentByRollno = findStudentByRollno(rollno);
		if (studentByRollno == 1) {
			String query = "DELETE FROM Student WHERE roll_no=?";
			pst = connection.prepareStatement(query);
			pst.setString(1, rollno);
			int rowsDeleted = pst.executeUpdate();
			if (rowsDeleted > 0) {
				msg = "Student Library Account deleted successfully.";
			} else {
				msg = "Failed to delete Student Library Account.";
			}
		}
		return msg;
	}

	@Override
	public List<Student> readAllStudents() throws ClassNotFoundException, SQLException {
		   List<Student> students = new ArrayList<>();
		    connection = DBConnectionHelper.getConnection();
		    String sql = "SELECT * FROM Student";
		    pst = connection.prepareStatement(sql);
		    ResultSet rs = pst.executeQuery();
		   

		    while (rs.next()) {
		    	int sid=rs.getInt("sid");
		    	String name = rs.getString("name");
		        String rollno = rs.getString("roll_no");
		        long phno = rs.getLong("phno");
		        String department = rs.getString("department");
		        String gmail = rs.getString("gmail_id");
		        String username = rs.getString("username");
		        String password = rs.getString("password");
		        int yearOfJoining=rs.getInt("year_of_joining");
		        int yearOfEnding=rs.getInt("year_of_ending");

		        Student student =new Student(sid, name, rollno, phno, department, gmail, username, password, yearOfJoining, yearOfEnding);
		        students.add(student);
		    }
		    if(students.isEmpty()) {
		    	throw new CommonException("no data found");
		    }
		return students;
	}
	
	

	@Override
	public int getNextBookId() throws ClassNotFoundException, SQLException {
		connection = DBConnectionHelper.getConnection();
		String query = "SELECT MAX(book_id) FROM book";
		pst = connection.prepareStatement(query);
		int nextId = 1;
		ResultSet rs = pst.executeQuery();
		if (rs.next()) {
			nextId = rs.getInt(1) + 1;
			return nextId;
		}
		return nextId;
	}
	
	
	@Override
	public int findBookByNameAndAuthorAndEdition(String name, String author,String edition) throws ClassNotFoundException, SQLException {
		    connection = DBConnectionHelper.getConnection();
		    String sql = "SELECT COUNT(*) FROM Book WHERE name = ? AND author = ? AND edition=?";
		    pst = connection.prepareStatement(sql);
		    pst.setString(1, name);
		    pst.setString(2, author);
		    pst.setString(3, edition);
		    ResultSet rs = pst.executeQuery();
		    int count = 0;

		    if (rs.next()) {
		        count = rs.getInt(1);
		    }
		    return count ;
		}


	@Override
	public String createBook(Books book) throws ClassNotFoundException, SQLException {
		connection = DBConnectionHelper.getConnection();
		String query = "INSERT INTO book (book_id, name, author, edition, department, quantity) VALUES (?, ?, ?, ?, ?, ?)";
		int count = findBookByNameAndAuthorAndEdition(book.getName(),book.getAuthor(),book.getEdition());
		String msg = null;
		if (count == 1) {
			msg = "Book already present with name <b>" + book.getName()+"</b> ,author <b>"+book.getAuthor()+"</b> and edition <b>"+book.getEdition()+"</b>";
		} else {
			int id = getNextBookId();
			pst = connection.prepareStatement(query);
			pst.setInt(1, id);
			pst.setString(2, book.getName());
			pst.setString(3, book.getAuthor());
			pst.setString(4, book.getEdition());
			pst.setString(5, book.getDepartment());
			pst.setInt(6, book.getQuantity());
			pst.executeUpdate();
			msg = "Book added successfully! with id <b>" + id+"</b>";
		}
		return msg;
	}


	@Override
	public String updateBookQuantity(int book_id, int qty) throws ClassNotFoundException, SQLException {
		connection = DBConnectionHelper.getConnection();
		String msg = null;
		 String query = "UPDATE Book SET quantity = ? WHERE book_id=?";
			pst = connection.prepareStatement(query);
			pst.setInt(1, qty);
			pst.setInt(2, book_id);

			int rowsUpdated = pst.executeUpdate();
			if (rowsUpdated > 0) {
				msg = "Book updated successfully.";
			} else {
				msg = "Book with id <b>"+book_id+"</b> not found";
			}
		return msg;
	}



	@Override
	public List<Books> readAllBooks() throws ClassNotFoundException, SQLException {
	    List<Books> books = new ArrayList<>();
	    connection = DBConnectionHelper.getConnection();
	    String query = "SELECT * FROM Book";
	    pst = connection.prepareStatement(query);
	    ResultSet rs = pst.executeQuery();
	    
	    while (rs.next()) {
	        int id = rs.getInt("book_id");
	        String name = rs.getString("name");
	        String author = rs.getString("author");
	        String edition=rs.getString("edition");
	        String department=rs.getString("department");
	        int quantity = rs.getInt("quantity");
	        
	        Books book = new Books(id, name, author, edition, department, quantity);
	        books.add(book);
	    }
	    if(books.isEmpty()) {
	    	throw new CommonException("no data found");
	    }
	    return books;
	}

	@Override
	public List<Books> searchBookByName(String name) throws ClassNotFoundException, SQLException {
		   List<Books> books = new ArrayList<>();
		    connection = DBConnectionHelper.getConnection();
		    String sql = "SELECT * FROM Book WHERE name = ?";
		    pst = connection.prepareStatement(sql);
		    pst.setString(1, name);
		    ResultSet rs = pst.executeQuery();
		    
		    while (rs.next()) {
		        int id = rs.getInt("book_id");
		        String author = rs.getString("author");
		        String edition=rs.getString("edition");
		        String department=rs.getString("department");
		        int quantity = rs.getInt("quantity");
		        
		        Books book = new Books(id, name, author, edition, department, quantity);
		        books.add(book);
		    }
		    if(books.isEmpty()) {
		    	throw new CommonException("no data found");
		    }
		    return books;
	}

	@Override
	public List<Books>searchBookByAuthor(String author) throws ClassNotFoundException, SQLException {
		   List<Books> books = new ArrayList<>();
		    connection = DBConnectionHelper.getConnection();
		    String sql = "SELECT * FROM Book WHERE author = ?";
		    pst = connection.prepareStatement(sql);
		    pst.setString(1, author);
		    ResultSet rs = pst.executeQuery();
		    
		    while (rs.next()) {
		        int id = rs.getInt("book_id");
		        String name = rs.getString("name");
		        String edition=rs.getString("edition");
		        String department=rs.getString("department");
		        int quantity = rs.getInt("quantity");
		        
		        Books book = new Books(id, name, author, edition, department, quantity);
		        books.add(book);
		    }
		    if(books.isEmpty()) {
		    	throw new CommonException("no data found");
		    }
		    return books;
	}

	@Override
	public List<Books> searchBookByNameAndAuthor(String name, String author) throws ClassNotFoundException, SQLException {
		   List<Books> books = new ArrayList<>();
		    connection = DBConnectionHelper.getConnection();
		    String sql = "SELECT * FROM Book WHERE name = ? and author = ?";
		    pst = connection.prepareStatement(sql);
		    pst.setString(1, name);
		    pst.setString(2, author);
		    ResultSet rs = pst.executeQuery();
		    
		    while (rs.next()) {
		        int id = rs.getInt("book_id");
		        String edition=rs.getString("edition");
		        String department=rs.getString("department");
		        int quantity = rs.getInt("quantity");
		        
		        Books book = new Books(id, name, author, edition, department, quantity);
		        books.add(book);
		    }
		    if(books.isEmpty()) {
		    	throw new CommonException("no data found");
		    }
		    return books;
	}
	@Override
	public String deleteBookByNameAndAuthorAndEdition(String name, String author,String edition) throws ClassNotFoundException, SQLException {
		int count = findBookByNameAndAuthorAndEdition(name, author,edition);
		String msg = "Book not found with name " +name+" and author "+author;
		   String query = "DELETE FROM Book WHERE name = ? and author =?";
		   
		   connection = DBConnectionHelper.getConnection();
		   
		if(count==1) {
			pst = connection.prepareStatement(query);
			pst.setString(1, name);
			pst.setString(2, author);
			int rowsDeleted = pst.executeUpdate();
			if (rowsDeleted > 0) {
				msg = "Book deleted successfully.";
			} else {
				msg = "Failed to delete Book.";
			}
		}
		return msg;
	}

	@Override
	public String deleteBookById(int book_id) throws ClassNotFoundException, SQLException {
		String msg = null;
		   String query = "DELETE FROM Book WHERE book_id = ?";
		   
		   connection = DBConnectionHelper.getConnection();
		   
			pst = connection.prepareStatement(query);
			pst.setInt(1, book_id);
			int rowsDeleted = pst.executeUpdate();
			if (rowsDeleted > 0) {
				msg = "Book deleted successfully.";
			} else {
				msg = "Book not found with book id <b>"+book_id+"</b>";
			}
		return msg;
	}

	@Override
	public String issueBook(int tid, LocalDate issued_on, String remarks)
			throws ClassNotFoundException, SQLException {
		connection = DBConnectionHelper.getConnection();
		String msg = null;
		LocalDate end_on=issued_on.plusDays(14);
		String isTidPresent="SELECT COUNT(*) FROM book_transactions WHERE trans_id=?";
		 String query = "UPDATE book_transactions SET issued_on = ?, end_on = ?, remarks =? WHERE trans_id=? and remarks IS NULL";
		 String bookUpdateQty="update book set quantity =quantity-1 where book_id in (select book_id from book_transactions where trans_id=?)";
			
		 pst = connection.prepareStatement(isTidPresent);
		 pst.setInt(1, tid);
		 ResultSet rs = pst.executeQuery();
		
		 int count =0;
		 if(rs.next()) {
			 count = rs.getInt(1);
		 }
		 if(count==1) {
		 pst = connection.prepareStatement(query);
			pst.setDate(1, java.sql.Date.valueOf(issued_on));
			pst.setDate(2,java.sql.Date.valueOf(end_on));
			pst.setString(3, remarks);
			pst.setInt(4, tid);

			
			int rowsUpdated = pst.executeUpdate();
			if (rowsUpdated > 0) {
				pst = connection.prepareStatement(bookUpdateQty);
				pst.setInt(1, tid);
				pst.executeUpdate();
				msg = "Book with tid : <b>"+tid+"</b> Issued successfully.";
			} else {
				msg = "Transaction id <b>"+tid+"</b> already Updated";
			}
		 }else {
			 msg="Transaction id <b>"+tid+"</b> not found";
		 }
		return msg;
	}

	@Override
	public String returnBook(int tid, String remarks) throws ClassNotFoundException, SQLException {
		connection = DBConnectionHelper.getConnection();
		String msg = null;
		String isTidPresent="SELECT COUNT(*) FROM book_transactions WHERE trans_id=?";
		 String query = "UPDATE book_transactions SET remarks =? WHERE trans_id=? and remarks = 'ISSUED'";
		 String bookUpdateQty="update book set quantity =quantity+1 where book_id in (select book_id from book_transactions where trans_id=?)";
			
		 pst = connection.prepareStatement(isTidPresent);
		 pst.setInt(1, tid);
		 ResultSet rs = pst.executeQuery();
		
		 int count =0;
		 if(rs.next()) {
			 count = rs.getInt(1);
		 }
		 if(count==1) {
		 pst = connection.prepareStatement(query);
			pst.setString(1, remarks);
			pst.setInt(2, tid);

			
			int rowsUpdated = pst.executeUpdate();
			if (rowsUpdated > 0) {
				pst = connection.prepareStatement(bookUpdateQty);
				pst.setInt(1, tid);
				pst.executeUpdate();
				msg = "Book with tid : <b>"+tid+"</b> Returned successfully.";
			} else {
				msg = "Transaction id <b>"+tid+"</b> already Updated";
			}
		 }else {
			 msg="Transaction id <b>"+tid+"</b> not found";
		 }
		return msg;
	}
	@Override
	public Student getStudentByTransId(int tid) throws ClassNotFoundException, SQLException {
		String query="SELECT * FROM student where sid in (select sid from book_transactions where trans_id =?)";
		Student s=null;
		connection = DBConnectionHelper.getConnection();
		pst = connection.prepareStatement(query);
		pst.setInt(1, tid);
		ResultSet rs = pst.executeQuery();
		if(rs.next()) {
			s=new Student();
			s.setSId(rs.getInt(1));
			s.setName(rs.getString(2));
			s.setRollno(rs.getString(3));
			s.setPhno(rs.getLong(4));
			s.setDepartment(rs.getString(5));
			s.setGmail(rs.getString(6));
			s.setUsername(rs.getString(7));
			s.setPassword(rs.getString(8));
			s.setYearOfJoining(rs.getInt(9));
			s.setYearOfEnding(rs.getInt(10));
		}
		return s;
	}



}
