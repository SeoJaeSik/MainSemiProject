package sukyung.model;

import java.util.List;
import java.util.Map;

public interface InterProductDAO {

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

	// 로그인한 회원이 장바구니에 담은 상품의 개수 조회(select)
	int cartCount(String userid) throws Exception;



	
}