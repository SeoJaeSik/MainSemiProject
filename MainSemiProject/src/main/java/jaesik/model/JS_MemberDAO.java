package jaesik.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import sujin.model.MemberVO;

public class JS_MemberDAO implements JS_InterMemberDAO {
	
	private DataSource ds;
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private AES256 aes;
	
	private void close() {
		
		try {
			if (rs != null) {
				rs.close();
				rs = null;
			}
			if (pstmt != null) {
				pstmt.close();
				pstmt = null;
			}
			if (conn != null) {
				conn.close();
				conn = null;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public JS_MemberDAO () {
		try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/semi_oracle");
			
			aes = new AES256(SecretMyKey.KEY);
			// 양방향 암호화하는 인스턴스 생성 - SecretMyKey.KEY 만든 암호화/복호화 키이다.
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e ) {
			e.printStackTrace();
		}
		
	}

	
	// -------------------------------------- 입력받은 이메일로 가입된 유저로 존재하는지 알아오는 메소드 존재하면 해당 id를 리턴
	@Override
	public String isUserExistID (String email) throws SQLException {
		
		String isUserExistID = null;

		try {
			conn = ds.getConnection();
			
			String sql =  " select userid "
						+ " from tbl_member "
						+ " where status = 0 and idle = 0 and email = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, aes.encrypt(email) );
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				isUserExistID = rs.getString(1);
			}
			
			
		} catch (GeneralSecurityException | UnsupportedEncodingException e){
			e.printStackTrace();
		} finally {
			close();
		}
		
		return isUserExistID;
	}

	
	// ---------------------------- 가입된 유저이므로 해당 유저에게 발급된 쿠폰번호와 같은 쿠폰번호를 쿠폰테이블에 insert
	@Override
	public int sendCouponCode(String isUserExistID, String certificationCode) throws SQLException {

		int n = 0;
		
		try {
			conn = ds.getConnection();
			String sql = " insert into tbl_user_coupon (coupon_no, fk_userid, coupon_name, coupon_dis_percent)"+
						 " values ( ?, ?, '첫 온라인 구매 10% 할인쿠폰', 10 )";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, certificationCode);
			pstmt.setString(2, isUserExistID); 
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		return n;
	}

	
	// ----------------------------------------------  신규회원 쿠폰을 이미 지급 받은사람인지 체크하는 메소드 발급된 유저이면 true
	@Override
	public boolean isCouponExist(String isUserExistID) throws SQLException {
		
		boolean isCouponExist = false;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select fk_userid "+
						 " from TBL_USER_COUPON "+
						 " where coupon_no like '%NEW10' and fk_userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, isUserExistID);
			
			rs = pstmt.executeQuery();
			
			isCouponExist = rs.next();
			
		} finally {
			close();
		}
		
		return isCouponExist;
	}

	
	
	// ------------------------------------------------------------------------ 해당 유저가 존재하는지 알아오는 메소드
	@Override
	public boolean isUserExist(String userid) throws SQLException {

		boolean isUserExist = false;

		try {
			conn = ds.getConnection();
			
			String sql =  " select userid "
						+ " from tbl_member "
						+ " where status = 0 and idle = 0 and userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			
			isUserExist = rs.next();
			
			
		} finally {
			close();
		}
		
		return isUserExist;
	}
	
	
	// ----------------------------------------------------------------- 고객센터로 보낸 메시지를 board 테이블에 insert
	@Override
	public int uploadBoard(BoardVO bvo) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
			String sql = " insert into tbl_board (board_no, board_title, board_content, board_registerdate, fk_userid)"+
						 " values (seq_board_no.nextval, ? , ? , default, ? )";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bvo.getBoard_title());
			pstmt.setString(2, bvo.getBoard_content());
			pstmt.setString(3, bvo.getFk_userid());
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		return n;
	}

	// ------------------------------------------- 페이징 처리를 위한 검색이 있는 검색이 없는 전체회원에 대한 총 페이지 알아오기

	@Override
	public int getTotalPage(Map<String, String> paraMap) throws SQLException {

		int totalPage = 0;
		
		try {
			conn = ds.getConnection();
			
			
			String sql =  " select ceil (count(*) / 10 )"
						+ " from tbl_member "
						+ " where userid != 'admin' ";
			
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");
			
			if ( "email".equals(colname) ) {
				// 검색대상이 이메일인 경우 
				searchWord = aes.encrypt(searchWord);
			}
			
			if ( !"".equals(colname) && searchWord != null && !searchWord.trim().isEmpty() ) {
				sql += " and "+colname+" like '%'|| ? || '%' ";
			}
			// 컬럼명과 테이블명은 위치홀더로 사용하면 안된다. 위치홀더로 들어오는 것은 오직 데이터 값이어야 한다.
			
			pstmt = conn.prepareStatement(sql);
			if ( !"".equals(colname) && searchWord != null && !searchWord.trim().isEmpty() ) {
				pstmt.setString(1, searchWord);
			}
			
			rs = pstmt.executeQuery();
			
			rs.next();
			totalPage = rs.getInt(1);
		
			
		} catch ( GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return totalPage;

		
	}

	
	// ---------------------------------------- 타입과 단어, 페이징 갯수를 받아 페이징한 모든회원 또는 검색한 회원 목록 보여주기
	@Override
	public List<MemberVO> selectPagingMember(Map<String, String> paraMap) throws SQLException {
	
		List <MemberVO> memberList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql =  " SELECT userid, name, email, mobile, address"+
						  "  FROM "+
						  "  ("+
						  "   select rownum AS RNO, userid, name, email, mobile, address\n"+
						  "   from "+
						  "   	  ("+
						  "        select userid, name, email, mobile, address"+
						  "        from tbl_member"+
						  "        where userid != 'admin'";
			
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");
			
			if ( "email".equals(colname) ) {
				// 검색대상이 이메일인 경우 
				searchWord = aes.encrypt(searchWord);
			}
			
			if ( !"".equals(colname) && searchWord != null && !searchWord.trim().isEmpty() ) {
				sql += " and "+colname+" like '%'|| ? || '%' ";
			}
			// 컬럼명과 테이블명은 위치홀더로 사용하면 안된다. 위치홀더로 들어오는 것은 오직 데이터 값이어야 한다.
			
			sql += " order by registerday desc "
				 + "       ) V "
				 + " ) T "
				 + " WHERE RNO between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));  // 조회하고자하는 페이지번호
			
			
			// 페이징 처리 공식
			// WHERE RNO between (조회하고자하는 페이지번호 * 한페이지당 보여줄 행의개수) - (한페이지당 보여줄 행의개수 - 1) 
			// and (조회하고자하는 페이지번호 * 한페이지당 보여줄 행의개수);
			
			if ( !"".equals(colname) && searchWord != null && !searchWord.trim().isEmpty() ) {
				pstmt.setString(1, searchWord);
				pstmt.setInt(2, (currentShowPageNo * 10) - (10 - 1) );
				pstmt.setInt(3, (currentShowPageNo * 10) );
			}
			else {
				pstmt.setInt(1, (currentShowPageNo * 10) - (10 - 1) );
				pstmt.setInt(2, (currentShowPageNo * 10) );
			}
			
			rs = pstmt.executeQuery();
			
			while ( rs.next() ) {
				MemberVO member = new MemberVO();
				
				member.setUserid(rs.getString(1));
				member.setName(rs.getString(2));
				member.setEmail( aes.decrypt(rs.getString(3)) );
				member.setMobile( aes.decrypt(rs.getString(4)));
				member.setAddress( rs.getString(5));
								
				memberList.add(member);
			}
			
		} catch ( GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return memberList;
	}
}




