package yunhwan.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;



public class ProductDAO implements InterProductDAO {

	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	// 사용한 자원을 반납하는 close() 메소드 생성하기
	private void close() {
		
		try {
			if(rs != null) 		{rs.close(); rs=null;}
			if(pstmt != null) 	{pstmt.close(); pstmt=null;}
			if(rs != null)	 	{rs.close(); rs=null;}
		}catch(SQLException e) {
				e.printStackTrace();
		}		
	}
		
	// 생성자
	public ProductDAO() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semi_oracle"); // lookup("jdbc/myoracle") 은 배치서술자인 web.xml 의 <res-ref-name> 이고, servers 의 톰캣 안에 context.xml 에도 있는데 그것을 의미한다.
		} catch(NamingException e) {
			e.printStackTrace();
		}
	}// end of public ProductDAO()---------------------

	
	
	
	
	
	
	// === Ajax(JSON)를 이용한 더보기 방식(페이징처리)으로 상품정보를 9개씩 잘라서(start ~ end) 전체제품 조회해오기 === //
	@Override
	public List<ProductVO> selectProduct(Map<String, String> paraMap) throws SQLException {

		List<ProductVO> prodList = new ArrayList<>();
		
		try {
			conn = ds.getConnection(); // 본인의 오라클DB와 연동
			
			String sql = " SELECT product_no, product_name, fk_shoes_category_no, product_price, product_color "
					   + "     , MAX(product_size) AS product_size, product_image, product_date, product_content "
				       + "     , upload_date, stock_count, sale_count "
					   + " FROM ( "
					   + "	  SELECT ROW_NUMBER() OVER (PARTITION BY product_name, product_color ORDER BY product_name DESC) AS RNO, product_no, product_name, "
					   + "			 fk_shoes_category_no, product_price, product_color, product_size, product_image, "
					   + "			 product_date, product_content, upload_date, stock_count, sale_count "
					   + "	  FROM tbl_product "
					   + "      WHERE fk_shoes_category_no LIKE '%' || ? || '%' "
					   + "	 ) "
					   + " WHERE RNO = 1 AND ROWNUM BETWEEN ? AND ? "
					   + " GROUP BY product_no, product_name, fk_shoes_category_no, product_price, product_color, "
					   + " product_image, product_date, product_content, upload_date, stock_count, sale_count, RNO "
					   + " ORDER BY product_name DESC ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("category"));
			pstmt.setString(2, paraMap.get("start"));
			pstmt.setString(3, paraMap.get("end"));
			
			rs =pstmt.executeQuery();
			
			while (rs.next()) {
				
				ProductVO pvo = new ProductVO();

				pvo.setProduct_name(rs.getString("product_name"));  
			    pvo.setProduct_color(rs.getString("product_color"));
			    pvo.setProduct_price(rs.getInt("product_price"));
				pvo.setFk_shoes_category_no(rs.getInt("fk_shoes_category_no"));
				pvo.setProduct_image(rs.getString("product_image"));
				pvo.setProduct_size(rs.getInt("product_size"));
				
				prodList.add(pvo);
				
			}// end of while (rs.next())
			
		
		} finally {
			close();
		}
		return prodList;
	}// end of public List<ProductVO> selectProduct(Map<String, String> param) throws SQLException------------

	
	
	

	@Override
	public int totalAllCount(String fk_shoes_category_no) throws SQLException {
		
		int totalAllCount = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select count(*) "
					   + " from tbl_product "
					   + " where fk_shoes_category_no LIKE '%' || ? || '%' ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_shoes_category_no);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalAllCount = rs.getInt(1);
			
		} finally {
			close();
		}
		
		return totalAllCount;
	}//end of public int totalAllCount(String fk_shoes_category_no) throws SQLException --------------------------
	
	
	
	
}
