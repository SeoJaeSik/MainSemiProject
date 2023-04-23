package jaesik.model;

public class JS_MemverVO {

	private String userid;			// VARCHAR2(40)    NOT NULL -- 회원아이디
	private String pwd;				// VARCHAR2(200)   NOT NULL -- 비밀번호 (SHA-256 암호화 대상 : 회원말고는 아무도 볼 수 없음)
	private String name;			// VARCHAR2(30)    NOT NULL -- 성명
	private String email;			// VARCHAR2(200)   NOT NULL -- 이메일 (AES-256 암호화/복호화 대상 : 회사에서 볼려면 볼 수 있음)
	private String mobile;			// VARCHAR2(200)            -- 연락처 (AES-256 암호화/복호화 대상 : 회원한테 연락할 때 사용) 
	private String postcode;		// VARCHAR2(5)              -- 우편번호
	private String address; 		// VARCHAR2(200)            -- 주소
	private String detailaddress;	// VARCHAR2(200)            -- 상세주소
	private String extraaddress;	// VARCHAR2(200)            -- 참고주소
	private String gender;			// VARCHAR2(1)              -- 성별 남자:1 / 여자:2
	private String birthday; 		// VARCHAR2(10)             -- 생년월일
	private int point;				// NUMBER default 0         -- 포인트 (물건 구매시 올라감) 
	private String registerday;		// DATE default SYSDATE     -- 가입일자
	private String lastpwdchangedate;//DATE default SYSDATE     -- 마지막암호변경일
	private int status;				// number(1) default 0 not null     -- 탈퇴여부   0 : 사용가능(가입중) / 1 :사용불능(탈퇴) 
	private int idle;				// number(1) default 0 not null     -- 휴면여부   0 : 활동중         / 1 : 휴면중
	private int admin;				// number(1) default 0 not null     -- 관리자여부  0 : 일반회원       / 1 : 관리자

	
	private boolean requirePwdChange = false;
	// 마지막으로 암호를 변경할 날짜가 현재시각으로 부터 3개월이 지났으면 true 지나지 않았으면 false


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
	public boolean isRequirePwdChange() {
		return requirePwdChange;
	}
	public void setRequirePwdChange(boolean requirePwdChange) {
		this.requirePwdChange = requirePwdChange;
	}
	
	

}
