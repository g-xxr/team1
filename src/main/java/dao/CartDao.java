package dao;

import java.sql.*;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import vo.*;


public class CartDao {
	
	// 로그인 사용자 : 장바구니 조회, 장바구니 상세 페이지(orders로 넘어가나?-팀원들과 회의), 장바구니에 담겨있는 상품 갯수, 추가, 삭제
	
	// cartList 호출
	public ArrayList<HashMap<String, Object>> cartList(int customerNo)throws Exception{
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		/*
		 * 쿼리문
		 * SELECT g.goods_title, g.goods_price, c.quantity, gi.filename
		 *   FROM goods g INNER JOIN cart c
		 *     ON g.goods_no = c.goods_no INNER JOIN goods_img gi
		 *     ON gi.goods_no = g.goods_no
		 *  WHERE c.customer_no = ?
		 */
		
		String sql = "SELECT g.goods_title goodsTitle, g.goods_price goodsPrice, c.cart_no cartNo, c.quantity quantity, gi.filename filename FROM goods g INNER JOIN cart c ON g.goods_no = c.goods_no INNER JOIN goods_img gi ON gi.goods_no = g.goods_no WHERE c.customer_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<HashMap<String, Object>> cartlist = new ArrayList<>();
		while(rs.next()) {	// hashmap 사용해보기
			HashMap<String, Object> map = new HashMap<>();
			map.put("goodsTitle", rs.getString("goodsTitle"));
			map.put("goodsPrice", rs.getInt("goodsPrice"));
			map.put("cartNo", rs.getInt("cartNo"));
			map.put("quantity", rs.getInt("quantity"));
			map.put("filename", rs.getString("filename"));
			cartlist.add(map);
		}
		// 자원닫기
		rs.close();
		conn.close();
		stmt.close();
		
		return cartlist;
	}
	
	// 카트 번호 받아오기
	public ArrayList<Integer> getCartNo(int customerNo) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT cart_no cartNo FROM cart WHERE customer_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		ResultSet rs = stmt.executeQuery();
		ArrayList<Integer> list = new ArrayList<>();
		while(rs.next()) {
			list.add(rs.getInt("cartNo"));
		}
		
		conn.close();
		stmt.close();
		rs.close();
		
		return list;
	}
	
	// 이미 장바구니에 담긴 상품의 개수
	public int cartQuantity(int customerNo) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT COUNT(*) FROM cart WHERE customer_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		System.out.println(stmt + "<-- cartQuantity");
		
		ResultSet rs = stmt.executeQuery();
		int cartQuantity = 0;
		if(rs.next()) {
			cartQuantity = rs.getInt(1);
		}
		// 자원 닫기
		rs.close();
		conn.close();
		stmt.close();
		
		return cartQuantity;
	}
	
	// 장바구니 추가 controller
	public void insertCart(Cart c) throws Exception{
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "INSERT INTO cart(goods_no, customer_no, quantity, createdate, updatedate) VALUES(?,?,1,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
//		stmt.setInt(1, c.getCartNo()); 이건 auto increment라 개별 설정 x
		stmt.setInt(1, c.getGoodsNo());
		stmt.setInt(2, c.getCustomerNo());
		System.out.println(stmt + "<-- insertCart");
		
		int row = stmt.executeUpdate();
		if(row != 1) {
			conn.rollback();
			return;
		}
		// 자원 닫기
		conn.close();
		stmt.close();
	}
		
	
	// 장바구니 update 수량 
	public void updateCart(ArrayList<Integer> cartsNo, HttpServletRequest request) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		for(int cartNo : cartsNo) { // 특정 고객에 대한 장바구니 번호들을 1개씩 가져 오기 
			
			String cartNoToString = Integer.toString(cartNo);
			
			// <input> 태그의 이름을 cartNo로 설정했기 때문에 각각의 cartNo 에 대한 quantity를 가져 옴
			int updateQuantity = Integer.parseInt(request.getParameter(cartNoToString)); 
			
			String sql = "UPDATE cart SET quantity = ?, updatedate = now() WHERE cart_no = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, updateQuantity);
			stmt.setInt(2, cartNo);
			stmt.executeUpdate();
			
			stmt.close();
		}
		conn.close();
	}
	
	// 장바구니 삭제 controller
	public void deleteCart(int cartNo) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "DELETE FROM cart WHERE cart_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cartNo);
		stmt.executeUpdate();
	}
	
	// 주문 완료 후 고객의 전체 장바구니 삭제 controller
	public void deleteCartAll(int customerNo) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "DELETE FROM cart WHERE customer_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		stmt.executeUpdate();
	}
}

