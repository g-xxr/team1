package dao;

import java.sql.*;
import java.util.*;

	/* <구현해야 할 것>
	 * 매니저가 고객 주문 정보로 접근해서 주문 상태 변경 가능하게 할 것(주문완료, 배송완료)
	 * 고객은 자신의 주문 내역(orders)에 들어가면 (주문이 완료된 상태여서 취소는 할 수 없다)
	 * 상품의 이름, 수량, 가격, 주문상태(주문완료, 배송완료)확인할 수 있다
	 * 매니저는 주문
	 */

public class OrdersDao {
	// 매니저가 모든 주문 목록을 조회 orderslist
	public ArrayList<HashMap<String, Object>> ordersList(int customerNo) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT g.goods_title goodsTitle, o.orders_no ordersNo, o.quantity quantity, o.total_price totalPrice FROM goods g INNER JOIN orders o ON g.goods_no = o.goods_no WHERE o.customer_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		
		System.out.println(stmt + "<-- ordersList");
		ResultSet rs = stmt.executeQuery();
		
		// 더 일반화 된 모델 코드로 만들기
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		while(rs.next()){
			HashMap<String, Object> map = new HashMap<>();
			map.put("goodsTitle", rs.getString("goodsTitle"));
			map.put("ordersNo",rs.getInt("ordersNo"));
			map.put("quantity",rs.getInt("quantity"));
			map.put("totalPrice",rs.getInt("totalPrice"));
			list.add(map);
		}
		// 자원 닫기
		rs.close();
		conn.close();
		stmt.close();
		
		return list;
	}
	
	// ordersList 페이징 호출 controller (매니저 권한)
	public int ordersListPaging() throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall" ;
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		// 페이징 sql
		String sql = "SELECT COUNT(*) FROM orders";
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
		
	
	// 고객 주문정보 상세 조회
	public void orders(int customerNo) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
				
		/*
		 * SELECT c.goods_no goodsNo, c.quantity quantity, g.goods_price goodsPrice, cad.address address
		 * FROM cart c INNER JOIN goods g 
		 * ON c.goods_no = g.goods_no INNER JOIN customer_addr cad 
		 * ON cad.customer_no = c.customer_no WHERE c.customer_no = ? 
		 * */
		String sql1 = "SELECT c.goods_no goodsNo, c.quantity quantity, g.goods_price goodsPrice, cad.customer_addr_no customerAddrNo FROM cart c INNER JOIN goods g ON c.goods_no = g.goods_no INNER JOIN customer_addr cad ON cad.customer_no = c.customer_no WHERE c.customer_no = ?";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		stmt1.setInt(1,customerNo);
		ResultSet rs = stmt1.executeQuery();
		
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		while(rs.next()) {
			HashMap<String,Object> map = new HashMap<>();
			map.put("goodsNo", rs.getInt("goodsNo"));
			map.put("quantity", rs.getInt("quantity"));
			map.put("goodsPrice", rs.getInt("goodsPrice"));
			map.put("customerAddrNo", rs.getString("customerAddrNo"));
			
			list.add(map);
		}
			
		for(HashMap<String,Object> map : list) {
			
			int totalPrice = (Integer)map.get("goodsPrice") * (Integer)map.get("quantity");
			/*
			 * INSERT INTO orders(goods_no, customer_no, customer_addr_no, quantity, total_price, orders_state, createdate, updatedate) 
			 * VALUES(?, ?, ?, ?, ?, '주문완료', NOW(), NOW())
			 * */
			String sql2 = "INSERT INTO orders(goods_no, customer_no, customer_addr_no, quantity, total_price, orders_state, createdate, updatedate) VALUES(?, ?, ?, ?, ?, '주문완료', NOW(), NOW())";
			PreparedStatement stmt2 = conn.prepareStatement(sql2);
			stmt2.setObject(1, map.get("goodsNo"));
			stmt2.setInt(2, customerNo);
			stmt2.setObject(3, map.get("customerAddrNo"));
			stmt2.setObject(4, map.get("quantity"));
			stmt2.setInt(5, totalPrice);
			
			int row = stmt2.executeUpdate();
			if(row != 1) {
				return;
			}
			stmt2.close();
		}
		
		conn.close();
		stmt1.close();
		rs.close();
	}
	
	// 주문 내역 삭제하기
	public void deleteOrders(int ordersNo) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "DELETE FROM orders WHERE orders_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		
		int row = stmt.executeUpdate();
		if(row != 1) {
			return;
		}
		
		conn.close();
		stmt.close();
	}
}
