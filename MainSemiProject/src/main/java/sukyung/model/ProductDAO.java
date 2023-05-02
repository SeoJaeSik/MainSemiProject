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
					   + "		, P.product_no, P.product_name, P.product_price, P.product_color, P.product_size, P.product_image, P.stock_count "
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
				pvo.setStock_count(rs.getInt(10)); // 잔고수량
				
				pvo.setOrder_price(cvo.getCart_product_count()); // 제품별 주문금액 (제품가격*주문수량)
				
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
			pstmt.setString(1, cart_no);
			
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
			
			if(rs.next()) { // product_no 이 있으면
				String product_no = rs.getString(1);
				
				// 특정회원의 장바구니 테이블 조회
				sql = " select cart_no "
					+ " from tbl_cart "
					+ " where fk_userid = ? and fk_product_no = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("userid"));
				pstmt.setString(2, product_no);

				rs = pstmt.executeQuery();
				
				if(rs.next()){ // *** 1. 이미 장바구니에 동일한 제품이 있는 경우
					String cart_no = rs.getString(1);
					
					sql = " update tbl_cart set cart_product_count = cart_product_count + ? "
					    + " where cart_no = ? ";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, Integer.parseInt(paraMap.get("cart_product_count")));
					pstmt.setInt(2, Integer.parseInt(cart_no));
						
					result = pstmt.executeUpdate();
				}
				else { // *** 2. 새로 장바구니에 추가하는 경우
					sql = " insert into tbl_cart(cart_no, fk_userid, fk_product_no, cart_product_count) "
						+ " values(seq_tbl_cart_cartno.nextval, ? , ? , ?) ";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, paraMap.get("userid"));
					pstmt.setString(2, product_no);
					pstmt.setInt(3, Integer.parseInt(paraMap.get("cart_product_count")));
					
					result = pstmt.executeUpdate();
				}
			} // end of if (product_no 이 있으면)
			
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
			
			if(rs.next()) { // product_no 이 있으면
				String product_no = rs.getString(1);
				
				// 특정회원의 장바구니 테이블 조회
				sql = " select cart_no, cart_product_count "
					+ " from tbl_cart "
					+ " where fk_userid = ? and fk_product_no = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("userid"));
				pstmt.setString(2, product_no);

				rs = pstmt.executeQuery();
				
				if(rs.next()){ // *** 1. 이미 장바구니에 동일한 제품이 있는 경우 ==> 수량(cart_product_count) 변경
					// 동일한 제품의 장바구니번호(cart_no) 를 update
					String cart_no = rs.getString(1);
					String cart_product_count = rs.getString(2);
					
					sql = " update tbl_cart set cart_product_count = cart_product_count + ? "
					    + " where cart_no = ? ";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, Integer.parseInt(cart_product_count));
					pstmt.setInt(2, Integer.parseInt(cart_no));
					
					int n = pstmt.executeUpdate();

					if(n == 1) {
						// 옵션변경 전의 장바구니번호(cart_no) 를 delete
						sql = " delete from tbl_cart "
						    + " where cart_no = ? ";
						
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, Integer.parseInt(paraMap.get("cart_no")));
						
						result = pstmt.executeUpdate();
					}
				}
				else { // *** 2. 새로 장바구니에 추가하는 경우 ==> 제품번호(fk_product_no) 변경
					sql = " update tbl_cart set fk_product_no = ? "
						+ " where cart_no = ? ";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, product_no);
					pstmt.setInt(2, Integer.parseInt(paraMap.get("cart_no")));
					
					result = pstmt.executeUpdate();
				}
			} // end of if (product_no 이 있으면)
			
		} finally {
			close();
		}

		return result;
	} // end of public int cartOptionUpdate(Map<String, String> paraMap) throws Exception

	
	// product_no 로 제품명, 제품색상, 제품사이즈, 제품이미지, 제품가격 조회(select)
	@Override
	public CartVO showProdInfo(Map<String, String> paraMap) throws Exception {

		CartVO cvo = new CartVO();
		
		try {
			conn = ds.getConnection();
			String sql = " select product_no, product_name, product_color, product_size, product_image, product_price, stock_count "
					   + " from tbl_product "
					   + " where product_no = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("product_no")); 

			rs = pstmt.executeQuery();
			
			if(rs.next()) {

				if(paraMap.get("cart_no") != null) { // 장바구니에서 결제
					cvo.setCart_no(Integer.parseInt(paraMap.get("cart_no"))); // 장바구니번호
				}
				cvo.setCart_product_count(Integer.parseInt(paraMap.get("order_count"))); // 주문수량

				ProductVO pvo = new ProductVO();
				pvo.setProduct_no(rs.getString(1));
				pvo.setProduct_name(rs.getString(2));
				pvo.setProduct_color(rs.getString(3));
				pvo.setProduct_size(rs.getInt(4));
				pvo.setProduct_image(rs.getString(5));
				pvo.setProduct_price(rs.getInt(6));
				pvo.setStock_count(rs.getInt(7)); // 잔고수량
				
				if(pvo.getStock_count() < cvo.getCart_product_count()) { // 잔고수량 < 주문수량
					cvo.setCart_product_count(0); // 현재 품절이므로 주문불가 ==> 주문수량 0 으로 수정
				}
				
				pvo.setOrder_price(cvo.getCart_product_count()); // 제품별 주문금액 (제품가격*주문수량)
				cvo.setPvo(pvo);
			}

		} finally {
			close();
		}
		
		return cvo;
	} // end of public ProductVO showProdInfo(String product_no) throws Exception


	// 로그인한회원의 쿠폰 조회(select)
	@Override
	public List<Map<String, String>> showUserCoupon(String userid) throws Exception {
		
		List<Map<String, String>> couponList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			String sql = " select coupon_no, coupon_name, coupon_dis_percent "
					   + " from tbl_user_coupon "
					   + " where coupon_used = 1 and fk_userid = ? ";
			// 로그인한 회원이 보유한 쿠폰중 사용가능한(coupon_used = 1) 쿠폰만 조회
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid); 

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Map<String, String> couponMap = new HashMap<>();
				couponMap.put("coupon_no", rs.getString(1)); 		  // 쿠폰번호
				couponMap.put("coupon_name", rs.getString(2)); 		  // 쿠폰명    ==> 첫 온라인 구매 10% 할인쿠폰
				couponMap.put("coupon_dis_percent", rs.getString(3)); // 쿠폰할인율 ==> 10
				couponList.add(couponMap);
			}

		} finally {
			close();
		}

		return couponList;
	} // end of public List<Map<String, String>> showUserCoupon(String userid) throws Exception


	// 주문날짜 orderdate 가 sysdate 인 주문들 중 가장 마지막에 주문된 주문번호 알아오기
	@Override
	public String getOrder_no() throws Exception {

		String order_no = "";
		
		try {
			conn = ds.getConnection();
			String sql = " select case when order_no < 10 then '000'||order_no "
					   + "             when order_no >= 10 and order_no < 100 then '00'||order_no "
					   + "             when order_no >= 100 and order_no < 1000 then '0'||order_no "
					   + "        else to_char(order_no) end as order_no "
					   + " from "
					   + " 	   ( "
					   + "      select nvl(max(to_number(substr(order_no,9,4)))+1,1) as order_no "
					   + "      from tbl_order "
					   + "      where to_char(orderdate, 'yyyyMMdd') = to_char(sysdate, 'yyyyMMdd') "
					   + "     ) ";
			
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			rs.next();
			
			order_no = rs.getString(1); // 주문번호 끝자리 ex) 202305010001 의 0001
			
		} finally {
			close();
		}
		
		return order_no;
	} // end of public int getOrder_no() throws Exception

	
	// 트랜잭션 처리해주는 메소드
	// 1) 주문 테이블(tbl_order) - insert 주문번호(생성), 회원아이디(fk), 배송비, 결제금액
	// 2) 주문상세 테이블(tbl_order_detail) - insert 주문상세일련번호(생성), 제품번호(fk), 주문번호(fk), 주문수량, 제품별 주문금액
	// 3) 장바구니 테이블(tbl_cart) - delete 결제된 장바구니 데이터 행 삭제
	// 4) 제품 테이블(tbl_product) - update 주문수량 증가, 재고수량 감소 - ProductDAO 메소드에서 처리
	// 5) 회원 테이블(tbl_member) - update 회원아이디, 포인트 차감, 포인트 적립
	// 6) 쿠폰 테이블(tbl_user_coupon) - update 회원아이디(fk), 쿠폰번호, 쿠폰사용여부
	// 7) 배송 테이블(tbl_delivery) - insert 주문번호(생성), 배송정보
	@Override
	public boolean paymentEnd(Map<String, Object> paraMap) throws Exception {
		
		boolean result = false;
		int n1=0, n2=0, n3=0, n4=0, n5=0, n6=0, n7=0;
		
		try {
			conn = ds.getConnection();
			conn.setAutoCommit(false); // 수동커밋
			
		// 1) 주문 테이블(tbl_order) - insert 주문번호(생성), 회원아이디(fk), 배송비, 결제금액
			String sql = " insert into tbl_order(order_no, fk_userid, delivery_fee, total_price) "
					   + " values(?, ?, ?, ?) ";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, (String)paraMap.get("order_no"));
			pstmt.setString(2, (String)paraMap.get("userid"));
			pstmt.setString(3, (String)paraMap.get("delivery_fee"));
			pstmt.setString(4, (String)paraMap.get("total_price"));
			
			n1 = pstmt.executeUpdate();
			
		//	System.out.println("확인용 n1 : "+n1);
			
		// 2) 주문상세 테이블(tbl_order_detail) - insert 주문상세일련번호(생성), 제품번호(fk), 주문번호(fk), 주문수량, 제품별 주문금액
			if(n1 == 1) {
				
				// === 장바구니에서 결제하는 경우
				if(paraMap.get("join_cart_no") != null) {
					String[] arr_product_no = (String[]) paraMap.get("arr_product_no");   // 제품번호
		     		String[] arr_order_count = (String[]) paraMap.get("arr_order_count"); // 주문수량
		     		String[] arr_order_price = (String[]) paraMap.get("arr_order_price"); // 제품별 주문금액

					// 한 건의 주문에 속해있는 제품별 주문내역이 담겨있는 배열이므로 3개의 제품을 주문했다면 3번 insert 해야한다.
					int insert_cnt = 0; // 제품별로 주문상세 테이블에 insert 된 횟수를 체크하는 용도
					for(int i=0; i<arr_product_no.length; i++) {
						sql = " insert into tbl_order_detail(order_detail_no, fk_product_no, fk_order_no, order_count, order_price) "
							+ " values(?, ?, ?, ?, ?) ";
						pstmt = conn.prepareStatement(sql);

						pstmt.setString(1, ((String)paraMap.get("order_no")+(i+1))); // 주문번호 202305010001 + (i+1)
						pstmt.setString(2, arr_product_no[i]);  	   		   // 제품번호
						pstmt.setString(3, (String)paraMap.get("order_no"));   // 주문번호 202305010001
						pstmt.setString(4, arr_order_count[i]); 	   		   // 주문수량
						pstmt.setString(5, arr_order_price[i]); 			   // 제품별 주문금액

						pstmt.executeUpdate();
						insert_cnt++; // 주문상세 테이블에 insert 성공하면 1씩 증가한다.
					} // end of for
					
					if(insert_cnt == arr_product_no.length) {
						// 주문상세 테이블에 insert 한 개수와 제품별 주문내역의 총 개수가 같을 때
						// 즉 한 건의 주문에 속해있는 제품별 주문내역이 전부 insert 성공하였을 때
						n2 = 1;
					}
				//	System.out.println("확인용 n2 : "+n2);
					
					
				// 3) 장바구니 테이블(tbl_cart) - delete 결제된 장바구니 데이터 행 삭제
					if(n2 == 1) {
						String join_cart_no = (String) paraMap.get("join_cart_no"); // 장바구니번호(문자열)

						System.out.println(join_cart_no);
						
						sql = " delete from tbl_cart "
							+ " where cart_no in (" + join_cart_no +") ";
						pstmt = conn.prepareStatement(sql);
						
						n3 = pstmt.executeUpdate(); // tbl_cart 에서 delete 된 행의 개수
					} // end of if(장바구니 테이블에서 delete)
				//	System.out.println("확인용 n3 : "+n3);

					
				// 4) 제품 테이블(tbl_product) - update 주문수량 증가, 재고수량 감소
					if(n3 > 0) { 
						int update_cnt = 0; // 제품 테이블에서 제품별로 잔고량을 update한 횟수를 체크하는 용도
						
						for(int i=0; i<arr_product_no.length; i++) {
							sql = " update tbl_product set stock_count = stock_count - ? "
								+ "  					 , sale_count = sale_count + ? "
								+ " where product_no = ? ";
							pstmt = conn.prepareStatement(sql);

							pstmt.setString(1, arr_order_count[i]); // 주문수량
							pstmt.setString(2, arr_order_count[i]); // 주문수량
							pstmt.setString(3, arr_product_no[i]); // 제품번호

							pstmt.executeUpdate();
							update_cnt++; // 제품 테이블에서 update 성공하면 1씩 증가한다.
						} // end of for

						if(update_cnt == arr_product_no.length) {
							// 제품 테이블에서 update 한 개수와 제품별 주문내역의 총 개수가 같을 때
							// 즉 한 건의 주문에 속해있는 제품별 주문내역을 전부 update 성공하였을 때
							n4 = 1;
						}
					} // end of if (제품 테이블에서 update)
				//	System.out.println("확인용 n4 : "+n4);
				} // end of if(장바구니에서 결제하는 경우)

				// === 제품상세에서 바로결제하는 경우
				else {
					String product_no = (String) paraMap.get("product_no");   // 제품번호
		     		String order_count = (String) paraMap.get("order_count"); // 주문수량
		     		String order_price = (String) paraMap.get("order_price"); // 주문금액

		     		sql = " insert into tbl_order_detail(order_detail_no, fk_product_no, fk_order_no, order_count, order_price) "
						+ " values(?, ?, ?, ?, ?) ";
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, (String)paraMap.get("order_no")); // 주문번호 202305010001 + 1
					pstmt.setString(2, product_no);  	   		         // 제품번호
					pstmt.setString(3, (String)paraMap.get("order_no")); // 주문번호 202305010001
					pstmt.setString(4, order_count); 	   		  		 // 주문수량
					pstmt.setString(5, order_price); 			  		 // 제품별 주문금액

					n2 = pstmt.executeUpdate();
					
					// 제품상세에서 바로결제하는 경우 join_cart_no 은 null
					if( paraMap.get("join_cart_no") == null && n2 == 1) { n3 = 1; }

					
					// 4) 제품 테이블(tbl_product) - update 주문수량 증가, 재고수량 감소
					if(n3 == 1) { 
						sql = " update tbl_product set stock_count = stock_count - ? "
							+ "  					 , sale_count = sale_count + ? "
							+ " where product_no = ? ";
						pstmt = conn.prepareStatement(sql);

						pstmt.setString(1, order_count); // 주문수량
						pstmt.setString(2, order_count); // 주문수량
						pstmt.setString(3, product_no);  // 제품번호

						n4 = pstmt.executeUpdate();
					} // end of if (제품 테이블에서 update)
				} // end of else(제품상세에서 바로결제하는 경우)
				
			} // end of if(주문 테이블에 insert 성공한 경우)
			
			
		// 5) 회원 테이블(tbl_member) - update 회원아이디, 포인트 차감, 포인트 적립
			if(n4 == 1) {
				sql = " update tbl_member set point = point - ? + ? "
					+ " where userid = ? ";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, (String)paraMap.get("point_redeem")); // 포인트 사용금액
				pstmt.setString(2, (String)paraMap.get("point_saveup")); // 포인트 적립금액
				pstmt.setString(3, (String)paraMap.get("userid")); // 회원아이디

				n5 = pstmt.executeUpdate(); 
			} // end of if(회원 테이블 update)
			
		//	System.out.println("확인용 n5 : "+n5);
			
		// 6) 쿠폰 테이블(tbl_user_coupon) - update 회원아이디(fk), 쿠폰번호, 쿠폰사용여부
			if(n5 == 1 && paraMap.get("coupon_no") != null) {
				sql = " update tbl_user_coupon set coupon_used = 0 "
					+ " where coupon_no = ? ";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, (String)paraMap.get("coupon_no")); // 포인트 사용금액

				n6 = pstmt.executeUpdate(); 
			} // end of if(쿠폰 테이블 update)

			if(paraMap.get("coupon_no") == null) {
				n6 = 1;
			}
		//	System.out.println("확인용 n6 : "+n6);
			
		// 7) 배송 테이블(tbl_delivery) - insert 주문번호(생성), 배송정보
			if(n6 == 1) {
	     		sql = " insert into tbl_delivery(fk_order_no, delivery_name, delivery_mobile, delivery_address, delivery_comment, delivery_invoice) "
					+ " values(?, ?, ?, ?, ?, ?) ";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, (String)paraMap.get("order_no")); 		 // 주문번호
				pstmt.setString(2, (String)paraMap.get("delivery_name"));    // 수령자성명
				pstmt.setString(3, (String)paraMap.get("delivery_mobile"));  // 수령자연락처
				pstmt.setString(4, (String)paraMap.get("delivery_address")); // 수령자주소
				pstmt.setString(5, (String)paraMap.get("delivery_comment")); // 요청사항
				pstmt.setString(6, (String)paraMap.get("delivery_invoice")); // 송장번호

				n7 = pstmt.executeUpdate(); 
			} // end of if(배송 테이블 insert)
		//	System.out.println("확인용 n7 : "+n7);

			
		// 8) 모든처리가 성공되었을시 commit 
			if(n1*n2*n3*n4*n5*n6*n7 > 0) { // 모든 sql 문이 성공하였을 때
				conn.commit(); // 커밋
				result = true;
			} // end of if
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			conn.rollback(); // 롤백
			result = false;

		} finally {
			conn.setAutoCommit(true); // 자동커밋
			close();
		}
		
		return result;
	} // end of public boolean paymentEnd(Map<String, Object> paraMap) throws Exception

	
	// 주문번호(order_no) 를 이용하여 주문정보(주문테이블, 배송테이블) 조회(select)
	@Override
	public Map<String, String> showOrderList(String order_no) throws Exception {

		Map<String, String> orderMap = new HashMap<>();
		
		try {
			conn = ds.getConnection();
			String sql = " select A.order_no, A.orderdate, A.total_price "
					   + "      , B.delivery_name, B.delivery_mobile, B.delivery_address, B.delivery_comment, B.delivery_invoice "
					   + " from tbl_order A join tbl_delivery B "
					   + " on A.order_no = B.fk_order_no "
					   + " where A.order_no = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, order_no); // 주문번호

			rs = pstmt.executeQuery();
 
			if(rs.next()) {
				orderMap.put("order_no", rs.getString(1));
				orderMap.put("orderdate", rs.getString(2));
				orderMap.put("total_price", rs.getString(3));
				orderMap.put("delivery_name", rs.getString(4));
				orderMap.put("delivery_mobile", rs.getString(5));
				orderMap.put("delivery_address", rs.getString(6));
				orderMap.put("delivery_comment", rs.getString(7));
				orderMap.put("delivery_invoice", rs.getString(8));
			} // end of if(rs.next())

		} finally {
			close();
		}
		
		return orderMap;
	} // end of public Map<String, String> showOrderList(String order_no) throws Exception

	
	// 주문번호(order_no) 를 이용하여 주문상세내역 정보(주문상세테이블, 상품테이블) 조회(select)
	@Override
	public List<OrderDetailVO> showOrderDetailList(String order_no) throws Exception {
		
		List<OrderDetailVO> orderDetailList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			String sql = " select D.order_detail_no, D.order_count, D.order_price "
					   + "      , P.product_no, P.product_name, P.product_color, P.product_size, P.product_image "
					   + " from tbl_order_detail D join tbl_product P "
					   + " on D.fk_product_no = P.product_no "
					   + " where D.fk_order_no = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, order_no); // 주문번호

			rs = pstmt.executeQuery();

			while(rs.next()) {

				OrderDetailVO odvo = new OrderDetailVO();
				odvo.setOrder_detail_no(rs.getString(1));
				odvo.setOrder_count(rs.getInt(2));
				odvo.setOrder_price(rs.getInt(3));
				
				ProductVO pvo = new ProductVO();
				pvo.setProduct_no(rs.getString(4));
				pvo.setProduct_name(rs.getString(5));
				pvo.setProduct_color(rs.getString(6));
				pvo.setProduct_size(rs.getInt(7));
				pvo.setProduct_image(rs.getString(8));
				
				odvo.setPvo(pvo);
	            
				orderDetailList.add(odvo);
			} // end of while(rs.next())

		} finally {
			close();
		}
		
		return orderDetailList;
	} // end of public List<OrderDetailVO> showOrderDetailList(String order_no) throws Exception


}