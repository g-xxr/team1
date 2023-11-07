package dao;

import java.io.File;
import java.sql.*;
import vo.*;

public class GoodsImgDao {
	
	// 상품 이미지 추가 controller : insertGoodsImg
	public int insertGoodsImg(GoodsImg gi) throws Exception {
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		/* GoodsImg 추가 쿼리
		 * INSERT INTO goodsImg(goods_no, filename, origin_name, content_type, createdate, updatedate) VALUES (?,?,?,?,now(),now())
		 */
		String sql = "INSERT INTO goodsImg(goods_no, filename, origin_name, content_type, createdate, updatedate) VALUES (?,?,?,?,now(),now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, gi.getGoodsNo());
		stmt.setString(2, gi.getFilename());
		stmt.setString(3, gi.getOriginName());
		stmt.setString(4, gi.getContentType());
		stmt.setString(5, gi.getCreatedate());
		stmt.setString(6, gi.getUpdatedate());
		System.out.println(stmt + "<-- goodsImg Insert");
		row = stmt.executeUpdate();
		
		// 자원 닫기
		conn.close();
		return row;
	}
	
	// 상품 이미지 수정
	public int updateGoodsImg(GoodsImg gi) throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
			
		/* SQL UPDATE쿼리문
		* UPDATE goodsImg SET goods_no = ?, filename = ?, origin_name = ?, content_type = ?, createdate = NOW(), updatedate = NOW() WHERE goods_no = ?
		*/
		String sql = "UPDATE goods SET goods_title = ?, goods_price = ?, soldout = ? , goods_memo = ?, createdate = NOW(), updatedate= NOW() WHERE goods_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, gi.getFilename());
		stmt.setString(2, gi.getOriginName());
		stmt.setString(3, gi.getContentType());
		stmt.setInt(4, gi.getGoodsNo()); // WHERE 절에 해당하는 값 설정
			
		System.out.println(stmt + "<-- updateGoodsImg");
		int row = stmt.executeUpdate(); // 업데이트된 행 수를 반환
			
		// 자원 닫기
		conn.close();
		return row;
	}
	
	// 상품 이미지 삭제
	public int deleteGoodsImg(int goodsNo) throws Exception{
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);	// 트랜잭션 시작
		
		/* 이미지 삭제 시
		 * SQL deleteGoodsImg 쿼리문
		 * DELETE FROM goodsImg WHERE goods_no = ?;
		 */
		String sql = "DELETE FROM goodsImg WHERE goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		System.out.println(stmt + "<-- deleteGoodsImg");
		row = stmt.executeUpdate();
		
		if(row == 1) {
			// 상품 삭제 시
			String sql2 = "DELETE FROM goods WHERE goods_no = ?";
			PreparedStatement stmt2 = conn.prepareStatement(sql2);
			stmt2.setInt(1, goodsNo);
			int row2 = stmt2.executeUpdate();
			if(row2 == 1){
				conn.commit();		// 커밋하고
			} else {
				conn.rollback();	// 롤백
			}
		}
		// 자원 닫기
		conn.close();
		return row;
		}
	
	// 상품 이미지만 삭제 (상품정보 수정시 사용됨)
	public int deleteGoodsImgFile(int goodsNo) throws Exception{
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT origin_name FROM goodsImg WHERE goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		System.out.println(stmt + "<-- deleteGoodsImgFile");
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
		String originName = rs.getString("origin_name");
		File f = new File(originName);
		if(f.exists()){
			f.delete();
			row = 1; // 파일 삭제 성공
		}
	}
		return row;
	}
}
