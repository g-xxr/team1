package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

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
	public int insertManager(Manager manager) throws Exception{
		int row =0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		String sql = "INSERT INTO manager(manager_id, manager_pw, manager_name, createdate, updatedate) VALUES(?, PASSWORD(?),?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, manager.getManagerId());
		stmt.setString(2, manager.getManagerPw());
		stmt.setString(3, manager.getManagerName());
		System.out.println(stmt + " <-- stmt insertManager()");
		row = stmt.executeUpdate();
		return row;
	}
	
	// 관리자 비밀번호 수정 updateManagerPwAction.jsp 호출
	public int updateManagerPw(Manager manager) throws Exception{
		int row = 0 ;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	
	// 입력한 비밀번호가 예전 번호와 일치하는지 확인.
		String sql = "UPDATE manager SET manager_pw = PASSWORD(?), updatedate = NOW() WHERE manager_id=? AND manager_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, manager.getNewPw()); // 새롭게 설정한 비번이어야 함
		stmt.setString(2, manager.getManagerId());
		stmt.setString(3, manager.getManagerPw());// 전에 사용했던 비번.
		System.out.println(stmt + "<-- stmt");

		row = stmt.executeUpdate();
		stmt.close();
		conn.close();
	
		return row;

	}
	
	// 관리자 정보 삭제 deleteCustomerAction.jsp
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
