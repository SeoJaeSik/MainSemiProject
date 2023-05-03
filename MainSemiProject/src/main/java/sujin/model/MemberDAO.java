package sujin.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import util.security.AES256;
import util.security.SecretMyKey;
import util.security.Sha256;

public class MemberDAO implements InterMemberDAO {

	private DataSource ds; /* DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다. */
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	
	// == 사용한 자원을 반납하는 close() 메소드 생성하기(마지막부터 순서대로 닫기) ==
	private void close() {	
		try {
			if(rs != null) 		{rs.close(); 	rs = null;}
			if(pstmt != null) 	{pstmt.close(); pstmt = null;}
			if(conn != null) 	{conn.close(); 	conn = null;}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	// == 생성자 ==
	public MemberDAO() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semi_oracle"); /* lookup은 배치서술자 context.xml 에 있는 name 인 "jdbc/semi_oracle" 을 보고 잘 써줘야 한다 */
		    
		    aes = new AES256(SecretMyKey.KEY);
		    /* SecretMyKey.KEY 은 우리가 만든 암호화/복호화 키이다. */
		
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
	
	
	
	// 1. (사용) 회원가입을 해주는 메소드 (tbl_member 테이블에 insert) 구현하기
	@Override
	public int registerMember(MemberVO member) throws SQLException {
		
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthday) "
					   + " values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";

			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, member.getUserid());              /* 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다. */
			pstmt.setString(2, Sha256.encrypt(member.getPwd())); /* Sha256.encrypt(평문) : qwer1234! 가 비번이라면 aksjhdluhsmeafoiwlhe1243242@#$%@ 이렇게 들어가도록 암호화 해줌 */
			pstmt.setString(3, member.getName());
			pstmt.setString(4, aes.encrypt(member.getEmail()));  /* 이메일을 AES256 알고리즘으로 양방향 암호화 시킨다. 익셉션처리 필수 */
			pstmt.setString(5, aes.encrypt(member.getMobile())); /* 연락처를 AES256 알고리즘으로 양방향 암호화 시킨다. 익셉션처리 필수 */
			pstmt.setString(6, member.getPostcode());
			pstmt.setString(7, member.getAddress());
			pstmt.setString(8, member.getDetailaddress());
			pstmt.setString(9, member.getExtraaddress());
			pstmt.setString(10, member.getGender());
			pstmt.setString(11, member.getBirthday());
			
			result = pstmt.executeUpdate();
			// 정상적으로 insert 됐다면 1 이 나올 것이다.
			
		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close(); /* 무조건 자원반납 */
		}
		
