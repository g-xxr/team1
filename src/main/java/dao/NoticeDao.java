package dao;

import java.sql.*;
import java.util.*;
import vo.*;

public class NoticeDao {

	
	//notice.jsp
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
		ResultSet rs = stmt.executeQuery(); // jdbc환경의 모델
		list = new ArrayList<>(); // 일반화된 모델값으로 변환
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setManagerNo(rs.getInt("managerNo"));
			n.setNoticeTitle(rs.getString("noticeTitle"));
			n.setNoticeContent(rs.getString("noticeContent"));
			n.setCreatedate(rs.getString("createdate"));
			list.add(n);
		}

		return list;
	}
	//noticeOne.jsp
	public ArrayList<Notice> NoticeOne(int noticeNo) throws Exception {
		ArrayList<Notice> list = new ArrayList<>();
		
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT notice_no, manager_no managerNo, notice_title noticeTitle, notice_content noticeContent, createdate, updatedate FROM notice WHERE notice_no = ? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);	
		ResultSet rs = stmt.executeQuery(); // jdbc환경의 모델
		list = new ArrayList<>(); // 일반화된 모델값으로 변환
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setManagerNo(rs.getInt("managerNo"));
			n.setNoticeTitle(rs.getString("noticeTitle"));
			n.setNoticeContent(rs.getString("noticeContent"));
			n.setCreatedate(rs.getString("createdate"));
			list.add(n);
		}

		return list;
	}
		
	
	
	
	
	
	//insertNoticeAction.jsp 호출
	public int insertNotice(Notice notice) throws Exception {
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "INSERT INTO notice(manager_no, notice_title, notice_content, createdate, updatedate) VALUES(?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, notice.getManagerNo());
		stmt.setString(2, notice.getNoticeTitle());
		stmt.setString(3, notice.getNoticeContent());
		System.out.println(stmt + " <-- stmt insertNotice()");
		row = stmt.executeUpdate();
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
		return row;
	}
	

	
	
	
	
	
	
	
	
	
	
}
	

