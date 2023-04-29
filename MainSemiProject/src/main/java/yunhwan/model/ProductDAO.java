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

	
	// === Ajax(JSON)를 이용한 더보기 방식(페이징처리)으로 상품정보를 6개씩 잘라서(start ~ end) 전체제품 조회해오기 === //
	@Override
	public List<ProductVO> selectProduct(Map<String, String> param) throws SQLException {

		List<ProductVO> prodList = new ArrayList<>();
		
		try {
			conn = ds.getConnection(); // 본인의 오라클DB와 연동
			
			String sql = " select product_name, fk_shoes_category_no, product_color, product_size, product_image, product_content "
					   + "      , stock_count, sale_count, product_price "
				       + " from "
					   + " ( "
					   + "  select row_number() over(order by product_no desc) AS RNO "
					   + "       , product_name, fk_shoes_category_no, product_color, product_size, product_image, product_content " 
					   + "       , stock_count, sale_count, product_price "
					   + "  from tbl_product "
					   + " ) V "
					   + " where RNO between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, param.get("start"));
			pstmt.setString(2, param.get("end"));
			
			rs =pstmt.executeQuery();
			
			while (rs.next()) {
				
				ProductVO pvo = new ProductVO();

			    pvo.setProduct_name(rs.getString("product_name"));  
				pvo.setFk_shoes_category_no(rs.getInt("fk_shoes_category_no"));
			    pvo.setProduct_color(rs.getString("product_color"));
				pvo.setProduct_size(rs.getInt("product_size"));
				pvo.setProduct_color(rs.getString("product_color"));
				pvo.setProduct_image(rs.getString("product_image"));
				pvo.setProduct_content(rs.getString("product_content"));
				pvo.setStock_count(rs.getInt("stock_count"));
				pvo.setSale_count(rs.getInt("sale_count"));
				pvo.setProduct_price(rs.getInt("product_price"));
				
				prodList.add(pvo);
				
			}// end of while (rs.next())
			
		
		} finally {
			close();
		}
		return prodList;
	}// end of public List<ProductVO> selectProduct(Map<String, String> param) throws SQLException------------
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// ShoesCategory를 DB에서 가져오기
	@Override
	public List<HashMap<String, String>> getShoesCategoryList() throws SQLException {
		
		List<HashMap<String, String>> shoesCategoryList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select shoes_category_no, shoes_category_name, fk_buyer_type_no"
					   + " from tbl_sheos_category ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				HashMap<String, String> map = new HashMap<>();
				map.put("shoes_category_no",  rs.getString("shoes_category_no"));
				map.put("shoes_category_name",  rs.getString("shoes_category_name"));
				map.put("fk_buyer_type_no",  rs.getString("fk_buyer_type_no"));
				
				shoesCategoryList.add(map); //shoesCategoryList 에 값을 넣어 보관
				
			}// end of while (rs.next())--------------------------
			 
		} finally {
			close();
		}
		
		return shoesCategoryList;
		
	} // end of public List<HashMap<String, String>> getShoesCategoryList() throws SQLException---------------

	
	
	
	
	
	// 전체제품 중 러닝화만 가져옴
	@Override
	public List<ProductVO> selectAllRunningProduct(Map<String, String> paraMap) throws SQLException {
		List<ProductVO> AllRunningProdList = new ArrayList<>();
		
		try {
			conn = ds.getConnection(); // 본인의 오라클DB와 연동
			
			String sql = " select product_name, fk_shoes_category_no, product_color, product_size, product_image, product_content "
					   + "      , stock_count, sale_count, product_price "
				       + " from "
					   + " ( "
					   + "  select row_number() over(order by product_no desc) AS RNO "
					   + "       , product_name, fk_shoes_category_no, product_color, product_size, product_image, product_content " 
					   + "       , stock_count, sale_count, product_price "
					   + "  from tbl_product "
					   + " ) V "
					   + " where RNO between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("start"));
			pstmt.setString(2, paraMap.get("end"));
			
			rs =pstmt.executeQuery();
			
			while (rs.next()) {
				
				ProductVO pvo = new ProductVO();

			    pvo.setProduct_name(rs.getString("product_name"));  
				pvo.setFk_shoes_category_no(rs.getInt("fk_shoes_category_no"));
			    pvo.setProduct_color(rs.getString("product_color"));
				pvo.setProduct_size(rs.getInt("product_size"));
				pvo.setProduct_color(rs.getString("product_color"));
				pvo.setProduct_image(rs.getString("product_image"));
				pvo.setProduct_content(rs.getString("product_content"));
				pvo.setStock_count(rs.getInt("stock_count"));
				pvo.setSale_count(rs.getInt("sale_count"));
				pvo.setProduct_price(rs.getInt("product_price"));
				
				AllRunningProdList.add(pvo);
				
			}// end of while (rs.next())
			
		
		} finally {
			close();
		}
		return AllRunningProdList;
	}

	


	

	

}
