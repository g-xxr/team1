package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.*;
import vo.*;

public class ManagerDao {

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
		stmt.setString(2, manager.getManagerPw());					// 전에 사용했던 비번.
		System.out.println(stmt + "<-- stmt");
			
	row = stmt.executeUpdate();
	return row;
	

	}
	
}
