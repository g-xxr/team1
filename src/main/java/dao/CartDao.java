package dao;

import vo.*;
import java.sql.*;

public class CartDao {
	
	// 로그인 사용자 : 장바구니 조회, 장바구니 상세 페이지(orders로 넘어가나?-팀원들과 회의), 장바구니에 담겨있는 상품 갯수, 추가, 삭제
	
	
	// 장바구니 조회 
	public Cart cartOne(String loginId) throws Exception{
		Cart c = new Cart();
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		/*SQL cartOne 쿼리문
		 * SELECT cart_no, goods_no, customer_no, quantity, createdate, updatedate FROM cart WHERE cart_no = ?
		 */
		String sql = "SELECT cart_no, goods_no, customer_no, quantity, createdate, updatedate FROM cart WHERE cart_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, loginId);
		System.out.println(stmt + "<-- cartOne");
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
		c.setCartNo(rs.getInt("cartNo"));
		c.setGoodsNo(rs.getInt("goodsNo"));
		c.setCustomerNo(rs.getInt("customerNo"));
		c.setQuantity(rs.getInt("quantity"));
		c.setUpdatedate(rs.getString("createdate"));
		c.setUpdatedate(rs.getString("updatedate"));
		// 자원 닫기
		conn.close();	
		}
		return c;
	}
	
	// 이미 장바구니에 담긴 상품의 개수
	public int cartQuantity(int goodsNo, String loginId) throws Exception {
		int cartQuantity = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		
		String sql = "SELECT COUNT(*) FROM cart WHERE goods_no = ? AND customer_no = (SELECT customer_no FROM customer WHERE customer_id = ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		stmt.setString(2, loginId);
		System.out.println(stmt + "<-- cartQuantity");
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			cartQuantity = rs.getInt(1);
		}
		// 자원 닫기
		conn.close();	
		return cartQuantity;
	}
	
	// 장바구니 추가 controller
	public int insertCart(Cart c) throws Exception{
		int row =0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "INSERT INTO cart(cart_no, goods_no, customer_no, quantity, createdate, updatedate) VALUES(?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
//		stmt.setInt(1, c.getCartNo()); 이건 auto increment라 개별 설정 x
		stmt.setInt(1, c.getGoodsNo());
		stmt.setInt(2, c.getCustomerNo());
		stmt.setInt(3, c.getQuantity());
		
		System.out.println(stmt + "<-- insertCart");
		row = stmt.executeUpdate();
		
		// 자원 닫기
		conn.close();
		return row;
	}
	
	// 장바구니 삭제 controller
	public int deleteCart(int cartNo) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "DELETE FROM cart WHERE cart_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cartNo);
		int row = stmt.executeUpdate();
		
		// 자원 닫기
		conn.close();
		return row;
	}
}

