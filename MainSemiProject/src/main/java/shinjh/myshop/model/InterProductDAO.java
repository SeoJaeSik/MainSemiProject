package shinjh.myshop.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface InterProductDAO {
	
	// 메인페이지에 보여지는 상품이미지파일명을 모두 조회
	List<ImageVO> imageSelectAll() throws SQLException;

	// === Ajax(JSON)를 사용해 상품목록을 "더보기" 방식으로 페이징 처리 해주기 위해 스펙별로 제품의 전체갯수 알아오게하기
	int totalPspecCount(String fk_snum) throws SQLException;

	// Ajax(JSON)를 이용한 더보기 방식(페이징처리)으로 상품정보를 8개씩 잘라서(start ~ end) 조회해오기
	List<ProductVO> selectBySpecName(Map<String, String> paraMap) throws SQLException;

	// tbl_category 테이블에서 카테고리 대분류 번호(cnum), 카테고리코드(code), 카테고리명(cname)을 조회해오기 
	List<HashMap<String, String>> getCategoryList() throws SQLException;

	// 특정 카테고리에 속하는 제품들을 페이지바를 이용한 페이징 처리하여 조회(select)해오기
	List<ProductVO> selectProductByCategory(Map<String, String> paraMap) throws SQLException;

	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 제품에 대한 총페이지 알아오기
	int getTotalPage(Map<String, String> paraMap) throws SQLException;

	// cnum(카테고리번호)이 tbl_category 테이블에 존재하는지 존재하지 않는지 알아오기
	boolean isExist_cnum(String cnum) throws SQLException;

	// spec 목록을 조회해오기
	List<ShoesCategoryVO> selectSpecList() throws SQLException;

	// 제품번호 채번 해오기
	int getPnumOfProduct() throws SQLException;

	// tbl_product 테이블에 insert 하기
	int productInsert(ProductVO pvo) throws SQLException;

	// tbl_product_imagefile 테이블에 제품의 추가이미지 파일명 insert 해주기
	int product_imagefile_Insert(int pnum, String attachFileName) throws SQLException;

	// 제품번호를 가지고서 해당 제품의 정보를 조회해오기
	ProductVO selectOneProductByPnum(String pnum) throws SQLException;

	// 제품번호를 가지고 해당제품에 추가된 이미지 정보를 조회해오기
	List<String> getImagesByPnum(String pnum) throws SQLException;



}
