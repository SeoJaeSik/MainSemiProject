package sukyung.model;

import java.util.List;
import java.util.Map;

public interface InterProductDAO {

	// 로그인한 회원이 장바구니에 담은 상품의 개수 조회(select)
	int cartCount(String userid) throws Exception;

	// tbl_cart 테이블에서 로그인한 사용자(fk_userid)가 담은 제품의 정보 조회(select)
	List<CartVO> showCartList(String userid) throws Exception;

	// tbl_cart 테이블에서 로그인한사용자의 성별에 맞는 제품(buyer_type_no)을 조회(select)하여 추천
	ProductVO showRandomItem(String buyer_type_no) throws Exception;

	// 특정 제품의 사이즈 조회(select)
	List<ProductVO> selectSizeList(ProductVO rndpvo) throws Exception;

	// 특정 제품의 색상 조회(select)
	List<ProductVO> selectColorList(ProductVO pvo) throws Exception;

	// tbl_cart 테이블에서 제품의 수량 변경(update)
	int cartCountUpdate(Map<String, String> paraMap) throws Exception;

	// tbl_cart 테이블에서 제품 삭제(delete)
	int cartDelete(String cart_no) throws Exception;

	// tbl_cart 테이블에 제품의 데이터 행 추가(insert)
	int cartAdd(Map<String, String> paraMap) throws Exception;

	// tbl_cart 테이블에서 제품의 옵션 변경(update)
	int cartOptionUpdate(Map<String, String> paraMap) throws Exception;

	// product_no 로 제품명, 제품색상, 제품사이즈, 제품이미지, 제품가격 조회(select)
	CartVO showProdInfo(Map<String, String> paraMap) throws Exception;

	// 로그인한회원의 쿠폰 조회(select)
	List<Map<String, String>> showUserCoupon(String userid) throws Exception;

	// 주문번호 오늘날짜(8자리) + 0001 ex) 20230501 0001, 20230501 0002
	// 주문날짜 orderdate 가 sysdate 인 주문들 중 가장 마지막에 주문된 주문번호 알아오기
	String getOrder_no() throws Exception;

	// 트랜잭션 처리해주는 메소드
	// 1) 주문 테이블(tbl_order) - insert 주문번호(생성), 회원아이디(fk), 배송비, 결제금액
	// 2) 주문상세 테이블(tbl_order_detail) - insert 주문상세일련번호(생성), 제품번호(fk), 주문번호(fk), 주문수량, 제품별 주문금액
	// 3) 장바구니 테이블(tbl_cart) - delete 결제된 장바구니 데이터 행 삭제
	// 4) 제품 테이블(tbl_product) - update 주문수량 증가, 재고수량 감소 - ProductDAO 메소드에서 처리
	// 5) 회원 테이블(tbl_member) - update 회원아이디, 포인트 차감, 포인트 적립
	// 6) 쿠폰 테이블(tbl_user_coupon) - update 회원아이디(fk), 쿠폰번호, 쿠폰사용여부
	boolean paymentEnd(Map<String, Object> paraMap) throws Exception;

	// 주문번호(order_no) 를 이용하여 주문정보(주문테이블, 배송테이블) 조회(select)
	Map<String, String> showOrderList(String order_no) throws Exception;

	// 주문번호(order_no) 를 이용하여 주문상세내역 정보(주문상세테이블, 상품테이블) 조회(select)
	List<OrderDetailVO> showOrderDetailList(String order_no) throws Exception;
	
}
