package dao;

import java.sql.*;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import vo.*;
import java.sql.ResultSet;

public class CustomerDao {
	
	// 고객 추가 insertCustomerAction.jsp 호출
	public int insertCustomer(Customer customer) throws Exception{
		int row =0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		String sql = "INSERT INTO customer(customer_id, customer_pw, createdate, updatedate) VALUES(?, PASSWORD(?), NOW(), NOW())";
		PreparedStatement stmt1 = conn.prepareStatement(sql);
		stmt1.setString(1, customer.getCustomerId());
		stmt1.setString(2, customer.getCustomerPw());
		System.out.println(stmt1 + " <-- stmt insertCustomer()");
		row = stmt1.executeUpdate();
		return row;
	}
	
	// 고객 비밀번호 수정 updateCustomerPwAction.jsp 호출
	public int updateCustomerPw(Customer customer) throws Exception {
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		   
	// 입력한 비밀번호가 예전 번호와 일치하는지 확인.
	String sql = "UPDATE customer SET customer_pw = PASSWORD(?), updatedate = NOW() WHERE customer_id=? AND customer_pw = PASSWORD(?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, customer.getNewPw()); // 새롭게 설정한 비번이어야 함
	stmt.setString(2, customer.getCustomerId());					// 전에 사용했던 비번.
	System.out.println(stmt + "<-- stmt");
			
	row = stmt.executeUpdate();
	return row;
	}
	
	// 고객 회원정보 삭제 deleteCustomerAction.jsp
	public int deleteCustomer(Customer customer) throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");  
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                             
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);

		String sql = "DELETE FROM customer WHERE customer_id =? AND customer_pw=PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customer.getCustomerId());
		stmt.setString(2, customer.getCustomerPw());
		
		int row = stmt.executeUpdate();
		return row;
	}
	
	
}
	
/*
	
	
		   
	}

	
	public int login(Customer id) throws Exception{
		int row;
		Class.forName("org.mariadb.jdbc.Driver");
		   String url = "jdbc:mariadb://localhost:3306/mall";
		   String dbuser = "root";
		   String dbpw = "java1234";
		   Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		   
		   String sql = "SELECT customer_id customerId FROM customer WHERE customer_id=? AND customer_pw= PASSWORD(?)";
		   PreparedStatement stmt = conn.prepareStatement(sql);
		   stmt.setString(1, id.getCustomerId());
		   stmt.setString(2, id.getCustomerPw());
		   ResultSet rs = stmt.executeQuery();
	
		   return row;
		}
	
	}
	
	/*
	// 본인 정보 조회
	public Customer selectMyPage(String id) throws Exception {
		// 반환할 Customer 객체
	} Customer customer = null;	
	
	Class.forName("org.mariadb.jdbc.Driver");
	String url = "jdbc:mariadb://localhost:3306/mall";
	String dbuser = "root";
	String dbpw = "java1234";
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	System.out.println("DB접속 성공");
	
	// sql 전송 후 결과값 반환받어서 전환
	String sql = "SELECT customer_no customerNo, customer_id customerId, customer_pw customerPw, createdate, updatedate FROM CUSTOMER where customer_id = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, id);
	
	ResultSet rs = stmt.executeQuery();
	while(rs.next()) {
		customer = new Customer();
		customer.setCustomerNo(rs.getInt("customerNo"));
		customer.setCustomerId(rs.getString("customerId"));
		customer.setCustomerPw(rs.getString("customerPw"));
		customer.setCreatedate(rs.getString("createdate"));
		customer.setUpdatedate(rs.getString("updatedate"));
	}
	return customer;
}
		*/