package yunhwan.model;

public class ProductVO {
	
	private String product_no;
	private String product_name;
	private int    privateshoes_category_no;
	private int    product_price;
	private String product_color;
	private int    product_size;
	private String product_image;
	private String product_date;
	private String product_content;
	private String upload_date;
	private int    stock_count;
	private int    sale_count;
	
	
	
	public ProductVO() { }
	
	public ProductVO(String product_no, String product_name, int privateshoes_category_no, int product_price,
			String product_color, int product_size, String product_image, String product_date, String product_content,
			String upload_date, int stock_count, int sale_count) {
		
		
		super();
		this.product_no = product_no;
		this.product_name = product_name;
		this.privateshoes_category_no = privateshoes_category_no;
		this.product_price = product_price;
		this.product_color = product_color;
		this.product_size = product_size;
		this.product_image = product_image;
		this.product_date = product_date;
		this.product_content = product_content;
		this.upload_date = upload_date;
		this.stock_count = stock_count;
		this.sale_count = sale_count;
	}// end of public ProductVO----------------------
	
	
	
	
	/////////// Getter Setter //////////////
	
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
	public int getPrivateshoes_category_no() {
		return privateshoes_category_no;
	}
	public void setPrivateshoes_category_no(int privateshoes_category_no) {
		this.privateshoes_category_no = privateshoes_category_no;
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
	
	
	
	
	
	
	
}


