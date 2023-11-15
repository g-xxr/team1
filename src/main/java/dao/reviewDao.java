package dao;

import java.sql.*;
import java.util.*;
import vo.*;

	// review
		public class reviewDao {
	// selectReview 메소드를 통해 리뷰 목록을 가져오기
		public ArrayList<HashMap<String, Object>> selectReview(int beginRow, int rowPerPage) throws Exception{
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT r.review_no reviewNo, o.orders_no ordersNo, r.review_content reviewContent, r.createdate createdate, r.updatedate updatedate FROM review r INNER JOIN orders o ON r.review_no = o.orders_no ORDER BY createdate desc";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,beginRow);
		stmt.setInt(2,rowPerPage);
		ResultSet rs = stmt.executeQuery();
		// 결과값을 담을 ArrayList 생성
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		if(rs.next()) { // 결과가 있다면 HashMap에 결과를 담아 ArrayList에 추가
			HashMap<String, Object> r = new HashMap<String, Object>();
			r.put("reviewNo", rs.getInt("reviewNo"));
			r.put("ordersNo", rs.getInt("ordersNo"));
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
		
	// 주문내역이 있는지 고객 확인
	public void reviewOk(int ordersNo, String reviewContent, String loginId) throws Exception{
	Class.forName("org.mariadb.jdbc.Driver");
	String url = "jdbc:mariadb://localhost:3306/mall";
	String dbuser = "root";
	String dbpw = "java1234";
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	
	String sql = "SELECT orders_state ordersState FROM orders WHERE orders_no =?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, ordersNo);
	
	ResultSet rs = stmt.executeQuery();
	if(rs.next()) {
		System.out.println("주문번호 확인완료");
		String state = rs.getString("ordersState");
		if (state.equals("배송도착")) {
			System.out.println("배송이 완료된 제품입니다");
			}
		}
	
	//insertReview 리뷰를 추가하는 메소드
	String sql2 = "INSERT INTO review(orders_no, review_content, createdate, updatedate) VALUES(?,?,NOW(),NOW())";
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	stmt2.setInt(1, ordersNo);
	stmt2.setString(2, reviewContent);
	System.out.println(stmt + " <-- stmt insertReview()");
	int row = stmt.executeUpdate();
	if(row == 1) {
		System.out.println("리뷰입력 완료");
		} else {
		System.out.println("리뷰입력 실패");
		}
		conn.close();
		stmt.close();
	}
	
	// 주문번호 확인을 위한 조인문
	public ArrayList<ReviewOrdersGoods> reviewOrdersNoCheck(String loginId)throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall" ;
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		ArrayList<ReviewOrdersGoods> reviewList = new ArrayList<>();
		String sql = "SELECT o.orders_no ordersNo, g.goods_title goodsTitle FROM customer c JOIN orders o on c.customer_no= o.customers_no JOIN goods g ON o.goods_no = g.goods_no WHERE customer_id=? AND o.orders_state = '배송완료'";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, loginId);
		ResultSet rs = stmt.executeQuery();
		System.out.println(stmt+"<-- OrdersNo");
			while(rs.next()) {
				ReviewOrdersGoods rog = new ReviewOrdersGoods();
				rog.setOrdersNo(rs.getInt("ordersNo"));
				rog.setGoodsTitle(rs.getString("goodsTitle"));
				
				reviewList.add(rog);
			}
			System.out.println(reviewList);
			return reviewList;
}

	
	
	// selectReviewOne 특정 리뷰 상세 내역을 호출하는 메소드
	public Review selectReviewOne(int reviewNo) throws Exception {
		Review review = null;		

		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT r.review_no reviewNo, o.orders_no ordersNo, r.review_content reviewContent, r.createdate, r.updatedate FROM review r inner join orders o on r.orders_no = o.orders_no WHERE review_no = ?";
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

	// deleteReview.jsp 리뷰를 삭제하는 메소드
	public int deleteReview(int reviewNo) throws Exception{
		int row = 0;
	    Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";		
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
			
		String sql = "DELETE FROM review WHERE review_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, reviewNo);
		row = stmt.executeUpdate();
			
		conn.close();
		stmt.close();
			
		return row;
	}
	
	//updateReviewForm.jsp 리뷰의 내용을 수정하는 메소드
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
