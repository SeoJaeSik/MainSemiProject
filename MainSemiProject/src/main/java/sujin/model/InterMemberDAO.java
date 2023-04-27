package sujin.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterMemberDAO {
	
	// 1. 회원가입을 해주는 메소드 (tbl_member 테이블에 insert)
	int registerMember(MemberVO member) throws SQLException;

	
	// 2. ID 중복검사 해주는 메소드 (tbl_member 테이블에서 userid 가 존재하면 true 를 리턴해주고, userid 가 존재하지 않으면 false 를 리턴한다.)
	boolean idDuplicateCheck(String userid) throws SQLException;

	
	// 3. email 중복검사 해주는 메소드 (tbl_member 테이블에서 email 가 존재하면 true 를 리턴해주고, email 가 존재하지 않으면 false 를 리턴한다.)
	boolean emailDuplicateCheck(String email) throws SQLException;

	
	// 4. 입력받은 paraMap 을 갖고 한명의 회원정보를 리턴시켜주는 메소드 (로그인처리) 
	MemberVO selectOneMember(Map<String, String> paraMap) throws SQLException;


	// 5. 아이디찾기 : 입력받은 paraMap 으로 성명&이메일을 입력받아 해당 사용자의 아이디를 알려주는 메소드
	String findUserid(Map<String, String> paraMap) throws SQLException;

	
	// 6. 비밀번호 찾기 : 입력한 paraMap 으로 아이디&이메일을 가진 회원이 존재하는지 알아보는 메소드
	boolean isUserExist(Map<String, String> paraMap) throws SQLException;

	
	// 7. 암호변경하기 : 입력한 paraMap 으로 들어온 아이디와 일치하는 회원의 암호를 변경해주는 메소드
	int pwdUpdate(Map<String, String> paraMap) throws SQLException;

	
	// 9. 회원의 개인정보 변경하기 메소드
	int updateMember(MemberVO member) throws SQLException;

	
	// 10. 암호 변경시 현재 사용중인 암호인지 아닌지 알아오는 메소드 
	int duplicatePwdCheck(Map<String, String> paraMap) throws SQLException;


	// 11. *** 페이징 처리를 안한 모든 회원 또는 검색한 회원 목록 보여주기 메소드
	List<MemberVO> selectMember(Map<String, String> paraMap) throws SQLException;


	// 12. *** 페이징 처리를 한 모든 회원 또는 검색한 회원 목록 보여주기 메소드
	List<MemberVO> selectPagingMember(Map<String, String> paraMap) throws SQLException;

	
	// 13. 페이징 처리를 위해 검색이 있거나 없는 전체 회원에 대한 총 페이지 수 알아오기 메소드
	int getTotalPage(Map<String, String> paraMap) throws SQLException;


	// 14. userid 값을 입력받아 회원 1명에 대한 상세정보를 알아오는 메소드 
	MemberVO memberOneDetail(String userid) throws SQLException;

}