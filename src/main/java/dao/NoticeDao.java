package dao;

import java.sql.*;
import java.util.*;
import vo.*;

public class NoticeDao {

	
	//notice.jsp (고객 관리자 둘다 접근 가능)
	public ArrayList<Notice> selectNoticeList(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Notice> list = new ArrayList<>();
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT notice_no noticeNo, manager_no, notice_title, notice_content, createdate updatedate FROM notice ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);;
		ResultSet rs = stmt.executeQuery(); 
		 
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setManagerNo(rs.getInt("managerNo"));
			n.setNoticeTitle(rs.getString("noticeTitle"));
			n.setNoticeContent(rs.getString("noticeContent"));
			n.setCreatedate(rs.getString("createdate"));
			list.add(n);
			
	
		}
		conn.close();
		stmt.close();

		return list;
	}
	//noticeOne.jsp 
	public ArrayList<HashMap<String, Object>> noticeOne(int noticeNo) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT notice_no noticeNo, manager_no managerNo, notice_title noticeTitle, notice_content noticeContent, createdate, updatedate FROM notice WHERE notice_no = ? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);	
		ResultSet rs = stmt.executeQuery(); // jdbc환경의 모델
		list = new ArrayList<>(); // 일반화된 모델값으로 변환
		if(rs.next()) {
			HashMap<String, Object> o = new HashMap<String, Object>();
			o.put("noticeNo", rs.getInt("noticeNo"));
			o.put("managerNo", rs.getInt("managerNo"));
			o.put("noticeTitle", rs.getString("noticeTitle"));
			o.put("noticeContent", rs.getString("noticeContent"));
			o.put("createdate", rs.getString("createdate"));
			o.put("updatedate", rs.getString("updatedate"));
			list.add(o);
		}
		conn.close();
		stmt.close();
		
		return list;
	}
	
	//insertNoticeForm.jsp
	public int insertNotice(Notice notice) throws Exception{
		int row = 0;
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

	
}
	

