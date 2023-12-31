package dao;

import java.sql.*;
import java.util.*;

	/* <구현해야 할 것 : orders, ordersList, ordersListManager>
	 * 매니저가 고객 주문 정보(ordersListManager)로 접근해서 주문 상태 변경 가능하게 할 것(주문완료, 배송완료)
	 * 고객은 마이페이지 > 자신의 주문 내역(ordersList)에 들어가면 (주문이 완료된 상태여서 취소는 할 수 없다)
	 * orders 주문작성폼에는 상품의 이름, 수량, 가격, 총합계액, 고객 정보(이름, 핸폰번호, 배송지), 주문상태(주문완료, 배송완료)확인할 수 있다 
	 */

public class OrdersDao {
	
	// order 추가하기
	public void orders(int customerNo) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
				
		/*
		 * SELECT c.goods_no goodsNo, c.quantity quantity, g.goods_price goodsPrice, ca.address address
		 * FROM cart c INNER JOIN goods g 
		 * ON c.goods_no = g.goods_no INNER JOIN customer_addr ca 
		 * ON ca.customer_no = c.customer_no WHERE c.customer_no = ? 
		 * */
		String sql1 = "SELECT c.goods_no goodsNo, c.quantity quantity, g.goods_price goodsPrice, ca.customer_addr_no customerAddrNo FROM cart c INNER JOIN goods g ON c.goods_no = g.goods_no INNER JOIN customer_addr ca ON ca.customer_no = c.customer_no WHERE c.customer_no = ?";
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
			
			
			int totalPrice = (Integer) map.get("goodsPrice") * (Integer) map.get("quantity");
						
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
	
	// ordersList 호출
	public ArrayList<HashMap<String, Object>> ordersList(int customerNo) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		/*
		 * SELECT g.goods_title goodsTitle, o.quantity quantity, o.total_price totalPrice 
		 * FROM goods g INNER JOIN orders o 
		 * ON g.goods_no = o.goods_no WHERE o.customer_no = ?
		 * */
		String sql = "SELECT g.goods_title goodsTitle, o.orders_no ordersNo, o.quantity quantity, o.total_price totalPrice FROM goods g INNER JOIN orders o ON g.goods_no = o.goods_no WHERE o.customer_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		
		ResultSet rs = stmt.executeQuery();
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<>();
			map.put("goodsTitle", rs.getString("goodsTitle"));
			map.put("ordersNo", rs.getInt("ordersNo"));
			map.put("quantity", rs.getInt("quantity"));
			map.put("totalPrice", rs.getInt("totalPrice"));

			list.add(map);
		}
		
		conn.close();
		stmt.close();
		rs.close();
		
		return list;
	}
	
	// 배송 상태 수정 controller : updateOrders
	public void updateOrders(int ordersNo, String ordersState) throws Exception {
			
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall" ;
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw); // 기본값 자동 커밋
		conn.setAutoCommit(false); // 수동 커밋(conn.commit()메서드를 코드에 호출 필요)
		
		String sql = "UPDATE orders SET orders_state = ? WHERE orders_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ordersState);
		stmt.setInt(2, ordersNo); // WHERE 절에 해당하는 값 설정
		
		int row = stmt.executeUpdate();
		if(row != 1) { // 잘못된 수정 or 실패
			conn.rollback();
			return;
		}
		
		// db 자원 close
		conn.commit(); 
		conn.close();
		stmt.close();
	}
	
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
