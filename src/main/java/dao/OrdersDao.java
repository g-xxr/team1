package dao;

import java.sql.*;
import java.util.*;
import vo.*;

	/* <구현해야 할 것>
	 * 매니저가 고객 주문 정보로 접근해서 주문 상태 변경 가능하게 할 것(주문완료, 배송완료)
	 * 고객은 자신의 주문 내역(orders)에 들어가면 (주문이 완료된 상태여서 취소는 할 수 없다)
	 * 상품의 이름, 수량, 가격, 주문상태(주문완료, 배송완료)확인할 수 있다
	 */

public class OrdersDao {
	// 매니저가 모든 회원의 주문을 조회
	public ArrayList<Orders> ordersList(int beginRow, int rowPerPage) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT orders_no, goods_no, customer_no, customer_addr_no, quantity, total_price, orders_state, createdate, updatedate FROM orders ORDER BY orders_no DESC limit ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		System.out.println(stmt + "<-- ordersList");
		ResultSet rs = stmt.executeQuery();
		
		// 더 일반화 된 모델 코드로 만들기
		ArrayList<Orders> list = new ArrayList<>();
		while(rs.next()){
			Orders o = new Orders();
			o.setOrdersNo(rs.getInt("ordersNo"));
			o.setGoodsNo(rs.getInt("goodsNo"));
			o.setCustomerNo(rs.getInt("customerNo"));
			o.setCustomerAddrNo(rs.getInt("customerAddrNo"));
			o.setQuantity(rs.getInt("quantity"));
			o.setTotalPrice(rs.getInt("totalPrice"));
			o.setOrdersState(rs.getString("ordersState"));
			o.setCreatedate(rs.getString("createdate"));
			o.setUpdatedate(rs.getString("updatedate"));
			list.add(o);
		}
		// 자원 닫기
		rs.close();
		conn.close();
		stmt.close();
		
		return list;
	}
	
	
	// 매니저가 고객의 주문상태 변경
	public int updateOrders(Orders o) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "UPDATE orders SET orders_state = ? , updatedate = NOW() WHERE orders_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, o.getOrdersState());
		stmt.setInt(2, o.getOrdersNo());
		
		System.out.println(stmt + "<-- updateOrders");
		int row = stmt.executeUpdate();
		
		// 자원 닫기
		conn.close();
		stmt.close();
		
		return row;
	}
	
	
	
	// orders 호출 controller
	// 고객 주문 상세 정보 조회
	public Orders orders(String loginId) throws Exception{
		Orders o = new Orders();
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		/* SQL orders 쿼리문
		 * SELECT orders_no, goods_no, customer_no, customer_addr_no, quantity, total_price, orders_state, createdate, updatedate FROM orders WHERE orders_no = ?
		 */
		String sql = "SELECT orders_no, goods_no, customer_no, customer_addr_no, quantity, total_price, orders_state, createdate, updatedate FROM orders WHERE orders_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, loginId);
		System.out.println(stmt + "<-- orders");
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()){
			o.setOrdersNo(rs.getInt("ordersNo"));
			o.setGoodsNo(rs.getInt("goodsNo"));
			o.setCustomerNo(rs.getInt("customerNo"));
			o.setCustomerAddrNo(rs.getInt("customerAddrNo"));
			o.setQuantity(rs.getInt("quantity"));
			o.setTotalPrice(rs.getInt("totalPrice"));
			o.setOrdersState(rs.getString("ordersState"));
			o.setCreatedate(rs.getString("createdate"));
			o.setUpdatedate(rs.getString("updatedate"));
		}
		// 자원 닫기
		rs.close();
		conn.close();
		stmt.close();	
		
		return o;
	}
	
	
}
