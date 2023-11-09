package dao;

import java.sql.*;
import java.util.*;
import vo.*;

public class NoticeDao {

	
	//notice.jsp (고객 관리자 둘다 접근 가능)
	public ArrayList<HashMap<String, Object>> selectNotice(int beginRow, int rowPerPage) throws Exception {
		
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT n.notice_no noticeNo, m.manager_no mangerNo, n.notice_title noticeTitle, n.notice_content noticeContent, n.createdate, n.updatedate FROM notice n INNER JOIN manager m ON n.notice_no = m.manager_no";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);;
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
	//noticeOne.jsp 
	public Notice selectNoticeOne(int noticeNo) throws Exception {
		Notice notice = null;		
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
				
		String sql = "SELECT notice_no noticeNo, manager_no, notice_title, notice_content, createdate updatedate FROM notice ";
							
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);	
		ResultSet rs = stmt.executeQuery(); // jdbc환경의 모델
		if(rs.next()) {
			notice = new Notice();
			notice.setNoticeNo(rs.getInt("noticeNo"));
			notice.setManagerNo(rs.getInt("managerNo"));
			notice.setNoticeTitle(rs.getString("noticeTitle"));
			notice.setNoticeContent(rs.getString("noticeContent"));
				
		}
		conn.close();
		stmt.close();
				
		return notice;
	}
	
	//insertNoticeForm.jsp
	public int insertNotice(Notice notice) throws Exception{
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "INSERT INTO notice(manager_no, notice_title, notice_content, createdate, updatedate) VALUES(?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setInt(3, notice.getManagerNo());
		int row = stmt.executeUpdate();
				
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
	//updateQuestionForm.jsp 문의사항 상세정보 수정
		public int updateNotice(int notice_no) throws Exception{
			int row = 0;
			Class.forName("org.mariadb.jdbc.Driver");
			String url = "jdbc:mariadb://localhost:3306/mall";
			String dbuser = "root";
			String dbpw = "java1234";		
			Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
			
			String sql = "UPDATE notice SET notice_title = ?, notice_content = ?, updatedate = now() WHERE notice_no = ?";				
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, notice_no);
			System.out.println(stmt + " <-- stmt updateNotice()");
			row = stmt.executeUpdate();
			
			conn.close();
			stmt.close();
			
			return row;
		}
	
	
	
	

	
}
	

