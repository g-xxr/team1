package dao;

import java.sql.*;
import java.util.*;
import vo.*;

public class QuestionDao {	
//----- question 관리자--------------------------------------------------	
	// question.jsp	문의사항 리스트 
	public ArrayList<HashMap<String, Object>> selectQuestion(int beginRow, int rowPerPage) throws Exception {
		
		
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT q.question_no questionNo, g.goods_no goodsNo, c.customer_no customerNO, q.question_title questionTitle, q.question_content questionContent, q.createdate, q.updatedate FROM question q INNER JOIN customer c ON q.question_no = c.customer_no INNER JOIN goods g ON g.goods_no = q.customer_no ORDER BY createdate desc";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery(); // jdbc환경의 모델
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>(); 
		if(rs.next()) {
			HashMap<String, Object> q = new HashMap<String, Object>();
			q.put("questionNo", rs.getInt("questionNo"));
			q.put("goodsNo", rs.getInt("goodsNo"));
			q.put("customerNo", rs.getInt("customerNo"));
			q.put("questionTitle", rs.getString("questionTitle"));
			q.put("questionContent", rs.getString("questionContent"));
			q.put("createdate", rs.getString("createdate"));
			q.put("updatedate", rs.getString("updatedate"));
			list.add(q);
		}
		conn.close();
		stmt.close();
		
		return list;
	}

	// questionOne.jsp 문의사항 상세확인
		public ArrayList<HashMap<String, Object>> questionOne(int questionNo) throws Exception {
			ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
			
			int row = 0;
			Class.forName("org.mariadb.jdbc.Driver");
			String url = "jdbc:mariadb://localhost:3306/mall";
			String dbuser = "root";
			String dbpw = "java1234";
			Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
			
			String sql = "SELECT question_no questionNo, goods_no goodsNo, customer_no customerNO, question_title questionTitle, question_content questionContent, createdate, updatedate FROM question WHERE goods_no = ?"; 
						
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, questionNo);	
			ResultSet rs = stmt.executeQuery(); // jdbc환경의 모델
			list = new ArrayList<>(); // 일반화된 모델값으로 변환
			if(rs.next()) {
				HashMap<String, Object> q = new HashMap<String, Object>();
				q.put("questionNo", rs.getInt("questionNo"));
				q.put("goodsNo", rs.getInt("goodsNo"));
				q.put("customerNo", rs.getInt("customerNo"));
				q.put("questionTitle", rs.getString("questionTitle"));
				q.put("questionContent", rs.getString("questionContent"));
				q.put("createdate", rs.getString("createdate"));
				q.put("updatedate", rs.getString("updatedate"));
				list.add(q);
			}
			conn.close();
			stmt.close();
			
			return list;
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		/*	(적용 예정)	
		// 상품상세 정보에서의 문의 정보
			
		public ArrayList<HashMap<String, Object>> selectQuestionListByPage( int goodsNo, int customerNO, int beginRow, int rowPerPage) throws Exception{
			ArrayList<HashMap<String, Object>> list = new ArrayList<>();
			
			int row = 0;
			Class.forName("org.mariadb.jdbc.Driver");
			String url = "jdbc:mariadb://localhost:3306/mall";
			String dbuser = "root";
			String dbpw = "java1234";
			Connection conn = DriverManager.getConnection(url, dbuser, dbpw);

			String sql = "SELECT question_no questionNo, goods_no goodsNo, customer_no customerNO, question_title questionTitle, question_content questionContent, createdate, updatedate "
							FROM question WHERE goods_no = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo);
			stmt.setInt(2, customerNo);
			stmt.setInt(3, beginRow);
			stmt.setInt(4, rowPerPage);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> q = new HashMap<>();
				q.put("questionNo", rs.getString("questionNo"));
				q.put("goodsNo", rs.getInt("goodsNo"));
				q.put("customerNo", rs.getInt("customerNo"));
				q.put("questionTitle", rs.getString("qustionTitle"));
				q.put("questionContent", rs.getString("questionContent"));
				q.put("createdate", rs.getString("createdate"));
				q.put("updatedate", rs.getString("updatedate"));
				//System.out.println(q);
				list.add(q);
				
				conn.close();
				stmt.close();
			}
				return list;
			}		
	*/				
		
		
	
		
		
		
		
		
		
}
