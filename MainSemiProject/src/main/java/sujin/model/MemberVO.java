package sujin.model;

import java.util.Calendar;

public class MemberVO {

	// == 1. (회원가입시) insert 용도로 쓰일 필드 ==
	
	private String userid;			// 회원아이디
	private String pwd;				// 비밀번호 (SHA-256 암호화 대상 : 회원말고는 아무도 볼 수 없음)
	private String name;			// 회원명
	private String email;			// 이메일 (AES-256 암호화/복호화 대상 : 회사에서 볼려면 볼 수 있음)
	private String mobile;			// 연락처 (AES-256 암호화/복호화 대상 : 회원한테 연락할 때 사용) 
	private String postcode;		// 우편번호
	private String address;			// 주소
	private String detailaddress;	// 상세주소
	private String extraaddress;	// 참고항목
	private String gender;			// 성별   남자:1  / 여자:2
	private String birthday;		// 생년월일
	
	private int point;					// 포인트 (물건 구매시 올라감) 
	
	private String registerday;			// 가입일자                [db상으로 date 타입이지만 string] 
	private String lastpwdchangedate;	// 마지막으로 암호를 변경한 날짜 [db상으로 date 타입이지만 string]  
	
	private int status;					// 탈퇴여부   0 : 사용가능(가입중) / 1 :사용불능(탈퇴)
	private int idle;					// 휴면여부   0 : 활동중         / 1 : 휴면중(마지막 로그인 시각에서 현재까지 1년경과)
	private int admin;					// 관리자여부  0 : 일반회원       / 1 : 관리자
	
	
	//////////////////////////////////////////////////////////////
	
	
	// == 2. select 용도로 쓰일 필드 ==
	
	private boolean requirePwdChange = false;
	// 마지막으로 암호를 변경한 날짜가 현재시각으로부터 3개월이 지났으면 true 로 변경 
	// 마지막으로 암호를 변경한 날짜가 현재시각으로부터 3개월이 안됐으면 false 로 유지
	
	//////////////////////////////////////////////////////////////
	
	
	// == 3. 생성자 ==
	
	// --- 1) 기본생성자 필수!!! ---
	public MemberVO() {};
	
	// --- 4) 매개변수가 있는 생성자 생성2(gender만빠짐) [MemberEditEndAction.java 에서 필요함] ---
	public MemberVO(String userid, String pwd, String name, String email, String mobile, String postcode,
			String address, String detailaddress, String extraaddress, String birthday) {
	
		this.userid = userid;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
		this.mobile = mobile;
		this.postcode = postcode;
		this.address = address;
		this.detailaddress = detailaddress;
		this.extraaddress = extraaddress;
		this.birthday = birthday;
	}
	
	// --- 2) 필드를 사용하는 생성자 생성1 ---
	public MemberVO(String userid, String pwd, String name, String email, String mobile, String postcode,
			String address, String detailaddress, String extraaddress, String gender, String birthday) {
	
		this.userid = userid;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
		this.mobile = mobile;
		this.postcode = postcode;
		this.address = address;
		this.detailaddress = detailaddress;
		this.extraaddress = extraaddress;
		this.gender = gender;
		this.birthday = birthday;
	}
	
	// --- 3) getter&setter start--- //

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDetailaddress() {
		return detailaddress;
	}

	public void setDetailaddress(String detailaddress) {
		this.detailaddress = detailaddress;
	}

	public String getExtraaddress() {
		return extraaddress;
	}

	public void setExtraaddress(String extraaddress) {
		this.extraaddress = extraaddress;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public String getRegisterday() {
		return registerday;
	}

	public void setRegisterday(String registerday) {
		this.registerday = registerday;
	}

	public String getLastpwdchangedate() {
		return lastpwdchangedate;
	}

	public void setLastpwdchangedate(String lastpwdchangedate) {
		this.lastpwdchangedate = lastpwdchangedate;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getIdle() {
		return idle;
	}

	public void setIdle(int idle) {
		this.idle = idle;
	}
	
	public int getAdmin() {
		return admin;
	}

	public void setAdmin(int admin) {
		this.admin = admin;
	}
	
	//////////////////////////////////////////

	public boolean isRequirePwdChange() {
		return requirePwdChange;
	}

	public void setRequirePwdChange(boolean requirePwdChange) {
		this.requirePwdChange = requirePwdChange;
	}
	
	
	
	// --- 3) getter&setter end --- //
	
	
	//////////////////////////////////////////////////////////////
	
	
	public int getAge() {
		
		int age = 0;
		
		Calendar currentDate = Calendar.getInstance(); // 현재날짜와 시간을 얻어온다.
		
		int currentYear = currentDate.get(Calendar.YEAR);
		age = currentYear - Integer.parseInt(birthday.substring(0,4)) + 1;
		
		return age;
	}
	
	/////////////////////////////////////////////////
	
	private int cartCount; // 회원이 장바구니에 담은 상품수량

	public int getCartCount() {
		return cartCount;
	}
	
	public void setCartCount(int cartCount) {
	    this.cartCount = cartCount;
	}

	//////////////////////////////////////////////////
	
	// 마이페이지에서 비밀번호 변경한지 며칠이 지났는지 나타내는데 사용함
	
	private String pwdchange_daygap;

	public String getPwdchange_daygap() {
		return pwdchange_daygap;
	}

	public void setPwdchange_daygap(String pwdchange_daygap) {
		this.pwdchange_daygap = pwdchange_daygap;
	}
	
	//////////////////////////////////////////////////
	
	// 마이페이지에서 보일 쿠폰개수

	private int couponCnt;
	
	public int getCouponCnt() {
		return couponCnt;
	}

	public void setCouponCnt(int couponCnt) {
		this.couponCnt = couponCnt;
	}
	
	// 마이페이지에서 보일 쿠폰이름
	
	private String couponName;
	
	public String getCouponName() {
		return couponName;
	}

	public void setCouponName(String couponName) {
		this.couponName = couponName;
	}

	
	//////////////////////////////////////////////////

	
}
