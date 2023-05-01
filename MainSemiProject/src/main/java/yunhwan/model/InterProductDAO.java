package yunhwan.model;


import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface InterProductDAO {

	
	
	// (ALL)전체제품 목록 나타내기 + Ajax(JSON)를 사용하여 전체상품목록을 스크롤 방식으로 페이징 처리하기 위해 제품의 전체 개수 알아오기 //
//	int totalAllProductCount(String product_no) throws SQLException;

	
	// === Ajax(JSON)를 이용한 더보기 방식(페이징처리)으로 상품정보를 3개씩 잘라서(start ~ end) 조회해오기 === //  
	List<ProductVO> selectProduct(Map<String, String> param) throws SQLException;

	
	// ShoesCategory를 DB에서 가져오기
	List<HashMap<String, String>> getShoesCategoryList() throws SQLException;

	// 전체제품 중 러닝화만 가져옴
	List<ProductVO> selectAllRunningProduct(Map<String, String> paraMap) throws SQLException;
	


	
}
