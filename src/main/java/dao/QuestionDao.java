package dao;

import java.sql.*;
import java.util.*;
import vo.*;

public class QuestionDao {	

	// question.jsp	문의사항 리스트 
	public ArrayList<HashMap<String,Object>> selectQuestion(int beginRow, int rowPerPage) throws Exception {
				
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT q.question_no questionNo, g.goods_no goodsNo, c.customer_no customerNo, q.question_title questionTitle, q.question_content questionContent, q.createdate, q.updatedate FROM question q INNER JOIN customer c ON q.customer_no = c.customer_no INNER JOIN goods g ON q.goods_no = g.goods_no ORDER BY q.createdate DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery(); // jdbc환경의 모델
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		while(rs.next()) {
			HashMap<String, Object> q = new HashMap<>();
			q.put("questionNo", rs.getInt("questionNo"));
			q.put("goodsNo", rs.getInt("goodsNo"));
			q.put("customerNo", rs.getInt("customerNO"));
			q.put("questionTitle", rs.getString("questionTitle"));
			q.put("questionContent", rs.getString("questionContent"));
			q.put("createdate", rs.getString("createdate"));;
			q.put("updatedate", rs.getString("updatedate"));
			list.add(q);
	
			conn.close();
			stmt.close();
			
		}

		return list;
	}
	
	//question 페이징 호출
			public int questionPaging() throws Exception{
				Class.forName("org.mariadb.jdbc.Driver");
				String url = "jdbc:mariadb://localhost:3306/mall" ;
				String dbuser = "root";
				String dbpw = "java1234";
				Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
					
				// 페이징 sql
				String sql = "SELECT COUNT(*) FROM question";
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

	
		
	//insertQuestionForm.jsp 문의사항 추가
	public int insertQuestion(Question question) throws Exception{
		
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
			
		String sql = "INSERT INTO question(goods_no, customer_no, question_title, question_content, createdate, updatedate) VALUES(?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, question.getGoodsNo());
		stmt.setInt(2, question.getCustomerNo());		
		stmt.setString(3, question.getQuestionTitle());
		stmt.setString(4, question.getQuestionContent());
		
	    row = stmt.executeUpdate();
			
		conn.close();
		stmt.close();
		return row;
	}
	
	//insertComment
	public int insertComment(QuestionComment questioncomment) throws Exception{
	
		int row = 0 ; 
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "INSERT INTO question(question_no, manager_no, comment, createdate, updatedate) VALUES(?,?,?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, questioncomment.getQuestionNo());
		stmt.setInt(2, questioncomment.getManagerNo());
		stmt.setString(3, questioncomment.getComment());
		
		row = stmt.executeUpdate();
		
		conn.close();
		stmt.close();
		return row;		
	}
	

	// questionOne.jsp 문의사항 상세확인
	public ArrayList<HashMap<String, Object>> QuestionOne(int questionNo) throws Exception {
		
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT  q.question_no questionNo, g.goods_no goodsNo, g.goods_title goodsTitle, c.customer_no customerNo, c.customer_id customerId, q.question_title questionTitle, q.question_content questionContent, q.createdate, q.updatedate FROM question q  INNER JOIN customer c ON q.customer_no = c.customer_no INNER JOIN goods g ON q.goods_no = g.goods_no ORDER BY q.createdate DESC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, questionNo);		
		ResultSet rs = stmt.executeQuery(); // jdbc환경의 모델
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>(); 
		if(rs.next()) {
			HashMap<String, Object> q = new HashMap<String, Object>();
			q.put("questionNo", rs.getInt("questionNo"));
			q.put("goodsNo", rs.getInt("goodsNo"));
			q.put("goodsTitle", rs.getString("goodsTitle"));
			q.put("customerNo", rs.getInt("customerNo"));
			q.put("customerId", rs.getString("customerId"));
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
	
	
	// deleteQuestion.jsp 문의사항 삭제
	public int deleteQuestion(int question_no) throws Exception{
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";		
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "DELETE FROM question WHERE question_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, question_no);
		System.out.println(stmt + " <-- stmt deleteQuestion()");
		row = stmt.executeUpdate();
		
		conn.close();
		stmt.close();
		
		return row;
	}
	
	//updateQuestion문의사항 상세정보 수정
	public void updateQuestion(int questionNo, String questionTitle, String questionContent) throws Exception{
		
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";		
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "UPDATE question SET question_title = ?, question_content = ?, updatedate = NOW() WHERE question_no = ?";
				
		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setString(1, questionTitle);
		stmt.setString(2, questionContent);
		stmt.setInt(3, questionNo);
		
		System.out.println(stmt + " <-- stmt updateQuestion()");
		row = stmt.executeUpdate();
		
		if(row == 1) {
			System.out.println("수정 완료");
		} else {
			System.out.println("수정 실패");
		}
		
		conn.close();
		stmt.close();
		
	
	}
	
//------------------------------------------------------------------------
	//qComment
		
		
		
		
		
		
		
		
		
		
		
		
		
		
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
