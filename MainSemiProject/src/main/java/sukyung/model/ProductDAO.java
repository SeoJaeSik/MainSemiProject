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

	// 로그인한 회원이 장바구니에 담은 상품의 개수 조회(select)
	@Override
	public int cartCount(String userid) throws Exception {
		
		int cartCount = 0;
		
		try {
			conn = ds.getConnection();
			String sql = " select count(cart_no) "
					   + " from tbl_cart "
					   + " where fk_userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid); // 로그인한 회원아이디

			rs = pstmt.executeQuery();
			rs.next();
			
			cartCount = rs.getInt(1);
			
		} finally {
			close();
		}
		
		return cartCount;
	} // end of public int cartCount(String userid) throws Exception

	
	// tbl_cart 테이블에서 로그인한 사용자(fk_userid)가 담은 제품의 정보 조회(select)
	@Override
	public List<CartVO> showCartList(String userid) throws Exception {
		
		List<CartVO> cartList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			String sql = " select C.cart_no, C.cart_product_count, C.fk_userid "
					   + "		, P.product_no, P.product_name, P.product_price, P.product_color, P.product_size, P.product_image "
					   + " from tbl_cart C "
					   + " join tbl_product P "
					   + " on C.fk_product_no = P.product_no "
			   		   + " where C.fk_userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid); // 로그인한 회원아이디

			rs = pstmt.executeQuery();

			while(rs.next()) {

				CartVO cvo = new CartVO();
				cvo.setCart_no(rs.getInt(1));
				cvo.setCart_product_count(rs.getInt(2));
				cvo.setFk_userid(rs.getString(3));
				
				ProductVO pvo = new ProductVO();
				pvo.setProduct_no(rs.getString(4));
				pvo.setProduct_name(rs.getString(5));
				pvo.setProduct_price(rs.getInt(6));
				pvo.setProduct_color(rs.getString(7));
				pvo.setProduct_size(rs.getInt(8));
				pvo.setProduct_image(rs.getString(9));
				pvo.setTotalPrice(cvo.getCart_product_count());
				
				cvo.setPvo(pvo);
	            
				cartList.add(cvo);
			} // end of while(rs.next())

		} finally {
			close();
		}
		
		return cartList;
	} // end of public List<CartVO> showCartList(String userid) throws Exception


	// tbl_cart 테이블에서 로그인한사용자의 성별에 맞는 제품(buyer_type_no)을 조회(select)하여 추천
	@Override
	public ProductVO showRandomItem(String buyer_type_no) throws Exception {
		
		ProductVO rndpvo = new ProductVO();
		
		try {
			conn = ds.getConnection();
			String sql = " select product_name, product_price, product_image, product_color "
					   + " from ( "
					   + " 		 select product_name, product_price, product_image, product_color "
					   + "            , substr(fk_shoes_category_no,0,3) as fk_buyer_type_no "
					   + "       from tbl_product "
					   + "       order by dbms_random.random "
					   + "      ) "
					   + " where rownum = 1 and fk_buyer_type_no = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, buyer_type_no); // 고객유형코드 "100" "200"

			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				rndpvo.setProduct_name(rs.getString(1));
				rndpvo.setProduct_price(rs.getInt(2));
				rndpvo.setProduct_image(rs.getString(3));
				rndpvo.setProduct_color(rs.getString(4));
			}

		} finally {
			close();
		}
		
		return rndpvo;
	} // end of public ProductVO showRandomItem(String buyer_type_no) throws Exception

	
	// 특정 제품의 사이즈 조회(select)
	@Override
	public List<ProductVO> selectSizeList(ProductVO pvo) throws Exception {
		
		List<ProductVO> selectSizeList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			String sql = " select product_no, product_size "
					   + " from tbl_product "
					   + " where product_name = ? and product_color = ? "
			   		   + " order by product_size ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pvo.getProduct_name());  // 제품명
			pstmt.setString(2, pvo.getProduct_color()); // 제품색상

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductVO sizepvo = new ProductVO();
				sizepvo.setProduct_no(rs.getString(1));
				sizepvo.setProduct_size(rs.getInt(2));
				selectSizeList.add(sizepvo);
			}

		} finally {
			close();
		}
		
		return selectSizeList;
	} // end of public List<ProductVO> selectSizeList(String product_name) throws Exception

	
	// 특정 제품의 색상 조회(select)
	@Override
	public List<ProductVO> selectColorList(ProductVO pvo) throws Exception {
		
		List<ProductVO> selectColorList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			String sql = " select distinct(product_color), product_image "
					   + " from tbl_product "
					   + " where product_name = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pvo.getProduct_name()); // 제품명

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductVO colorpvo = new ProductVO();
				colorpvo.setProduct_color(rs.getString(1));
				colorpvo.setProduct_image(rs.getString(2));
				selectColorList.add(colorpvo);
			}

		} finally {
			close();
		}
		
		return selectColorList;
	} // end of public List<ProductVO> selectColorList(ProductVO pvo) throws Exception
	
	
	// tbl_cart 테이블에서 제품의 수량 변경(update)
	@Override
	public int cartCountUpdate(Map<String, String> paraMap) throws Exception {

		int result = 0;
		
		try {
			conn = ds.getConnection();
			String sql = " update tbl_cart set cart_product_count = ? "
					   + " where cart_no = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(paraMap.get("cart_product_count")));
			pstmt.setInt(2, Integer.parseInt(paraMap.get("cart_no")));
			
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}

		return result;
	} // end of public int cartCountUpdate(Map<String, String> paraMap) throws Exception

	
	// tbl_cart 테이블에서 제품 삭제(delete)
	@Override
	public int cartDelete(String cart_no) throws Exception {

		int result = 0;
		
		try {
			conn = ds.getConnection();
			String sql = " delete from tbl_cart "
					   + " where cart_no = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(cart_no));
			
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}

		return result;
	} // end of public int cartDelete(String cart_no) throws Exception

	
	// tbl_cart 테이블에 제품의 데이터 행 추가(insert)
	@Override
	public int cartAdd(Map<String, String> paraMap) throws Exception {

		int result = 0;
		
		try {
			conn = ds.getConnection();
			String sql = " select product_no "
					   + " from tbl_product "
					   + " where product_name = ? and product_color = ? and product_size = ? "; 

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("product_name"));
			pstmt.setString(2, paraMap.get("product_color"));
			pstmt.setInt(3, Integer.parseInt(paraMap.get("product_size")));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String product_no = rs.getString(1);
				sql = " insert into tbl_cart(cart_no, fk_userid, fk_product_no, cart_product_count) "
					+ " values(seq_tbl_cart_cartno.nextval, ? , ? , 1) ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("userid"));
				pstmt.setString(2, product_no);
				
				result = pstmt.executeUpdate();
			}
			
		} finally {
			close();
		}

		return result;
	} // end of public int cartAdd(String product_no) throws Exception

	
	// tbl_cart 테이블에서 제품의 옵션 변경(update)
	@Override
	public int cartOptionUpdate(Map<String, String> paraMap) throws Exception {
		
		int result = 0;
		
		try {
			conn = ds.getConnection();
			String sql = " select product_no "
					   + " from tbl_product "
					   + " where product_name = ? and product_color = ? and product_size = ? "; 

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("product_name"));
			pstmt.setString(2, paraMap.get("product_color"));
			pstmt.setInt(3, Integer.parseInt(paraMap.get("product_size")));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String product_no = rs.getString(1);
				sql = " update tbl_cart set fk_product_no = ? "
					+ " where cart_no = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, product_no);
				pstmt.setInt(2, Integer.parseInt(paraMap.get("cart_no")));
				
				result = pstmt.executeUpdate();
			}
			
		} finally {
			close();
		}

		return result;
	} // end of public int cartOptionUpdate(Map<String, String> paraMap) throws Exception


}
