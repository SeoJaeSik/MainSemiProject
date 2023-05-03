package shinjh.myshop.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ProductDAO implements InterProductDAO {
	
	private DataSource ds; // DataSource는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	
	// 사용한 자원을 반납하는 close() 메소드 생성하기
	private void close() {
		try {
			if(rs != null) {rs.close(); rs=null;}
			if(pstmt != null) {pstmt.close(); pstmt=null;}
			if(conn != null) {conn.close(); conn=null;}
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
		} catch(NamingException e) {
			e.printStackTrace();
		}
	}
	
	
	// 제품이름과 색상을 가지고서 해당 제품의 정보를 조회해오기
	@Override
	public ProductVO selectOneProduct(String product_name, String product_color) throws SQLException {
		
		ProductVO pvo = new ProductVO();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select S.shoes_category_name, product_no, product_date, product_price, S.fk_buyer_type_no, product_size, stock_count, product_content, product_image, product_color, S.shoes_category_no "
					+ " from "
					+ " ( "
					+ " 	select FK_SHOES_CATEGORY_NO, product_no, product_date, product_price, product_size, stock_count, product_content, product_image, product_color "
					+ " 	from tbl_product "
					+ " 	where product_name = ? and product_color = ? and stock_count != 0 "
					+ " ) P JOIN tbl_shoes_category S "
					+ " ON P.fk_shoes_category_no = S.shoes_category_no ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_name);
			pstmt.setString(2, product_color);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				ShoesCategoryVO scvo = new ShoesCategoryVO();
				
				BuyerTypeVO btvo = new BuyerTypeVO();
				
				scvo.setShoes_category_name(rs.getString(1)); 
				pvo.setProduct_no(rs.getString(2)); 
				pvo.setProduct_date(rs.getString(3));
				pvo.setProduct_price(rs.getInt(4));
				btvo.setBuyer_type_no(rs.getString(5));
				pvo.setProduct_size(rs.getInt(6));
				pvo.setStock_count(rs.getInt(7));
				pvo.setProduct_content(rs.getString(8));
				pvo.setProduct_image(rs.getString(9));
				pvo.setProduct_color(rs.getString(10));
				scvo.setShoes_category_no(rs.getString(11));
				pvo.setProduct_name(product_name);
				
				pvo.setScvo(scvo);
				
				String buyer_type_name = "";
				
				switch (btvo.getBuyer_type_no()) {
					case "100":
						buyer_type_name = "남성";
						break;
						
					case "200":
						buyer_type_name = "여성";
						break;
						
					default:
						buyer_type_name = "키즈";
						break;
				}
				btvo.setBuyer_type_name(buyer_type_name);
				
				pvo.setBtvo(btvo);
	            
			}
		} finally {
			close();
		}
		
		return pvo;
	}

	
	// 제품이름을 가지고서 해당 제품의 정보를 조회해오기
	@Override
	public ProductVO selectProductByName(String product_name) throws SQLException {
		
		ProductVO pvo = new ProductVO();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select S.shoes_category_name, product_no, product_date, product_price, S.fk_buyer_type_no, product_size, stock_count, product_content, product_image, product_color, S.shoes_category_no "
					+ " from "
					+ " ( "
					+ " 	select FK_SHOES_CATEGORY_NO, product_no, product_date, product_price, product_size, stock_count, product_content, product_image, product_color "
					+ " 	from tbl_product "
					+ " 	where product_name = ? and stock_count != 0 "
					+ " ) P JOIN tbl_shoes_category S "
					+ " ON P.fk_shoes_category_no = S.shoes_category_no ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_name);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				ShoesCategoryVO scvo = new ShoesCategoryVO();
				
				BuyerTypeVO btvo = new BuyerTypeVO();
				
				scvo.setShoes_category_name(rs.getString(1)); 
				pvo.setProduct_no(rs.getString(2)); 
				pvo.setProduct_date(rs.getString(3));
				pvo.setProduct_price(rs.getInt(4));
				btvo.setBuyer_type_no(rs.getString(5));
				pvo.setProduct_size(rs.getInt(6));
				pvo.setStock_count(rs.getInt(7));
				pvo.setProduct_content(rs.getString(8));
				pvo.setProduct_image(rs.getString(9));
				pvo.setProduct_color(rs.getString(10));
				scvo.setShoes_category_no(rs.getString(11));
				pvo.setProduct_name(product_name);
				
				pvo.setScvo(scvo);
				
				String buyer_type_name = "";
				
				switch (btvo.getBuyer_type_no()) {
					case "100":
						buyer_type_name = "남성";
						break;
						
					case "200":
						buyer_type_name = "여성";
						break;
						
					default:
						buyer_type_name = "키즈";
						break;
				}
				btvo.setBuyer_type_name(buyer_type_name);
				
				pvo.setBtvo(btvo);
	            
			}
		} finally {
			close();
		}
		
		return pvo;
	}// end of public ProductVO selectOneProductByProduct_name

	
	// 제품이름과 색상을 가지고 해당제품에 추가된 이미지 정보를 조회해오기
	@Override
	public List<String> getImages(String product_name, String product_color) throws SQLException {

		List<String> imgList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select imgfilename "
						+ " from tbl_product_imagefile "
						+ " where fk_product_no = ( select product_no "
						+ "                         from tbl_product "
						+ "                         where product_name = ? and product_color = ?) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_name);
			pstmt.setString(2, product_color);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				imgList.add(rs.getString(1));
			}
		} finally {
			close();
		}		
		
		return imgList;
	}// end of public List<String> getImagesByProduct_name

	
	// 제품이름을 가지고 색상 이미지를 가져오기
	@Override
	public List<String> getColorByName(String product_name) throws SQLException {
		
		List<String> colorList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select product_image "
						+ " from tbl_product "
						+ " where product_name = ? and stock_count != 0 "
						+ " group by product_image ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_name);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {				
				colorList.add(rs.getString(1));				
			}
		} finally {
			close();
		}				
		return colorList;
	}// end of public List<String> getColorByProduct_name

	
	// 제품이름과 사이즈를 가지고 사이즈 선택지를 가져오기
	@Override
	public List<Integer> getSize(String product_name, String product_color) throws SQLException {
		
		List<Integer> sizeList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select product_size "
					+ " from tbl_product "
					+ " where product_name = ? and product_color = ? "
					+ " order by product_size asc ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_name);
			pstmt.setString(2, product_color);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				sizeList.add(rs.getInt(1));
			}
		} finally {
			close();
		}		
		return sizeList;
	}// end of public List<Integer> getSizeByProduct_size


	
}// end of public class ProductDAO implements InterProductDAO
