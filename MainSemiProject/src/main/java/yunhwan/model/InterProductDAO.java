package yunhwan.model;


import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface InterProductDAO {

	// (ALL)전체제품 목록 나타내기 + Ajax(JSON)를 사용하여 전체상품목록을 스크롤 방식으로 페이징 처리하기 위해 제품의 전체 개수 알아오기 //
	int totalAllProductCount(String string) throws SQLException;


	


	
}
