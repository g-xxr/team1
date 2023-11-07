package dao;

import java.sql.*;
import java.util.*;
import vo.*;

public class GoodsDao {
	
	// goodsList 호출 controller
	public ArrayList<Goods> goodsList(int beginRow, int rowPerPage)throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT goods_no, goods_title, goods_price, soldout, goods_memo, createdate, updatedate FROM goods LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		System.out.println(stmt + "<-- goodsList");
		ResultSet rs = stmt.executeQuery();
		
		// 더 일반화 된 모델 코드로 만들기
		ArrayList<Goods> list = new ArrayList<>();
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
		
		// 자원 닫기
		conn.close();
		}
		return list;
	}
	
	// goodsOne 호출 controller
	public Goods goodsOne(int goodsNo) throws Exception{
		Goods go = new Goods();
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	
		/* SQL goodsOne 쿼리문
		 * SELECT goods_no, goods_title, goods_price, soldout, goods_memo, createdate, updatedate FROM goods WHERE goods_no =?
		 */
		String sql = "SELECT goods_no, goods_title, goods_price, soldout, goods_memo, createdate, updatedate FROM goods WHERE goods_no =?";
		PreparedStatement stmt = conn.prepareStatement(sql);	
		stmt.setInt(1, goodsNo);
		System.out.println(stmt + "<-- goodsOne");
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			go.setGoodsNo(rs.getInt("goodsNo"));
			go.setGoodsTitle(rs.getString("goodsTitle"));
			go.setGoodsPrice(rs.getInt("goodsPrice"));
			go.setSoldout(rs.getString("soldout"));
			go.setGoodsMemo(rs.getString("goodsMemo"));
			go.setCreatedate(rs.getString("createdate"));
			go.setUpdatedate(rs.getString("updatedate"));
		// 자원 닫기
		conn.close();
		}
		return go;
		}
	
	// 상품 추가 controller : insertGoods
	 public int insertGoods(Goods g) throws Exception {
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	 
		/* Goods 추가 쿼리
		 * INSERT INTO goods(goods_no, goods_title, goods_price, soldout, goods_memo, createdate, updatedate) VALUES(?,?,?,?,?,NOW(),NOW())
		 */
		String sql = "INSERT INTO goods(goods_no, goods_title, goods_price, soldout, goods_memo, createdate, updatedate) VALUES(?,?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
//		stmt.setInt(1, g.getGoodsNo()); 이건 auto increment라 개별 설정 x
		stmt.setString(1, g.getGoodsTitle());
		stmt.setInt(2, g.getGoodsPrice());
		stmt.setString(3, g.getSoldout());
		stmt.setString(4, g.getGoodsMemo());
		
		System.out.println(stmt + "<-- insertGoods");
		row = stmt.executeUpdate(); // 삽입된 행 수를 반환
		
		// 자원 닫기
		conn.close();
		return row;
	 }
		
	 
		// 상품 수정 controller : updateGoods
		public int updateGoods(Goods g) throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
			
		/* SQL UPDATE쿼리문
		* UPDATE goods SET goods_no = ?, goods_title = ?, goods_price = ?, soldout = ?, goods_memo = ?, createdate = NOW(), updatedate = NOW() WHERE goods_no = ?
		*/
		String sql = "UPDATE goods SET goods_title = ?, goods_price = ?, soldout = ? , goods_memo = ?, createdate = NOW(), updatedate= NOW() WHERE goods_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, g.getGoodsTitle());
		stmt.setInt(2, g.getGoodsPrice());
		stmt.setString(3, g.getSoldout());
		stmt.setString(4, g.getGoodsMemo());
		stmt.setInt(5, g.getGoodsNo()); // WHERE 절에 해당하는 값 설정
			
		System.out.println(stmt + "<-- updateGoods");
		int row = stmt.executeUpdate(); // 업데이트된 행 수를 반환
			
		// 자원 닫기
		conn.close();
	
		return row;
		}
		 
		// 상품 삭제 controller : deleteGoods
		public int deleteGoods(int goodsNo) throws Exception{
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		/* SQL DELETE 쿼리문
		 * DELETE FROM goods WHERE goods_no = ?;
		 */
		String sql = "DELETE FROM goods WHERE goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		
		System.out.println(stmt + "<-- deleteGoods");
		row = stmt.executeUpdate();
		
		// 자원 닫기
		conn.close();
		return row;
		}
	}
