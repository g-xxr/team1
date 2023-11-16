package dao;

import java.net.URLEncoder;
import java.sql.*;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import vo.*;
import java.sql.ResultSet;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
	
	// 로그인 (ID, PW) 일치하는지 확인
	public ResultSet customerLogin(Customer customer, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
	
		Class.forName("org.mariadb.jdbc.Driver");  
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                             
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		// DB에 기입된 아이디와 비밀번호 일치 여부
		String sql = "SELECT customer_no customerNo, active FROM customer WHERE customer_id=? AND customer_pw= PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customer.getCustomerId());
		stmt.setString(2, customer.getCustomerPw());
		ResultSet rs = stmt.executeQuery();
		
		stmt.close();
		conn.close();
		rs.close();
		
		return rs;
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
	public void insertCustomer(Customer customer, CustomerDetail customerdetail, CustomerAddr customeraddr, CustomerPwHistory customerpwhistory) throws Exception{
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
		
		String sql3 = "INSERT INTO customer_addr(customer_no, address, createdate, updatedate) VALUES(?,?,NOW(),NOW())";
		PreparedStatement stmt3 = conn.prepareStatement(sql3);
		stmt3.setInt(1, customerNo); // 위 SQL문에서 얻은 customer_no 설정.
		stmt3.setString(2, customeraddr.getAddress());
		System.out.println(stmt3 + "<-- stmt3 insert테스트");
		
		int row3 = stmt3.executeUpdate();
		if (row3 != 1) {
			conn.rollback();
			return;
		}
		
		String sql4 = "INSERT INTO customer_pw_history(customer_no, customer_pw, createdate) VALUES(?, PASSWORD(?), NOW())";
		PreparedStatement stmt4 = conn.prepareStatement(sql4);
		stmt4.setInt(1, customerNo);
		stmt4.setString(2, customer.getCustomerPw());
		System.out.println(stmt4 + "<-- stmt3 insert테스트");
		
		int row4 = stmt4.executeUpdate();
		if (row4 != 1) {
			conn.rollback();
			return;
		}
		
		conn.commit();
		rs1.close();
		stmt1.close();
		stmt2.close();
		stmt3.close();
		stmt4.close();
	}
	
	// 고객 비밀번호 수정 반영
	public void updateCustomerPw(String oldPw, String newPw, int customerNo, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		
		String sql1 = "SELECT customer_pw customerPw FROM customer_pw_history WHERE customer_no=? AND customer_pw = PASSWORD(?)";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		stmt1.setInt(1, customerNo);
		stmt1.setString(2, newPw);
		ResultSet rs = stmt1.executeQuery();
		if(rs.next()) {
			conn.rollback();
			String msg = URLEncoder.encode("이전 비밀번호와 동일합니다. 비밀번호를 다르게 설정해주세요.", "UTF-8");
			response.sendRedirect(request.getContextPath()+"/updateCustomerPwForm.jsp?msg="+msg);
			
			return;
		}
		
		String sql2 = "UPDATE customer SET customer_pw = PASSWORD(?), updatedate = NOW() WHERE customer_no = ? AND customer_pw = PASSWORD(?)";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, newPw);
		stmt2.setInt(2, customerNo);
		stmt2.setString(3, oldPw);
	
		int row2 = stmt2.executeUpdate();
		
		if(row2 != 1) {
			conn.rollback();
			String msg = URLEncoder.encode("비밀번호를 입력하세요", "UTF-8");
			response.sendRedirect(request.getContextPath()+"/updateCustomerPwForm.jsp?msg"+msg);
			return;
		}
		String sql3 = "INSERT INTO customer_pw_history(customer_no, customer_pw, createdate) VALUES (?, PASSWORD(?), NOW())";
		PreparedStatement stmt3 = conn.prepareStatement(sql3);
		stmt3.setInt(1, customerNo);
		stmt3.setString(2, newPw);
		
		int row3 = stmt3.executeUpdate();
		if(row3 != 1) {
			conn.rollback();
			return;
		}
		response.sendRedirect(request.getContextPath()+"/customerOne.jsp");
	
		conn.commit();
		stmt1.close();
		stmt2.close();
		stmt3.close();
		rs.close();
		conn.close();
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
	
	
	// 고객 상세정보 customerOne.jsp
	public ArrayList<HashMap<String, Object>> customerOne(int customerNo) throws Exception{

		Class.forName("org.mariadb.jdbc.Driver");  
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                             
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		/*
		SELECT customer_id customerId, customer_pw customerPw, createdate, updatedate 
		FROM customer c inner join customer_detail cd
		ON c.customer_no = cd.customer_no inner join customer_addr ca on c.customer_no = ca.customer_no
		*/
		
		String sql = "SELECT c.customer_no customerNo, c.customer_id customerId, c.customer_pw customerPw, c.createdate, c.updatedate, cd.customer_name customerName, cd.customer_phone customerPhone, ca.address customerAddress FROM customer c inner join customer_detail cd ON c.customer_no = cd.customer_no inner join customer_addr ca on c.customer_no = ca.customer_no WHERE c.customer_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		System.out.print(stmt + "<--stmt");
		ResultSet rs = stmt.executeQuery();
			
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		if(rs.next()){
			
			HashMap<String, Object> c = new HashMap<>();
			c.put("customerNo", rs.getString("customerNo"));
			c.put("customerId", rs.getString("customerId"));
			c.put("customerName", rs.getString("customerName"));
			c.put("customerPhone", rs.getString("customerPhone"));
			c.put("customerAddress", rs.getString("customerAddress"));
			c.put("createdate", rs.getString("createdate"));
			c.put("updatedate", rs.getString("updatedate"));
			
			list.add(c);
		}
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}


	// 고객 상세정보 호출
	public void updateCustomerOne(String newName, String newPhone, String newAddr, int customerNo) throws Exception {
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		   
	// 이름과 전화번호 업데이트 쿼리
		String sql1 = "UPDATE customer_detail SET customer_name = ?, customer_phone = ?, updatedate=NOW() WHERE customer_no=?";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		stmt1.setString(1, newName); 
		stmt1.setString(2, newPhone);
		stmt1.setInt(3, customerNo);	
		System.out.println(stmt1 + "<-- stmt");
			
		int row1 = stmt1.executeUpdate();
		if (row1 !=1 ) {
			conn.rollback();
			return;
		}
		
	// 주소 업데이트 쿼리
		String sql2 = "UPDATE customer_addr SET address = ?, updatedate = NOW() WHERE customer_no = ?";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, newAddr);
		stmt2.setInt(2, customerNo);
		
		int row2 = stmt2.executeUpdate();
		if(row2 != 1) {
			conn.rollback();
			return;
		}
		stmt1.close();
		stmt2.close();
		conn.close();
	}
}
