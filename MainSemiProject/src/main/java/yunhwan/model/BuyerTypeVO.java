package yunhwan.model;

public class BuyerTypeVO {


	private String buyer_type_no;	// 고객유형코드     
	private String buyer_type_name;	// 고객유형명
	
	public BuyerTypeVO() { }

	public BuyerTypeVO(String buyer_type_no, String buyer_type_name) {
	
		this.buyer_type_no = buyer_type_no;
		this.buyer_type_name = buyer_type_name;
	}
	
	
	public String getBuyer_type_no() {
		return buyer_type_no;
	}

	public void setBuyer_type_no(String buyer_type_no) {
		this.buyer_type_no = buyer_type_no;
	}

	public String getBuyer_type_name() {
		return buyer_type_name;
	}

	public void setBuyer_type_name(String buyer_type_name) {
		this.buyer_type_name = buyer_type_name;
	}
	
}
