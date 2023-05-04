package yunhwan.model;


import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface InterProductDAO {
	
	// === Ajax(JSON)를 이용한 더보기 방식(페이징처리)으로 상품정보를 6개씩 잘라서(start ~ end) 조회해오기 === //  
	List<ProductVO> selectProduct(Map<String, String> paraMap) throws SQLException;

	// Ajax(JSON)사용한 카테고리별 전체 제품개수 알아오기
	int totalAllCount(String category) throws SQLException;

	

}
