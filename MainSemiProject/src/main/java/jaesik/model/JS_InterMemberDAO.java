package jaesik.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import sujin.model.MemberVO;

public interface JS_InterMemberDAO {

	// 입력받은 이메일로 가입된 유저로 존재하는지 알아오는 메소드 존재하면 해당 id를 리턴
	String isUserExistID (String email) throws SQLException ;

	// 가입된 유저이므로 해당 유저에게 발급된 쿠폰번호와 같은 쿠폰번호를 쿠폰테이블에 insert
	int sendCouponCode(String isUserExistID, String certificationCode) throws SQLException;
 
	// 신규회원 쿠폰을 이미 지급 받은사람인지 체크하는 메소드 발급된 유저이면 true
	boolean isCouponExist(String isUserExistID) throws SQLException;

	// 해당 유저가 존재하는지 알아오는 메소드
	boolean isUserExist(String userid) throws SQLException;

	// 고객센터로 보낸 메시지를 board 테이블에 insert
	int uploadBoard(BoardVO bvo) throws SQLException;

	// 페이징 처리를 위한 검색이 있는 검색이 없는 전체회원에 대한 총 페이지 알아오기
	int getTotalPage(Map<String, String> paraMap) throws SQLException;

	// 타입과 단어, 페이징 갯수를 받아 페이징한 모든회원 또는 검색한 회원 목록 보여주기
	List<MemberVO> selectPagingMember(Map<String, String> paraMap) throws SQLException;
	
	// 회원 하나의 상세정보를 담아오는 메소드 
	MemberVO memberOneDetailAction(String userid) throws SQLException;

}
