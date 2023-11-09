package dao;

import java.sql.*;
import java.util.*;
import vo.*;

	// review
		public class reviewDao {
		public ArrayList<HashMap<String, Object>> selectReview(int beginRow, int rowPerPage) throws Exception{
		
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT r.review_no reviewNo, o.order_no orderNo, r.review_content reviewContent, r.createdate createdate, r.updatedate updatedate FROM review r INNER JOIN orders o ON r.review_no = o.order_no ORDER BY createdate desc";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,beginRow);
		stmt.setInt(2,rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		if(rs.next()) {
			HashMap<String, Object> r = new HashMap<String, Object>();
			r.put("reviewNo", rs.getInt("reviewNo"));
			r.put("orderNo", rs.getInt("orderNo"));
			r.put("reviewTitle", rs.getString("reviewTitle"));
			r.put("reviewContent", rs.getString("reviewContent"));
			r.put("createdate", rs.getString("createdate"));
			r.put("updatedate", rs.getString("updatedate"));
			list.add(r);
		}
		conn.close();
		rs.close();
		
		return list;
	}
	// reviewOne 리뷰상세내역
	public Review selectReviewOne(int reviewNo) throws Exception {
		Review review = null;		

		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT review_no reviewNo, orders_no ordersNo, review_content reviewContent, createdate, updatedate FROM review WHERE review_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,reviewNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			review = new Review();
			review.setReviewNo(rs.getInt("reviewNo"));
			review.setOrdersNo(rs.getInt("orderNo"));
			review.setReviewContent(rs.getString("reviewContent"));
			review.setCreatedate(rs.getString("createdate"));
			review.setUpdatedate(rs.getString("updatedate"));
		}
		conn.close();
		rs.close();
		
		return review;
			
	}
	//insertReview
	// 관리자 추가 insertManagerAction.jsp 호출
		public int insertreview(Review review) throws Exception{
			int row =0;
			Class.forName("org.mariadb.jdbc.Driver");
			String url = "jdbc:mariadb://localhost:3306/mall";
			String dbuser = "root";
			String dbpw = "java1234";
			
			Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
			String sql = "INSERT INTO review(orders_no, review_content, createdate, updatedate) VALUES(?,?,NOW(),NOW())";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, review.getOrdersNo());
			stmt.setString(2, review.getReviewContent());
			System.out.println(stmt + " <-- stmt insertReview()");
			row = stmt.executeUpdate();
			
			conn.close();
			stmt.close();
			
			return row;
		}
	// deleteReview.jsp 리뷰 삭제
	public int deleteReview(int review_no) throws Exception{
		int row = 0;
	    Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";		
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
			
		String sql = "DELETE FROM review WHERE review_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, review_no);
		System.out.println(stmt + " <-- stmt deleteReview()");
		row = stmt.executeUpdate();
			
		conn.close();
		stmt.close();
			
		return row;
	}
	
	//updateReviewForm.jsp 문의사항 상세정보 수정
		public int updateReview(Review review) throws Exception{
			int row = 0;
			Class.forName("org.mariadb.jdbc.Driver");
			String url = "jdbc:mariadb://localhost:3306/mall";
			String dbuser = "root";
			String dbpw = "java1234";		
			Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
			
			String sql = "UPDATE review SET review_content = ? WHERE review_no = ?";
					
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, review.getReviewContent());			
			stmt.setInt(2, review.getReviewNo());
			System.out.println(stmt + " <-- stmt deleteQuestion()");
			row = stmt.executeUpdate();
			
			conn.close();
			stmt.close();
			
			return row;
		}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
