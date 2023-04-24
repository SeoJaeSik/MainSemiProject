package yunhwan.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ProductDAO implements InterProductDAO {

	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	// 사용한 자원을 반납하는 close() 메소드 생성하기
	private void close() {
		
		try {
			if(rs != null) 		{rs.close(); rs=null;}
			if(pstmt != null) 	{pstmt.close(); pstmt=null;}
			if(rs != null)	 	{rs.close(); rs=null;}
		}catch(SQLException e) {
				e.printStackTrace();
		}		
	}
		
	// 생성자
	public ProductDAO() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/myoracle"); // lookup("jdbc/myoracle") 은 배치서술자인 web.xml 의 <res-ref-name> 이고, servers 의 톰캣 안에 context.xml 에도 있는데 그것을 의미한다.
		} catch(NamingException e) {
			e.printStackTrace();
		}
	}// end of public ProductDAO()---------------------

	
	
	// (ALL)전체제품 목록 나타내기 + Ajax(JSON)를 사용하여 전체상품목록을 스크롤 방식으로 페이징 처리하기 위해 제품의 전체 개수 알아오기 //
	@Override
	public int totalAllProductCount(String string) throws SQLException {
		
		int totalCount = 0;
		
		try {
			conn = ds.getConnection(); // 본인의 오라클DB와 연동
			
			String sql = " select count(*) "
						+ " from tbl_product ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_no);
			
			rs =pstmt.executeQuery();
			
			rs.next();
			
			totalCount = rs.getInt(1);
				
		
		} finally {
			close();
		}
		
		
		return totalCount;
		
	}// end of public int totalAllProductCount(String string) throws SQLException---------------
	
	


	

	

}
