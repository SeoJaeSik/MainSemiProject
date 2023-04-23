package jaesik.model;

import java.sql.SQLException;

public interface JS_InterMemberDAO {

	// 입력받은 이메일로 가입된 유저로 존재하는지 알아오는 메소드 존재하면 해당 id를 리턴
	String isUserExistID (String email) throws SQLException ;

	// 가입된 유저이므로 해당 유저에게 발급된 쿠폰번호와 같은 쿠폰번호를 쿠폰테이블에 insert
	int sendCouponCode(String isUserExistID, String certificationCode) throws SQLException;

}
