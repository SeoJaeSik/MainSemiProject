package sukyung.model;

public class ShoesCategoryVO {

	// insert 용 field
	private String shoes_category_no; 	// 신발종류코드 1111, 2222, 3333, 4444, 5555
	private String shoes_category_name; // 신발종류명  running, walking, golf, sandal, aquashoes 
	private String fk_buyer_type_no;  	// 고객유형코드

	// select 용 field
	private BuyerTypeVO buyervo;

	// 기본 생성자
	public ShoesCategoryVO() {}
	
	// 파라미터 생성자
	public ShoesCategoryVO(String shoes_category_no, String shoes_category_name, String fk_buyer_type_no,
			BuyerTypeVO buyervo) {
		this.shoes_category_no = shoes_category_no;
		this.shoes_category_name = shoes_category_name;
		this.fk_buyer_type_no = fk_buyer_type_no;
		this.buyervo = buyervo;
	}

	public String getShoes_category_no() {
		return shoes_category_no;
	}

	public void setShoes_category_no(String shoes_category_no) {
		this.shoes_category_no = shoes_category_no;
	}

	public String getShoes_category_name() {
		return shoes_category_name;
	}

	public void setShoes_category_name(String shoes_category_name) {
		this.shoes_category_name = shoes_category_name;
	}

	public String getFk_buyer_type_no() {
		return fk_buyer_type_no;
	}

	public void setFk_buyer_type_no(String fk_buyer_type_no) {
		this.fk_buyer_type_no = fk_buyer_type_no;
	}

	public BuyerTypeVO getBuyervo() {
		return buyervo;
	}

	public void setBuyervo(BuyerTypeVO buyervo) {
		this.buyervo = buyervo;
	}
	
}