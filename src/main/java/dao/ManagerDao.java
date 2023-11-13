package dao;

import java.net.URLEncoder;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vo.*;

public class ManagerDao {

	
	public ResultSet managerLogin(Manager manager) throws Exception{

		Class.forName("org.mariadb.jdbc.Driver");  
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                             
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT manager_no managerNo FROM manager WHERE manager_id=? AND manager_pw= PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, manager.getManagerId());
		stmt.setString(2, manager.getManagerPw());
		ResultSet rs = stmt.executeQuery();
		
		conn.close();
		stmt.close();
		rs.close();
		
		return rs;
	}
	
	// 관리자 상세정보  managerOne.jsp 호출 HashMap
	public ArrayList<Manager> managerOne(int managerNo) throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");  
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                             
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql =  "SELECT manager_id managerId, manager_pw managerPw, manager_name managerName, createdate, updatedate FROM manager WHERE manager_no =?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, managerNo);
		ResultSet rs = stmt.executeQuery();
			
		ArrayList<Manager> list = new ArrayList<>();
		if (rs.next()) {
			Manager m = new Manager();
		m.setManagerId(rs.getString("managerId"));
		m.setManagerName(rs.getString("managerName"));
		m.setCreatedate(rs.getString("createdate"));
		m.setUpdatedate(rs.getString("updatedate"));
		
		list.add(m);
		}
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	
	// 관리자 추가 insertManagerAction.jsp 호출
	public void insertManager(Manager manager, ManagerPwHistory managerpwhistory) throws Exception{
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		
		String sql1 = "INSERT INTO manager(manager_id, manager_pw, manager_name, createdate, updatedate) VALUES(?, PASSWORD(?),?, NOW(), NOW())";
		PreparedStatement stmt1 = conn.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);
		stmt1.setString(1, manager.getManagerId());
		stmt1.setString(2, manager.getManagerPw());
		stmt1.setString(3, manager.getManagerName());
		System.out.println(stmt1 + " <-- stmt insertManager()");
		int row1 = stmt1.executeUpdate();
		
		ResultSet rs = stmt1.getGeneratedKeys();
		int managerNo = 0; //
		if (rs.next()){
			managerNo = rs.getInt(1);
		} else {
			conn.rollback();
			return;
		}
		
		String sql2 = "INSERT INTO manager_pw_history(manager_no, manager_pw, createdate) VALUES(?, PASSWORD(?), NOW())";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, managerNo); // 위 SQL문에서 얻은 manager_no 설정.
		stmt2.setString(2, managerpwhistory.getManagerPw());
		System.out.println(stmt2 + " <-- stmt2 managerpwhistory()");
	
		int row2 = stmt2.executeUpdate();
		if (row2 !=1) {
			conn.rollback();
			return;
		}
		conn.commit();
		rs.close();
		stmt1.close();
		stmt2.close();
	}
	
	// 관리자 정보 수정 updateManagerOneAction.jsp 호출
	public void updateManagerOne(int managerNo, String managerName) throws Exception{
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "UPDATE manager SET manager_name = ?, updatedate = NOW() WHERE manager_no =?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,managerName);
		stmt.setInt(2,managerNo);
		
		int row = stmt.executeUpdate();
	}
	
	// 관리자 비밀번호 수정 updateManagerPwAction.jsp 호출
	public void updateManagerPw(String oldPw, String newPw, int managerNo, HttpServletRequest request, HttpServletResponse response) throws Exception{

		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		
	// 입력한 비밀번호가 예전 번호와 일치하는지 확인.
		String sql1 = "SELECT manager_pw managerPw FROM manager_pw_history WHERE manager_no=? AND manager_pw = PASSWORD(?)";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		stmt1.setInt(1, managerNo);
		stmt1.setString(2, newPw);
		ResultSet rs = stmt1.executeQuery();
		if(rs.next()) {
			conn.rollback();
			String msg = URLEncoder.encode("이전 비밀번호와 동일합니다. 비밀번호를 다르게 설정해주세요.", "UTF-8");
			response.sendRedirect(request.getContextPath()+"/updateManagerPwForm.jsp?msg="+msg);
			return;
		}
			
		String sql2 = "UPDATE manager SET manager_pw = PASSWORD(?), updatedate = NOW() WHERE manager_no=? AND manager_pw = PASSWORD(?)";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, newPw); // 새롭게 설정한 비번이어야 함
		stmt2.setInt(2, managerNo);
		stmt2.setString(3, oldPw);// 전에 사용했던 비번.
		System.out.println(stmt2 + "<-- stmt");

		int row2 = stmt2.executeUpdate();
		if(row2 !=1) {
			conn.rollback();
			String msg = URLEncoder.encode("비밀번호를 입력하세요", "UTF-8");
			response.sendRedirect(request.getContextPath()+"/updateCustomerPwForm.jsp?msg="+msg);			
			return;
		}
		
		String sql3 = "INSERT INTO manager_pw_history(manager_no, manager_pw, createdate) VALUES (?, PASSWORD(?), NOW())";
		PreparedStatement stmt3 = conn.prepareStatement(sql3);
		stmt3.setInt(1, managerNo);
		stmt3.setString(2, newPw);
		
		int row3 = stmt3.executeUpdate();
		if(row3 != 1) {
			conn.rollback();
			return;
		}
		response.sendRedirect(request.getContextPath()+"/managerOne.jsp");
		
		conn.commit();
		stmt1.close();
		stmt2.close();
		stmt3.close();
		rs.close();
		conn.close();

	}
	
	// 관리자 정보 삭제 deleteManagerAction.jsp
	public int deleteManager(Manager manager) throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");  
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                             
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);

		String sql = "DELETE FROM manager WHERE manager_id =? AND manager_pw =PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, manager.getManagerId());
		stmt.setString(2, manager.getManagerPw());
		
		int row = stmt.executeUpdate();
		stmt.close();
		conn.close();

		
		return row;
	}
	
	
}
