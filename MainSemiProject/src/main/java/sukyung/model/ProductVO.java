package sukyung.model;

public class ProductVO {

	// insert 용 field
	private String product_no;           // 제품코드 300_3002_1
	private String product_name;         // 제품명 키즈아쿠아슈즈
	private String fk_shoes_category_no; // 신발종류코드 3002
	private int product_price;        	 // 제품가격 55000
	private String product_color;        // 신발색상 yellow
	private int product_size;         	 // 신발사이즈 130 
	private String product_image;        // 제품사진
	private String product_date;         // 제조일자 230201
	private String product_content;      // 제품설명 아쿠아슈즈
	private String upload_date;          // 제품등록일 sysdate 
	private int stock_count;          	 // 재고수량 100
	private int sale_count;           	 // 판매수량 0

	// select 용 field
	private BuyerTypeVO buyervo;
	private ShoesCategoryVO catevo;
		
	// CartVO 주문금액 계산
	private int totalPrice; // 판매당시의 제품판매가 * 주문량

	// 기본 생성자
	public ProductVO() {}
	
	// 파라미터 생성자
	public ProductVO(String product_no, String product_name, String fk_shoes_category_no, int product_price,
			String product_color, int product_size, String product_image, String product_date, String product_content,
			String upload_date, int stock_count, int sale_count) {
		this.product_no = product_no;
		this.product_name = product_name;
		this.fk_shoes_category_no = fk_shoes_category_no;
		this.product_price = product_price;
		this.product_color = product_color;
		this.product_size = product_size;
		this.product_image = product_image;
		this.product_date = product_date;
		this.product_content = product_content;
		this.upload_date = upload_date;
		this.stock_count = stock_count;
		this.sale_count = sale_count;
	}

	public String getProduct_no() {
		return product_no;
	}

	public void setProduct_no(String product_no) {
		this.product_no = product_no;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public String getFk_shoes_category_no() {
		return fk_shoes_category_no;
	}

	public void setFk_shoes_category_no(String fk_shoes_category_no) {
		this.fk_shoes_category_no = fk_shoes_category_no;
	}

	public int getProduct_price() {
		return product_price;
	}

	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}

	public String getProduct_color() {
		return product_color;
	}

	public void setProduct_color(String product_color) {
		this.product_color = product_color;
	}

	public int getProduct_size() {
		return product_size;
	}

	public void setProduct_size(int product_size) {
		this.product_size = product_size;
	}

	public String getProduct_image() {
		return product_image;
	}

	public void setProduct_image(String product_image) {
		this.product_image = product_image;
	}

	public String getProduct_date() {
		return product_date;
	}

	public void setProduct_date(String product_date) {
		this.product_date = product_date;
	}

	public String getProduct_content() {
		return product_content;
	}

	public void setProduct_content(String product_content) {
		this.product_content = product_content;
	}

	public String getUpload_date() {
		return upload_date;
	}

	public void setUpload_date(String upload_date) {
		this.upload_date = upload_date;
	}

	public int getStock_count() {
		return stock_count;
	}

	public void setStock_count(int stock_count) {
		this.stock_count = stock_count;
	}

	public int getSale_count() {
		return sale_count;
	}

	public void setSale_count(int sale_count) {
		this.sale_count = sale_count;
	}

	public BuyerTypeVO getBuyervo() {
		return buyervo;
	}

	public void setBuyervo(BuyerTypeVO buyervo) {
		this.buyervo = buyervo;
	}

	public ShoesCategoryVO getCatevo() {
		return catevo;
	}

	public void setCatevo(ShoesCategoryVO catevo) {
		this.catevo = catevo;
	}

	public void setTotalPrice(int cart_product_count) { // cart_product_count 는 주문수량임
		totalPrice = product_price * cart_product_count; 
	}

	public int getTotalPrice() {
		return totalPrice;
	}		

}