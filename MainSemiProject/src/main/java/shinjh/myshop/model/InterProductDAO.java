package shinjh.myshop.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

public interface InterProductDAO {
	
	// 제품이름과 색상을 가지고서 해당 제품의 정보를 조회해오기
	ProductVO selectOneProduct(String product_name, String product_color) throws SQLException;

	// 제품이름을 가지고서 해당 제품의 정보를 조회해오기
	ProductVO selectProductByName(String product_name) throws SQLException;

	// 제품이름과 색상을 가지고 해당제품에 추가된 이미지 정보를 조회해오기
	List<String> getImages(String product_name, String product_color) throws SQLException;

	// 제품이름을 가지고 색상과 이미지 List를 가져오기
	List<HashMap<String, String>> getColorByName(String product_name) throws SQLException;

	// 제품이름과 색상을 가지고 사이즈 선택지를 가져오기 
	List<Integer> getSize(String product_name, String product_color) throws SQLException;

	
}
