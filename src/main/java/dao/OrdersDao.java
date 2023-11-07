package dao;

import java.sql.*;
import java.util.*;
import vo.*;

public class OrdersDao {
	/* <구현해야 할 것>
	 * 매니저가 고객 주문 정보로 접근해서 주문 상태 변경 가능하게 할 것(주문완료, 배송완료)
	 * 고객은 자신의 주문 내역(orders)에 들어가면 (주문이 완료된 상태여서 취소는 할 수 없다)
	 * 상품의 이름, 수량, 가격, 주문상태(주문완료, 배송완료)확인할 수 있다
	 */

	
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
		PreparedStatement stmt = conn.prepareStatement(customerOrdersOneSql);
		stmt.setString(1, loginId);
		System.out.println(stmt + "<-- orders");
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()){
			o.setOrderNo(rs.getInt("order_no"));
			o.setProductNo(rs.getInt("product_no"));
			o.setId(rs.getString("id"));
			o.setDeliveryStatus(rs.getString("delivery_status"));
			o.setOrderCnt(rs.getInt("order_cnt"));
			o.setOrderPrice(rs.getInt("order_price"));
			o.setCreatedate(rs.getString("createdate"));
			o.setUpdatedate(rs.getString("updatedate"));
			}
		}
		return orders;
	}
}
