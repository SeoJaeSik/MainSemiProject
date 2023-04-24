package yunhwan.model;

public class ShoesCategoryVO {

	private String shoes_category_no;   // 신발종류코드
	private String fk_buyer_type_no;   // 고객유형코드
	private String shoes_category_name;  // 신발종류명
	
	public ShoesCategoryVO() {}
	
	public ShoesCategoryVO(String shoes_category_no, String fk_buyer_type_no, String shoes_category_name) {
		this.shoes_category_no = shoes_category_no;
		this.fk_buyer_type_no = fk_buyer_type_no;
		this.shoes_category_name = shoes_category_name;
	}

	public String getShoes_category_no() {
		return shoes_category_no;
	}

	public void setShoes_category_no(String shoes_category_no) {
		this.shoes_category_no = shoes_category_no;
	}

	public String getFk_buyer_type_no() {
		return fk_buyer_type_no;
	}

	public void setFk_buyer_type_no(String fk_buyer_type_no) {
		this.fk_buyer_type_no = fk_buyer_type_no;
	}

	public String getShoes_category_name() {
		return shoes_category_name;
	}

	public void setShoes_category_name(String shoes_category_name) {
		this.shoes_category_name = shoes_category_name;
	}

	
}
