package yunhwan.model;


import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface InterProductDAO {

	
	// === Ajax(JSON)를 이용한 더보기 방식(페이징처리)으로 상품정보를 9개씩 잘라서(start ~ end) 조회해오기 === //  
	List<ProductVO> selectProduct(Map<String, String> param) throws SQLException;
	
	
}
