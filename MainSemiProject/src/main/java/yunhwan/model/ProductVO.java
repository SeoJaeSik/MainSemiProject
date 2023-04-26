package yunhwan.model;

public class ProductVO {
	
	private String	product_no;       // 제품번호
	private String 	product_name;      // 제품명
	private int  	fk_shoes_category_no;    // 카테고리코드(Foreign Key)의 시퀀스번호 참조
	private String  product_image;    // 제품이미지1   이미지파일명
	private String  prdmanual_systemFileName;  // 파일서버에 업로드되어지는 실제 제품설명서 파일명 (파일명이 중복되는 것을 피하기 위해서 중복된 파일명이 있으면 파일명뒤에 숫자가 자동적으로 붙어 생성됨) 
	private String  prdmanual_orginFileName;   // 웹클라이언트의 웹브라우저에서 파일을 업로드 할때 올리는 제품설명서 파일명 
	private int 	stock_count;       // 제품 재고량
	private int 	product_price;      // 제품 정가
	private String 	product_content;   // 제품설명
	private String 	product_date; // 제품제조일자 
	private String 	upload_date; // 제품입고일자
	private String	product_color; // 제품 색깔
	private int		product_size; // 제품 사이즈 
	private int		sale_count;  // 판매 수량	
	
	private BuyerTypeVO btvo; // 고객유형VO 
	private ShoesCategoryVO scvo;        // 신발카테고리VO 
                                              
	
	
	public ProductVO() { }
	
	public ProductVO(String product_no, String product_name, int fk_shoes_category_no, String product_image, 
					String prdmanual_systemFileName, String prdmanual_orginFileName,
			         int stock_count, int product_price, int fk_snum, 
			         String product_content, String product_date, String upload_date, String product_color,
			         int product_size, int sale_count) {
	
		this.product_no = product_no;
		this.product_name = product_name;
		this.fk_shoes_category_no = fk_shoes_category_no;
		this.product_image = product_image;
		this.prdmanual_systemFileName = prdmanual_systemFileName;
		this.prdmanual_orginFileName = prdmanual_orginFileName;
		this.stock_count = stock_count;
		this.product_price = product_price;
		this.product_content = product_content;
		this.product_date = product_date;
		this.upload_date = upload_date;
		this.product_color = product_color;
		this.product_size = product_size;
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

	public int getFk_shoes_category_no() {
		return fk_shoes_category_no;
	}

	public void setFk_shoes_category_no(int fk_shoes_category_no) {
		this.fk_shoes_category_no = fk_shoes_category_no;
	}

	public String getProduct_image() {
		return product_image;
	}

	public void setProduct_image(String product_image) {
		this.product_image = product_image;
	}

	public String getPrdmanual_systemFileName() {
		return prdmanual_systemFileName;
	}

	public void setPrdmanual_systemFileName(String prdmanual_systemFileName) {
		this.prdmanual_systemFileName = prdmanual_systemFileName;
	}

	public String getPrdmanual_orginFileName() {
		return prdmanual_orginFileName;
	}

	public void setPrdmanual_orginFileName(String prdmanual_orginFileName) {
		this.prdmanual_orginFileName = prdmanual_orginFileName;
	}

	public int getStock_count() {
		return stock_count;
	}

	public void setStock_count(int stock_count) {
		this.stock_count = stock_count;
	}

	public int getProduct_price() {
		return product_price;
	}

	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}


	public String getProduct_content() {
		return product_content;
	}

	public void setProduct_content(String product_content) {
		this.product_content = product_content;
	}

	public String getProduct_date() {
		return product_date;
	}

	public void setProduct_date(String product_date) {
		this.product_date = product_date;
	}

	public String getUpload_date() {
		return upload_date;
	}

	public void setUpload_date(String upload_date) {
		this.upload_date = upload_date;
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

	public int getSale_count() {
		return sale_count;
	}

	public void setSale_count(int sale_count) {
		this.sale_count = sale_count;
	}

	public BuyerTypeVO getBtvo() {
		return btvo;
	}

	public void setBtvo(BuyerTypeVO btvo) {
		this.btvo = btvo;
	}

	public ShoesCategoryVO getScvo() {
		return scvo;
	}

	public void setScvo(ShoesCategoryVO scvo) {
		this.scvo = scvo;
	}

	
	
}


