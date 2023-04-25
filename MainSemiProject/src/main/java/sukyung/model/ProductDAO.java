package sukyung.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ProductDAO implements InterProductDAO {
	
	private DataSource ds; 
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 사용한 자원을 반납하는 메소드
	private void close() {
		
		try {
			if(rs != null) 	  { rs.close();    rs=null; }
			if(pstmt != null) { pstmt.close(); pstmt=null; }
			if(conn != null)  { conn.close();  conn=null; }
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 생성자
	public ProductDAO() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semi_oracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	////////////////////////////////////////////////////////////////////////////////////////////////

	@Override
	public List<ProductVO> showCartList(String userid) throws Exception {
		
		List<ProductVO> cartList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			String sql = " select C.cart_no, C.cart_product_count, C.fk_userid "
					   + "		, P.product_name, P.product_price, P.product_color, P.product_size, P.product_image "
					   + " 		, C.cart_product_count*P.product_price AS cart_product_price "
					   + " from tbl_cart C "
					   + " join tbl_product P "
					   + " on C.fk_product_no = P.product_no "
			   		   + " where C.fk_userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid); // 로그인한 회원아이디

			rs = pstmt.executeQuery();

			while(rs.next()) { 
				ProductVO pvo = new ProductVO();

				pvo.setCart_no(rs.getString(1));
				pvo.setCart_product_count(rs.getInt(2));
				userid = rs.getString(3);
				pvo.setProduct_name(rs.getString(4));
				pvo.setProduct_price(rs.getInt(5));
				pvo.setProduct_color(rs.getString(6));
				pvo.setProduct_size(rs.getInt(7));
				pvo.setProduct_image(rs.getString(8));
				pvo.setCart_product_price(rs.getInt(9));
	            
				cartList.add(pvo);
			} // end of while(rs.next())

		} finally {
			close();
		}
		
		return cartList;
	} // end of public List<ProductVO> showCartList(String userid) throws Exception

}
