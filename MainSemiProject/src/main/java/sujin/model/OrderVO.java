package sujin.model;

public class OrderVO {

	// == insert 용도로 쓰일 필드 ==
	private String order_no;
	private String orderdate;
	private String total_price;
	private String delivery_name;
	private String delivery_mobile;
	private String delivery_address;
	private String delivery_comment;
	private String delivery_invoice;
	

	// == 생성자 ==
	// --- 기본생성자 필수!!! ---
	public OrderVO() {};
	
	
	public String getOrder_no() {
		return order_no;
	}

	public void setOrder_no(String order_no) {
		this.order_no = order_no;
	}
	

	public String getOrderdate() {
		return orderdate;
	}

	public void setOrderdate(String orderdate) {
		this.orderdate = orderdate;
	}


	public String getTotal_price() {
		return total_price;
	}

	public void setTotal_price(String total_price) {
		this.total_price = total_price;
	}


	public String getDelivery_name() {
		return delivery_name;
	}

	public void setDelivery_name(String delivery_name) {
		this.delivery_name = delivery_name;
	}


	public String getDelivery_mobile() {
		return delivery_mobile;
	}

	public void setDelivery_mobile(String delivery_mobile) {
		this.delivery_mobile = delivery_mobile;
	}


	public String getDelivery_address() {
		return delivery_address;
	}

	public void setDelivery_address(String delivery_address) {
		this.delivery_address = delivery_address;
	}


	public String getDelivery_comment() {
		return delivery_comment;
	}

	public void setDelivery_comment(String delivery_comment) {
		this.delivery_comment = delivery_comment;
	}


	public String getDelivery_invoice() {
		return delivery_invoice;
	}

	public void setDelivery_invoice(String delivery_invoice) {
		this.delivery_invoice = delivery_invoice;
	}

	
	
	
	
}
