package dao;

import java.sql.*;
import java.util.*;
import vo.*;

public class NoticeDao {

	//notice 페이징 호출
		public int noticePaging() throws Exception{
			Class.forName("org.mariadb.jdbc.Driver");
			String url = "jdbc:mariadb://localhost:3306/mall" ;
			String dbuser = "root";
			String dbpw = "java1234";
			Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
			
			// 페이징 sql
			String sql = "SELECT COUNT(*) FROM notice";
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			int totalRow = 0;
			if(rs.next()) {
				totalRow = rs.getInt("COUNT(*)"); // rs1.getInt(1)
			}
			// 자원 닫기
			conn.close();
			stmt.close();
			rs.close();
			
			return totalRow;
		}
	
	//notice.jsp (고객 관리자 둘다 접근 가능)
	public ArrayList<HashMap<String, Object>> selectNotice(int beginRow, int rowPerPage) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT n.notice_no noticeNo, m.manager_no managerNo, n.notice_title noticeTitle, n.notice_content noticeContent, n.createdate, n.updatedate FROM notice n INNER JOIN manager m ON n.manager_no = m.manager_no LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery(); 
		 
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>(); 
		if(rs.next()) {
			HashMap<String, Object> n = new HashMap<String, Object>();
			n.put("noticeNo", rs.getInt("noticeNo"));
			n.put("managerNo", rs.getInt("managerNo"));			
			n.put("noticeTitle", rs.getString("noticeTitle"));
			n.put("noticeContent", rs.getString("noticeContent"));
			n.put("createdate", rs.getString("createdate"));
			n.put("updatedate", rs.getString("updatedate"));
			list.add(n);
		}
		conn.close();
		stmt.close();

		return list;
	}
	

	//noticeOne 공지사항 상세보기
	public ArrayList<HashMap<String, Object>> noticeOne(int noticeNo) throws Exception {					
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
				
		String sql = "SELECT notice_no noticeNo, manager_no managerNo, notice_title noticeTitle, notice_content noticeContent, createdate, updatedate FROM notice where notice_no = ? ";					
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);	
		ResultSet rs = stmt.executeQuery(); // jdbc환경의 모델
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();	
		if(rs.next()) {
			HashMap<String, Object> no = new HashMap<String, Object>();
			no.put("noticeNo", rs.getInt("noticeNo"));
			no.put("managerNo", rs.getInt("managerNo"));
			no.put("noticeTitle", rs.getString("noticeTitle"));
			no.put("noticeContent", rs.getString("noticeContent"));
			no.put("createdate", rs.getString("createdate"));
			no.put("updatedate", rs.getString("updatedate"));		
			list.add(no);			
		}
		conn.close();
		rs.close();
		stmt.close();
				
		return list;
	}
	
	//insertNotice 공지사항 추가
	public int insertNotice(Notice notice) throws Exception{
		
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		
		String sql = "INSERT INTO notice(manager_no, notice_title, notice_content, createdate, updatedate) VALUES(?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, notice.getManagerNo());
		stmt.setString(2, notice.getNoticeTitle());
		stmt.setString(3, notice.getNoticeContent());		
		row = stmt.executeUpdate();
				
		conn.close();
		stmt.close();
		
		return row;
	}
	
	//noticeDeleteAction.jsp
	public int deleteNotice(int notice_no) throws Exception{
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "DELETE FROM notice WHERE notice_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, notice_no);
		System.out.println(stmt + " <-- stmt deleteNotice()");
		row = stmt.executeUpdate();
		
		conn.close();
		stmt.close();
		
		return row;
	}
	//updateNoticeForm.jsp 문의사항 상세정보 수정
		public int updateNotice(int noticeNo, String noticeTitle, String noticeContent, int managerNo) throws Exception{
		
			Class.forName("org.mariadb.jdbc.Driver");
			String url = "jdbc:mariadb://localhost:3306/mall";
			String dbuser = "root";
			String dbpw = "java1234";		
			Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
			
			String sql = "UPDATE notice SET manager_no = ?, notice_title = ?, notice_content = ?, updatedate = now() WHERE notice_no = ?";				
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, noticeTitle);
			stmt.setString(2, noticeContent);
			stmt.setInt(3, noticeNo);
			stmt.setInt(4, managerNo);
			System.out.println(stmt + " <-- stmt updateNotice()");
			int row = stmt.executeUpdate();
			
			conn.close();
			stmt.close();
			
			return row;
		}
	
	
	
	

	
}
	

