package dao;

import java.sql.*;
import java.util.*;
import vo.Goods;

public class GoodsDao {
	
	// goodsList 호출 controller
	public ArrayList<Goods> goodsList(int beginRow, int rowPerPage)throws Exception{
		ArrayList<Goods> list = new ArrayList<>();
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT goods_no, goods_title, goods_price, soldout, goods_memo, createdate, updatedate FROM goods LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		// 더 일반화 된 모델 코드로 만들기
		list = new ArrayList<>();
		while(rs.next()) {
			Goods g = new Goods();
			g.setGoodsNo(rs.getInt("goodsNo"));
			g.setGoodsTitle(rs.getString("goodsTitle"));
			g.setGoodsPrice(rs.getInt("goodsPrice"));
			g.setSoldout(rs.getString("soldout"));
			g.setGoodsMemo(rs.getString("goodsMemo"));
			g.setCreatedate(rs.getString("createdate"));
			g.setUpdatedate(rs.getString("updatedate"));
			list.add(g);
		}
		return list;
	}
		
	// 상품 추가 controller
	 public int insertGoods(Goods g) throws Exception {
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	 
		/* Goods 추가 쿼리
		 * INSERT INTO goods(goods_no, goods_title, goods_price, soldout, goods_memo, createdate, updatedate) VALUES(?,?,?,?,?,now(),now())
		 */
		String sql = "INSERT INTO goods(goods_no, goods_title, goods_price, soldout, goods_memo, createdate, updatedate) VALUES(?,?,?,?,?,now(),now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, g.getGoodsNo());
		stmt.setString(2, g.getGoodsTitle());
		stmt.setInt(3, g.getGoodsPrice());
		stmt.setString(4, g.getSoldout());
		stmt.setString(5, g.getGoodsMemo());
		stmt.setString(6, g.getCreatedate());
		stmt.setString(7, g.getUpdatedate());
		System.out.println(stmt + "<-- insertGoods");
		row = stmt.executeUpdate();
		return row;
		
	 }
		
		
	 
	// 상품 수정 폼 controller : updateGoodsForm.jsp
	 public int updateGoodsForm(Goods goods) throws Exception{
		Goods g = null;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		/* SQL 쿼리문
		 * SELECT goods_no, goods_title, goods_price, soldout, goods_memo FROM goods WHERE no=?
		 */
		String sql = "UPDATE goods_no, goods_title, goods_price, soldout, goods_memo FROM goods WHERE no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
	 
	 }
	 
}
