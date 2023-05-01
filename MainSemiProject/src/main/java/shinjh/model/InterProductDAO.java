package shinjh.myshop.model;

import java.sql.SQLException;
import java.util.List;

public interface InterProductDAO {

	// 제품이름을 가지고서 해당 제품의 정보를 조회해오기
	ProductVO selectOneProductByProduct_name(String product_name) throws SQLException;

	// 제품이름과 색상을 가지고 해당제품에 추가된 이미지 정보를 조회해오기
	List<String> getImagesByProduct_name(String product_name, String product_color) throws SQLException;

	// 제품이름을 가지고 색상 이미지를 가져오기
	List<String> getColorByProduct_name(String product_name) throws SQLException;

	// 제품이름을 가지고 사이즈 선택지(사이즈, 재고수량)를 가져오기 
	List<Integer> getSizeByProduct_size(String product_name, String product_color) throws SQLException;
	
}
