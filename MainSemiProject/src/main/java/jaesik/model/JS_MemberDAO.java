package jaesik.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

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

	
	// 입력받은 이메일로 가입된 유저로 존재하는지 알아오는 메소드 존재하면 해당 id를 리턴
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

	
	// 가입된 유저이므로 해당 유저에게 발급된 쿠폰번호와 같은 쿠폰번호를 쿠폰테이블에 insert
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

	
	
	// 해당 유저가 존재하는지 알아오는 메소드
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
	
	
	// 고객센터로 보낸 메시지를 board 테이블에 insert
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
}




