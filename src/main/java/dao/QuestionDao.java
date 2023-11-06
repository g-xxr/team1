package dao;

import java.sql.*;
import java.util.*;
import vo.*;

public class QuestionDao {	
//----- question 관리자--------------------------------------------------	
		
	// question.jsp
		
		public ArrayList<Question> selectQuestionList(int beginRow, int rowPerPage) throws Exception {
			ArrayList<Question> list = new ArrayList<>();
			
			Class.forName("org.mariadb.jdbc.Driver");
			String url = "jdbc:mariadb://localhost:3306/mall";
			String dbuser = "root";
			String dbpw = "java1234";
			Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
			
			String sql = "SELECT question_no, goods_no, question_title, question_content, createdate updatedate FROM question ";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			ResultSet rs = stmt.executeQuery(); // jdbc환경의 모델
			list = new ArrayList<>(); // 일반화된 모델값으로 변환
			while(rs.next()) {
				Question q = new Question();
				q.setQuestionNo(rs.getInt("questionNo"));
				q.setGoodsNo(rs.getInt("goodsNo"));
				q.setCustomerNo(rs.getInt("customerNo"));
				q.setQuestionTitle(rs.getString("questionTitle"));
				q.setQuestionContent(rs.getString("questionContent"));
				q.setCreatedate(rs.getString("createdate"));
				q.setUpdatedate(rs.getString("updatedate"));
				list.add(q);
			}
			return list;
		}
		
		
		
		
		
		
		
}
