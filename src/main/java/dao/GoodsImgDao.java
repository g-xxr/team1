package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import vo.Goods;
import vo.GoodsImg;

public class GoodsImgDao {
	// 1. 상품 이미지 추가 controller
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
		stmt.setInt(1, gi.getGoodNo());
		stmt.setString(2, gi.getFilename());
		stmt.setString(3, gi.getOriginName());
		stmt.setString(4, gi.getContentType());
		stmt.setString(5, gi.getCreatedate());
		stmt.setString(6, gi.getUpdatedate());
		System.out.println(stmt + "<-- goodsImg Insert");
		row = stmt.executeUpdate();
		return row;
	}
	
	
}
