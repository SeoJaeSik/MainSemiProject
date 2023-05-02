package sukyung.model;

public class CartVO { 

	// insert 용 field
	private int cart_no;       		 //  장바구니코드
	private String fk_userid; 		 //  회원아이디            
	private int fk_product_no;       //  제품코드                
	private int cart_product_count;  //  수량            
	private String cart_registerday; //  장바구니 등록일자            
		
	// select 용 field
	private ProductVO pvo;  

	// 기본생성자
	public CartVO() {}
	
	// 파라미터생성자
	public CartVO(int cart_no, String fk_userid, int fk_product_no, int cart_product_count, 
				  String cart_registerday, ProductVO pvo) {
		this.cart_no = cart_no;
		this.fk_userid = fk_userid;
		this.fk_product_no = fk_product_no;
		this.cart_product_count = cart_product_count;
		this.cart_registerday = cart_registerday;
		this.pvo = pvo;
	}

	public int getCart_no() {
		return cart_no;
	}

	public void setCart_no(int cart_no) {
		this.cart_no = cart_no;
	}

	public String getFk_userid() {
		return fk_userid;
	}

	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}

	public int getFk_product_no() {
		return fk_product_no;
	}

	public void setFk_product_no(int fk_product_no) {
		this.fk_product_no = fk_product_no;
	}

	public int getCart_product_count() {
		return cart_product_count;
	}

	public void setCart_product_count(int cart_product_count) {
		this.cart_product_count = cart_product_count;
	}

	public String getCart_registerday() {
		return cart_registerday;
	}

	public void setCart_registerday(String cart_registerday) {
		this.cart_registerday = cart_registerday;
	}

	public ProductVO getPvo() {
		return pvo;
	}

	public void setPvo(ProductVO pvo) {
		this.pvo = pvo;
	}

}