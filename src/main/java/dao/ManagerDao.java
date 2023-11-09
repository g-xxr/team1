package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

import vo.*;

public class ManagerDao {

	// 로그인 (ID, PW) 일치하는지 확인
	public int ckIdPw(String managerId, String managerPw) throws Exception{
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");  
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                             
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT COUNT(*) FROM manager WHERE manager_id=? AND manager_pw= PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		stmt.setString(2, managerPw);
	
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
	
	// 관리자 상세정보  managerOne.jsp 호출 HashMap
	public HashMap<String, Object> getManagerData(String managerId) throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");  
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                             
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql =  "SELECT manager_id managerId, manager_pw managerPw, manager_name managerName, createdate, updatedate FROM manager WHERE manager_id =?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		ResultSet rs = stmt.executeQuery();
			
		HashMap<String, Object> m = new HashMap<>();
		if (rs.next()) {
		m.put("managerId", rs.getString("managerId"));
        m.put("managerPw", rs.getString("managerPw"));
        m.put("managerName", rs.getString("managerName"));
        m.put("createdate", rs.getString("createdate"));
        m.put("updatedate", rs.getString("updatedate"));
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return m;
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
