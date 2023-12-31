package dao;

import java.sql.*;
import java.util.*;
import vo.*;

public class NoticeDao {
	
	//notice 공지사항 리스트 불러오기
	public ArrayList<Notice> selectNotice(int beginRow, int rowPerPage) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
					
		String sql = "SELECT notice_no noticeNo, manager_no managerNo, notice_title noticeTitle, notice_content noticeContent, createdate, updatedate FROM notice ORDER BY notice_no DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery(); 
		 
		ArrayList<Notice> list = new ArrayList<>(); 
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setManagerNo(rs.getInt("managerNo"));
			n.setNoticeTitle(rs.getString("noticeTitle"));
			n.setNoticeContent(rs.getString("noticeContent"));
			n.setCreatedate(rs.getString("createdate"));
			n.setUpdatedate(rs.getString("updatedate"));
			
			list.add(n);
		}
		conn.close();
		stmt.close();

		return list;
	}
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

		
	//noticeOne 공지사항 상세보기
	public Notice noticeOne(int noticeNo) throws Exception {					
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
				
		String sql = "SELECT notice_no noticeNo, manager_no managerNo, notice_title noticeTitle, notice_content noticeContent, createdate, updatedate FROM notice where notice_no = ? ";					
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);	
		ResultSet rs = stmt.executeQuery(); // jdbc환경의 모델
		 Notice n = null;
		 if(rs.next()) {
			 n = new Notice();
			 n.setNoticeTitle(rs.getString("noticeTitle"));
			 n.setNoticeContent(rs.getString("noticeContent"));
			 n.setCreatedate(rs.getString("Createdate"));
			 n.setUpdatedate(rs.getString("Updatedate"));

		}
		conn.close();
		rs.close();
		stmt.close();
				
		return n;
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
	
	//noticeDelete 공지사항 삭제
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
	//updateNotice 공지사항 수정
		public void updateNotice(int noticeNo, String noticeContent, int managerNo) throws Exception{
		
			Class.forName("org.mariadb.jdbc.Driver");
			String url = "jdbc:mariadb://localhost:3306/mall";
			String dbuser = "root";
			String dbpw = "java1234";		
			Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
			
			String sql = "UPDATE notice SET notice_content = ?, manager_no = ?, updatedate = NOW() WHERE notice_no = ?";				
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, noticeContent);
			stmt.setInt(2, managerNo);
			stmt.setInt(3, noticeNo);
			
			System.out.println(stmt + " <-- stmt updateNotice()");
			int row = stmt.executeUpdate();
			if(row ==1) {
				System.out.println("수정 완료");
			} else {
				System.out.println("수정 실패");
			}
			conn.close();
			stmt.close();
			
			
		}
	
	
	
	

	
}
	