		return result;
		
	}//end of 1. 회원가입 메소드---------------------------------

	

	// 2. (사용) ID 중복검사 해주는 메소드 구현하기 
	// (tbl_member 테이블에서 userid 가 존재하면 true 를 리턴해주고, userid 가 존재하지 않으면 false 를 리턴한다.)
	@Override
	public boolean idDuplicateCheck(String userid) throws SQLException {
		
		boolean isExists = false;
		
		try {
			conn = ds.getConnection();
			
			/* 행이 있나없나만 검사하면 된다 */
			String sql = " select userid "
					   + " from tbl_member "
					   + " where userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			
			isExists = rs.next();  // 행이 있으면 (중복된 userid가 있다로) true, 
			                       //     없으면 (사용가능한 userid다로) false 그대로 일것이다.
			
		} finally {
			close(); /* 무조건 자원반납 */
		}
		
		return isExists;
		
	}//end of 2. ID 중복검사 해주는 메소드---------------------------------


	// 3. (사용) email 중복검사 해주는 메소드 구현하기
	// (tbl_member 테이블에서 email 가 존재하면 true 를 리턴해주고, email 가 존재하지 않으면 false 를 리턴한다.)
	@Override
	public boolean emailDuplicateCheck(String email) throws SQLException {
		
		boolean isExists = false;
		
		try {
			conn = ds.getConnection();
			
			/* 행이 있나없나만 검사하면 된다 */
			String sql = " select email "
					   + " from tbl_member "
					   + " where email = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, aes.encrypt(email)); // 평문 이메일말고 아에 암호된 이메일을 넣어준다
			rs = pstmt.executeQuery();
			
			isExists = rs.next();  // 행이 있으면 (중복된 email가 있다로) true, 
			                       //     없으면 (사용가능한 email다로) false 그대로 일것이다.
			
		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close(); /* 무조건 자원반납 */
		}
		
		return isExists;
		
	}//end of 3. email 중복검사 해주는 메소드---------------------------------


	// 4. (사용) 입력받은 paraMap 을 갖고 한명의 회원정보를 리턴시켜주는 메소드(로그인처리) 구현하기
	@Override
	public MemberVO selectOneMember(Map<String, String> paraMap) throws SQLException {
		
		MemberVO member = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " SELECT userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, "
					   + "        birthyyyy, birthmm, birthdd, point, registerday, pwdchange_daygap, "
					   + "		  pwdchangegap, "
					   + "        NVL( latelogingap, trunc(months_between(sysdate,registerday)) ) AS latelogingap , admin "
					   + " FROM "
					   + " ( "
					   + "     select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender "
					   + "            , substr(birthday,1,4) AS birthyyyy "
					   + "            , substr(birthday,5,2) AS birthmm "
					   + "            , substr(birthday,7,2) AS birthdd "
					   + "            , point, to_char(registerday, 'yyyy-mm-dd') AS registerday "
					   + "            , ceil(sysdate-lastpwdchangedate) AS pwdchange_daygap "
					   + "            , trunc(months_between(sysdate,lastpwdchangedate)) AS pwdchangegap, admin "
					   + "     from tbl_member "
					   + "     where status = 0 and userid = ? and pwd = ? "
					   + " ) M "
					   + " CROSS JOIN "
					   + " ( "
					   + "     select trunc(months_between(sysdate,max(login_history))) AS latelogingap "
					   + "     from tbl_login_history "
					   + "     where fk_userid = ? "
					   + " ) H " ;
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, Sha256.encrypt(paraMap.get("pwd")));    // 단방향 암호화된 값을 넣어줘야한다
			pstmt.setString(3, paraMap.get("userid"));
			
			rs = pstmt.executeQuery(); // 존재한다면 딱 하나의 값이 나올 것이다.
			
			if(rs.next()) { // DB에 존재하는게 있다면 나올 딱 하나의 값을 가져오자
				
				member = new MemberVO();
				
				member.setUserid(rs.getString(1));
				member.setName(rs.getString(2));
				member.setEmail(aes.decrypt(rs.getString(3)));
				member.setMobile(aes.decrypt(rs.getString(4)));
				member.setPostcode(rs.getString(5));
				member.setAddress(rs.getString(6));
				member.setDetailaddress(rs.getString(7));
				member.setExtraaddress(rs.getString(8));
				member.setGender(rs.getString(9));
				member.setBirthday(rs.getString(10) + rs.getString(11) + rs.getString(12));
				member.setPoint(rs.getInt(13));
				member.setRegisterday(rs.getString(14));
				member.setPwdchange_daygap(rs.getString("PWDCHANGE_DAYGAP"));
				
				if(rs.getInt("PWDCHANGEGAP") >= 3) { // -> rs.getInt(15) : 순서가 헷갈릴 때는 그냥 변수명으로 넣어줘도 된다
					// 마지막으로 암호를 변경한 날짜가 현재시각으로부터 3개월이 넘었으면 true, 아니면 false
					
					member.setRequirePwdChange(true); /* 로그인시 암호를 바꿔야 한다는 alert 를 띄우도록 할 때 사용한다 */
				} 
				
				if(rs.getInt("LATELOGINGAP") >= 12) { // -> rs.getInt(16) 
					// 마지막 로그인으로부터 1년이 지나면 true(휴면계정으로 전환), 아니면 false 
					
					member.setIdle(1); /* 휴면계정으로 전환 */
					
					// === tbl_member 테이블의 idle 컬럼의 값을 1로 변경하기 ===
					sql = " update tbl_member set idle = 1 "
						+ " where userid = ? ";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, paraMap.get("userid"));
					
					pstmt.executeUpdate();
				}
				
				
				// == 관리자 인지 확인하고 admin loginuser 세션에 넣어줌 ==
				member.setAdmin(rs.getInt("ADMIN"));
				
				
				// == tbl_loginhistory(로그인기록) 테이블에 insert 하기 == //
				if(member.getIdle() != 1) {
					
					sql = " insert into tbl_login_history (fk_userid, client_ip) "
						+ " values(?, ?) ";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, paraMap.get("userid"));
					pstmt.setString(2, paraMap.get("clientip"));
					
					pstmt.executeUpdate();	
				}
				
				
			}//end of if(rs.next())-----------------------------------
			
			
		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close(); /* 무조건 자원반납 */
		}
		
		return member;
		
	}//end of 4. 입력받은 paraMap 을 갖고 한명의 회원정보를 리턴시켜주는 메소드-----------

	

	// == 입력받은 paraMap 을 갖고 한명의 쿠폰정보를 리턴시켜주는 메소드 (로그인 할 때 동시에 되게 하자) ==
	@Override
	public Map<String, String> selectMembercoupon(Map<String, String> paraMap) throws SQLException {
		
		Map<String, String> couponMap = new HashMap<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select distinct COUPON_NAME as COUPONNAME"
					   + " from tbl_user_coupon "
					   + " where fk_userid = ? " ;
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("userid"));
			
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			
			while(rs.next()) { // DB에 존재하는게 있다면 나올 딱 하나의 값을 가져오자
				
				cnt++;
				couponMap.put("couponName", rs.getString("COUPONNAME"));
				
			}//end of while(rs.next())-----------------------------------
		
			couponMap.put("couponCnt", String.valueOf(cnt));
			
		} finally {
			close(); /* 무조건 자원반납 */
		}
		
		return couponMap;
		
	}//end of == 쿠폰 정보 불러오기 ==-------------------------------------------

	
	// == [마이페이지-주문내역] 입력받은 paraMap 을 갖고 한명의 주문번호를 리턴시켜주는 메소드 (로그인 할 때 동시에 되게 하자) ==
	@Override
	public List<OrderVO> selectMemberOrderNo(String userid) throws SQLException {
		
		List<OrderVO> ovolist = new ArrayList<>();
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select A.order_no, to_char(A.orderdate,'yyyy-MM-dd'), A.total_price "
	         		    + "      , D.delivery_name, D.delivery_mobile, D.delivery_address, D.delivery_comment, D.delivery_invoice "
	         		    + " from "
	         		    + " (	select order_no, orderdate, total_price "
	         		    + " 	from tbl_order "
	         		    + " 	where fk_userid = ? "
	         		    + "		order by orderdate desc "
	         		    + "	) A "
	         		    + " join tbl_delivery D "
	         		    + " on A.order_no = D.fk_order_no " ;
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, userid);
	         
	         rs = pstmt.executeQuery();

	         while(rs.next()) {
	        
	        //  String order_no = rs.getString(1); // 주문번호
				OrderVO ovo = new OrderVO();
				ovo.setOrder_no(rs.getString(1));
				ovo.setOrderdate(rs.getString(2));
				ovo.setTotal_price(rs.getString(3));
				ovo.setDelivery_name(rs.getString(4));
				ovo.setDelivery_mobile(rs.getString(5));
				ovo.setDelivery_address(rs.getString(6));
				ovo.setDelivery_comment(rs.getString(7));
				ovo.setDelivery_invoice(rs.getString(8));
				
				ovolist.add(ovo);
			//	System.out.println("ovo.getOrder_no() 확인 2 : " + ovo.getOrder_no());
			//	System.out.println("ovolist 확인 1 : " + ovolist);
					
	         }//end of while()-------------------
	         
	      } finally {
	         close();
	      }
	      
	      return ovolist;

	}//end of == 주문번호 가져오기 메소드 ==---------------------------------------
	

	// 5. (사용) 아이디 찾기 : 입력받은 paraMap 으로 성명&이메일을 입력받아 해당 사용자의 아이디를 알려주는 메소드 구현하기
	@Override
	public String findUserid(Map<String, String> paraMap) throws SQLException {
		
		String userid = null;
		
		try {
			conn = ds.getConnection();
			
			/* status = 1 : 탈퇴하지 않은 회원중에서만! */
			String sql = " select userid "
					   + " from tbl_member "
					   + " where status = 0 and name = ? and email = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("name"));
			pstmt.setString(2, aes.encrypt(paraMap.get("email"))); // 평문 이메일말고 아에 암호된 이메일을 넣어준다
			rs = pstmt.executeQuery();
		
			if(rs.next()) { // *^* select 한게 있다면 그게 들어올 것이고,
				userid = rs.getString(1);
			}
			
		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close(); /* 무조건 자원반납 */
		}
		
		return userid;     // *^* select 된게 없다면 그냥 null 값이 넘어올 것이다.
		
	}//end of 5. 아이디찾기----------------------------------------------------


	// 6. (사용) 비밀번호 찾기 : 입력한 paraMap 으로 아이디&이메일을 가진 회원이 존재하는지 알아보는 메소드 구현하기
	@Override
	public boolean isUserExist(Map<String, String> paraMap) throws SQLException {
	
		boolean isUserExist = false;
		
		try {
			conn = ds.getConnection();
			
			// status = 0 : 탈퇴하지 않은 회원중에서만! 
			String sql = " select userid "
					   + " from tbl_member "
					   + " where status = 0 and userid = ? and email = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, aes.encrypt(paraMap.get("email"))); // 평문 이메일말고 아에 암호된 이메일을 넣어준다
			rs = pstmt.executeQuery();
		
			isUserExist = rs.next();
			
		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close(); // 무조건 자원반납 
		}
		
		return isUserExist; // 단지 회원이 존재하는지만 넘겨주는것이다!
	
	}//end of 6. 비밀번호 찾기--------------------------------------------------

	
	// == 비밀번호 변경 이메일을 보내기 위해 Map 에 userid 와 Email 을 보내 해당 사용자의 이메일을 알려주는 메소드 구현하기 == 
	@Override
	public MemberVO selectmbrforpwdReset(Map<String, String> paraMap) throws SQLException {
		
		MemberVO member = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select userid, name, email "
					   + " from tbl_member "
					   + " where status = 0 and userid = ? and email = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, aes.encrypt(paraMap.get("email"))); // 평문 이메일말고 아에 암호된 이메일을 넣어준다
			
			rs = pstmt.executeQuery(); // 존재한다면 딱 하나의 값이 나올 것이다.
			
			if(rs.next()) { // DB에 존재하는게 있다면 나올 딱 하나의 값을 가져오자
				
				member = new MemberVO();
				
				member.setUserid(rs.getString(1));
				member.setName(rs.getString(2));
			//	member.setEmail(aes.decrypt(rs.getString(3)));
				member.setEmail(rs.getString(3)); // 암호화된 이메일
				
				
			}//end of if(rs.next())-----------------------------------
			
			
		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close(); /* 무조건 자원반납 */
		}
		
		return member;
		
	}//end of == 비밀번호 변경 이메일을 보내기 위해 Map 에 userid 와 Email 을 보내 해당 사용자의 이메일을 알려주는 메소드--------- 
	

	// 7. (사용) 암호변경하기 : 입력한 paraMap 으로 들어온 아이디와 일치하는 회원의 암호를 변경해주는 메소드 구현하기
	@Override
	public int pwdUpdate(Map<String, String> paraMap) throws SQLException {

		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " update tbl_member set pwd = ? "
					   + " , lastpwdchangedate = sysdate "
					   + " where userid = ? and email = ? ";

			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, Sha256.encrypt(paraMap.get("pwd"))); /* 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다. */
			pstmt.setString(2, paraMap.get("userid"));
			
			String email = paraMap.get("email").replaceAll(" ", "+");
			pstmt.setString(3, email);
			
		//	System.out.println("~~~ 요기요2 paraMap.get(\"userid\") : " + paraMap.get("userid"));
			// sudin
		//	System.out.println("~~~ 요기요2 email : " + email);
			// EVnIknjwnS439aY+ftrHKgD+d/CWhHfOKJgWRqoznHw=
			
			// EVnIknjwnS439aY ftrHKgD d/CWhHfOKJgWRqoznHw=
			
			result = pstmt.executeUpdate();
			// 정상적으로 update 됐다면 1 이 나올 것이다.
			
		}  finally {
			close(); /* 무조건 자원반납 */
		}
		
		return result;
		
	}//end of 7. 암호변경하기--------------------------------------------------

	
	// 9. (사용) 회원의 개인정보 변경하기 메소드 구현하기
	@Override
	public int updateMember(MemberVO member) throws SQLException {
		
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " update tbl_member set name = ? , userid = ?, pwd = ? , email = ? , mobile = ? , postcode = ? ,"
					   + "                       address = ? , detailaddress = ? , extraaddress = ? , birthday = ? , "
					   + "                       lastpwdchangedate = sysdate "
					   + " where userid = ? ";

			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, member.getName());                
			pstmt.setString(2, member.getUserid());				 /* 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다. */
			pstmt.setString(3, Sha256.encrypt(member.getPwd())); /* Sha256.encrypt(평문) : qwer1234! 가 비번이라면 aksjhdluhsmeafoiwlhe1243242@#$%@ 이렇게 들어가도록 암호화 해줌 */			
			pstmt.setString(4, aes.encrypt(member.getEmail()));  /* 이메일을 AES256 알고리즘으로 양방향 암호화 시킨다. 익셉션처리 필수 */
			pstmt.setString(5, aes.encrypt(member.getMobile())); /* 연락처를 AES256 알고리즘으로 양방향 암호화 시킨다. 익셉션처리 필수 */
			pstmt.setString(6, member.getPostcode());
			pstmt.setString(7, member.getAddress());
			pstmt.setString(8, member.getDetailaddress());
			pstmt.setString(9, member.getExtraaddress());
			pstmt.setString(10, member.getBirthday());
			pstmt.setString(11, member.getUserid());
			
			result = pstmt.executeUpdate();
			// 정상적으로 insert 됐다면 1 이 나올 것이다.
			
		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close(); /* 무조건 자원반납 */
		}
		
		return result;
		
	}//end of 9. 회원의 개인정보 변경하기 메소드--------------------------------


	// 10. (사용) 암호 변경시 현재 사용중인 암호인지 아닌지 알아오는 메소드 구현하기
	@Override
	public int duplicatePwdCheck(Map<String, String> paraMap) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			/* status = 1 : 탈퇴하지 않은 회원중에서만! */
			String sql = " select count(*) "
					   + " from tbl_member "
					   + " where userid = ? and pwd = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, Sha256.encrypt(paraMap.get("new_pwd")));
			
			rs = pstmt.executeQuery();
		
			rs.next();
			
			n = rs.getInt(1);
			
		} finally {
			close(); /* 무조건 자원반납 */
		}
		
		return n; 
		
	}//end of 10. 암호 변경시 현재 사용중인 암호인지 아닌지 알아오는 메소드------------ 


	// 14. userid 값을 입력받아 회원 1명에 대한 상세정보를 알아오는 메소드 구현하기
	@Override
	public MemberVO memberOneDetail(String userid) throws SQLException {
		
		MemberVO mvo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender "
					   + "	    , substr(birthday,1,4) AS birthyyyy "
					   + "	    , substr(birthday,6,2) AS birthmm "
					   + "	    , substr(birthday,9,2) AS birthdd "
					   + "	    , point, to_char(registerday, 'yyyy-mm-dd') AS registerday "
					   + " from tbl_member "
				 	   + " where userid = ? ";
		
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid); 
			
			rs = pstmt.executeQuery(); // 돌려라~ 존재한다면 딱 하나의 값이 나올 것이다.
			
			if(rs.next()) {
				mvo = new MemberVO();
				
				mvo.setUserid(rs.getString(1));
				mvo.setName(rs.getString(2));
				mvo.setEmail(aes.decrypt(rs.getString(3)));
				mvo.setMobile(aes.decrypt(rs.getString(4)));
				mvo.setPostcode(rs.getString(5));
				mvo.setAddress(rs.getString(6));
				mvo.setDetailaddress(rs.getString(7));
				mvo.setExtraaddress(rs.getString(8));
				mvo.setGender(rs.getString(9));
				mvo.setBirthday(rs.getString(10) + rs.getString(11) + rs.getString(12));
				mvo.setPoint(rs.getInt(13));
				mvo.setRegisterday(rs.getString(14));
				
			}//end of if(rs.next())-----------------------------------
			
		} catch (GeneralSecurityException | UnsupportedEncodingException e) { /* 복호화시 날수있는 에러 잡아줌 */
			e.printStackTrace();
		} finally {
			close(); /* 무조건 자원반납 */
		}
		
		return mvo;
		
	}//end of 14. userid 값을 입력받아 회원 1명에 대한 상세정보를 알아오는 메소드---------- 


}