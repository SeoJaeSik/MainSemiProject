package sukyung.model;

public class OrderDetailVO { 

	// insert 용 field
    private String order_detail_no; // 주문상세일련번호
    private String fk_product_no; 	// 제품번호
    private String fk_order_no; 	// 주문번호
    private int order_count; 		// 주문수량
    private int order_price; 		// 주문가격
		
	// select 용 field
	private ProductVO pvo;  

	// 기본생성자
	public OrderDetailVO() {}

	// 파라미터생성자
	public OrderDetailVO(String order_detail_no, String fk_product_no, String fk_order_no, int order_count,
			int order_price, ProductVO pvo) {
		this.order_detail_no = order_detail_no;
		this.fk_product_no = fk_product_no;
		this.fk_order_no = fk_order_no;
		this.order_count = order_count;
		this.order_price = order_price;
		this.pvo = pvo;
	}

	public String getOrder_detail_no() {
		return order_detail_no;
	}

	public void setOrder_detail_no(String order_detail_no) {
		this.order_detail_no = order_detail_no;
	}

	public String getFk_product_no() {
		return fk_product_no;
	}

	public void setFk_product_no(String fk_product_no) {
		this.fk_product_no = fk_product_no;
	}

	public String getFk_order_no() {
		return fk_order_no;
	}

	public void setFk_order_no(String fk_order_no) {
		this.fk_order_no = fk_order_no;
	}

	public int getOrder_count() {
		return order_count;
	}

	public void setOrder_count(int order_count) {
		this.order_count = order_count;
	}

	public int getOrder_price() {
		return order_price;
	}

	public void setOrder_price(int order_price) {
		this.order_price = order_price;
	}

	public ProductVO getPvo() {
		return pvo;
	}

	public void setPvo(ProductVO pvo) {
		this.pvo = pvo;
	}

}