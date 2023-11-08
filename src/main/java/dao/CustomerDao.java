package dao;

import java.sql.*;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import vo.*;
import java.sql.ResultSet;

public class CustomerDao {
	
	// 로그인 (ID, PW) 일치하는지 확인
	public int ckIdPw(String customerId, String customerPw) throws Exception{
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");  
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                             
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT COUNT(*) FROM customer WHERE customer_id=? AND customer_pw= PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		stmt.setString(2, customerPw);
	
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt(1);
		if(row>0) {
			System.out.println("로그인 성공");

		} else {
			System.out.println("로그인 실패");
		}
		}
		stmt.close();
		conn.close();
		rs.close();
		return row;
	}
	
/*
	// 회원 상세정보
	public int insertCustomerDetail(CustomerDetail customerdetail) throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	
		// cust_detail 테이블에 새로운 입력값 추가
		String sql = "INSERT INTO customer_detail(customer_name, customer_phone, customer_email, birthdate, createdate, updatedate) VALUES(?,?,?,?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerdetail.getCustomerName());
		stmt.setString(2, customerdetail.getCustomerPhone());
		stmt.setString(3, customerdetail.getCustomerEmail());
		stmt.setString(4, customerdetail.getBirthDate());
		
		int insertCustomerDetail = stmt.executeUpdate();
		return insertCustomerDetail;
	
	}
*/
	
	// 고객 추가 insertCustomerAction.jsp 호출
	public void insertCustomer(Customer customer, CustomerDetail customerdetail) throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		
		String sql1 = "INSERT INTO customer(customer_id, customer_pw, createdate, updatedate, active) VALUES(?, PASSWORD(?), NOW(), NOW(), 'Y')";
		PreparedStatement stmt1 = conn.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);
		stmt1.setString(1, customer.getCustomerId());
		stmt1.setString(2, customer.getCustomerPw());
		System.out.println(stmt1 + " <-- stmt insertCustomer()");
		stmt1.executeUpdate();
		
		
		ResultSet rs1 = stmt1.getGeneratedKeys();
		int customerNo = 0; // 초기화된 값
		if (rs1.next()) {
			customerNo = rs1.getInt(1);
		} else {
			conn.rollback();
			return;
		}
		
		String sql2 = "INSERT INTO customer_detail(customer_no, customer_name, customer_phone, createdate, updatedate) VALUES(?,?,?, NOW(), NOW())";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, customerNo); // 위 SQL문에서 얻은 customer_no 설정.
		stmt2.setString(2, customerdetail.getCustomerName());
		stmt2.setString(3, customerdetail.getCustomerPhone());
		System.out.println(stmt2 + "<-- stmt2 insert테스트");
		
		int row2 = stmt2.executeUpdate();
		if (row2 !=1) {
			conn.rollback();
			return;
		}		
		conn.commit();
		stmt1.close();
		rs1.close();
		stmt2.close();
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
		stmt.setString(1, customer.getNewPw()); 		// 새롭게 설정한 비번이어야 함
		stmt.setString(2, customer.getCustomerId());
		stmt.setString(3, customer.getCustomerPw());	// 전에 사용했던 비번.
		System.out.println(stmt + "<-- stmt");
			
		row = stmt.executeUpdate();
		stmt.close();
		conn.close();

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
		stmt.close();
		conn.close();

		
		return row;
	}
}

	// 고객 상세정보 customerOne.jsp
	








	/*
	// DB에 등록된 회원정보 일치하는지 확인 후 로그인
	public int customerLoginAction(Customer customer) throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");  
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                             
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT customer_id customerId FROM customer WHERE customer_id=? AND customer_pw= PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customer.getCustomerId());
		stmt.setString(2, customer.getCustomerPw());
		
		ResultSet rs = stmt.executeQuery();
		return rs;
	
	}
	*/
	
/*

	
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