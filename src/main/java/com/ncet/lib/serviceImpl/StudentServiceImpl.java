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

import com.ncet.lib.entity.Books;
import com.ncet.lib.entity.Student;
import com.ncet.lib.exception.CommonException;
import com.ncet.lib.repo.DBConnectionHelper;
import com.ncet.lib.service.StudentService;
import com.ncet.lib.utils.MyBooks;
import com.ncet.lib.utils.PasswordEncryptor;

public class StudentServiceImpl implements StudentService {
	Connection connection;
	PreparedStatement pst;

	@Override
	public Student studentLogin(String username, String password) throws ClassNotFoundException, SQLException {
		connection = DBConnectionHelper.getConnection();
		String saltQuery="select salt from student where username =?";
		pst = connection.prepareStatement(saltQuery);
		pst.setString(1, username);
		ResultSet rst = pst.executeQuery();
		String salt=null;
		if(rst.next()) {
			salt=rst.getString(1);
		}
		
		String sql = "select * from student where username=? and password=?";
		pst = connection.prepareStatement(sql);
		String hashedPassword=null;
		try {
			hashedPassword = PasswordEncryptor.hashPassword(password, salt);
		} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
			e.printStackTrace();
		}
		System.out.println(hashedPassword);
		pst.setString(1, username);
		pst.setString(2, hashedPassword);
		ResultSet rs = pst.executeQuery();
		Student student = null;
		if (rs.next()) {
			student = new Student();
			student.setSId(rs.getInt(1));
			student.setName(rs.getString(2));
			student.setRollno(rs.getString(3));
			student.setPhno(rs.getLong(4));
			student.setDepartment(rs.getString(5));
			student.setGmail(rs.getString(6));
			student.setUsername(rs.getString(7));
			student.setPassword(rs.getString(8));
			student.setYearOfJoining(rs.getInt(9));
			student.setYearOfEnding(rs.getInt(10));
			
		}
		return student;
	}
	@Override
	public List<Books> searchBookByName(String name) throws ClassNotFoundException, SQLException {
		   List<Books> books = new ArrayList<>();
		    connection = DBConnectionHelper.getConnection();
		    String sql = "SELECT * FROM Books WHERE name = ?";
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
		    String sql = "SELECT * FROM Books WHERE author = ?";
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
		    String sql = "SELECT * FROM Books WHERE name = ? and author = ?";
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
	public List<Books> readAllBooks() throws ClassNotFoundException, SQLException {
	    List<Books> books = new ArrayList<>();
	    connection = DBConnectionHelper.getConnection();
	    String query = "SELECT * FROM Books";
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
	public String requestBook(int bookId,int sid) throws ClassNotFoundException, SQLException {
	    connection = DBConnectionHelper.getConnection();
	    String checkBookQuery = "SELECT COUNT(*) FROM book_transactions WHERE book_id = ? AND sid = ? AND remarks IS NULL OR "+
	    "book_id = ? AND sid = ? AND remarks = 'ISSUED'";
        String countBooksQuery = "SELECT COUNT(*) FROM book_transactions WHERE sid = ? and remarks ='ISSUED' OR sid = ? and remarks IS NULL";
        String insertQuery = "INSERT INTO book_transactions (book_id, sid) VALUES (?, ?)";
        String selectQuery = "SELECT trans_id from book_transactions WHERE book_id =? and sid =? and remarks IS NULL";
        String msg = "";

        try {
            // Check if the student already requested this book
            PreparedStatement checkBookStmt = connection.prepareStatement(checkBookQuery);
            checkBookStmt.setInt(1, bookId);
            checkBookStmt.setInt(2, sid);
            checkBookStmt.setInt(3, bookId);
            checkBookStmt.setInt(4, sid);
            ResultSet checkBookResult = checkBookStmt.executeQuery();
            checkBookResult.next();
            int existingBookCount = checkBookResult.getInt(1);

            if (existingBookCount ==1) {
                msg = "You have already requested this book.";
                return msg;
            }

            // Count the number of books the student has requested
            PreparedStatement countBooksStmt = connection.prepareStatement(countBooksQuery);
            countBooksStmt.setInt(1, sid);
            countBooksStmt.setInt(2, sid);
            ResultSet countBooksResult = countBooksStmt.executeQuery();
            countBooksResult.next();
            int bookCount = countBooksResult.getInt(1);

            if (bookCount < 3) {

            // Insert the new book request
            PreparedStatement insertStmt = connection.prepareStatement(insertQuery);
            insertStmt.setInt(1, bookId);
            insertStmt.setInt(2, sid);
            int rowsAffected = insertStmt.executeUpdate();

            if (rowsAffected > 0) {
            	pst=connection.prepareStatement(selectQuery);
            	pst.setInt(1, bookId);
            	pst.setInt(2, sid);
               ResultSet rs = pst.executeQuery();
               rs.next();
               int trans_id = rs.getInt(1);
                msg = "Book requested with trans id: <b>"+trans_id+"</b>";
            } else {
                msg = "Failed to request book.";
            }
            }
            else {
                msg = "You have already requested 3 books.";
                return msg;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            msg = "No book found with book id : "+bookId;
        }

        return msg;
    
	}
	@Override
	public List<MyBooks> myBooks(String rollno) throws ClassNotFoundException, SQLException {
		   List<MyBooks> myBooks = new ArrayList<>();
		  
		    connection = DBConnectionHelper.getConnection();
		    String sql = "SELECT name,author,edition,issued_on,end_on,remarks from book inner join book_transactions where "
		    		+ "book.book_id =book_transactions.book_id and book_transactions.remarks ='issued' and  book_transactions.sid= (select sid from student where roll_no=?)";
		    pst = connection.prepareStatement(sql);
		    pst.setString(1, rollno);
		    ResultSet rs = pst.executeQuery();
		    
		    while (rs.next()) {
		        String name = rs.getString("name");
		        String author=rs.getString("author");
		        String edition=rs.getString("edition");
		        LocalDate issued_on = LocalDate.parse(rs.getDate("issued_on")+"");
		        LocalDate end_on = LocalDate.parse(rs.getDate("end_on")+"");
		        String remarks=rs.getString("remarks");
		        MyBooks mybook=new MyBooks();
		        mybook.setName(name);
		        mybook.setAuthor(author);
		        mybook.setEdition(edition);
		        mybook.setIssuedOn(issued_on);
		        mybook.setEndOn(end_on);
		        mybook.setRemarks(remarks);
		      myBooks.add(mybook);
		    }
		    if(myBooks.isEmpty()) {
		    	throw new CommonException("no data found");
		    }
		    return myBooks;
	}
}
