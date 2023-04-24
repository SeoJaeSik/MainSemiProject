package shinjh.myshop.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ProductDAO implements InterProductDAO {
	
	private DataSource ds; // DataSource는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	
	// 사용한 자원을 반납하는 close() 메소드 생성하기
	private void close() {
		try {
			if(rs != null) {rs.close(); rs=null;}
			if(pstmt != null) {pstmt.close(); pstmt=null;}
			if(conn != null) {conn.close(); conn=null;}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 생성자
	public ProductDAO() {
		try {
		    Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/myoracle");
		} catch(NamingException e) {
			e.printStackTrace();
		}
	}
	
	
	// 메인페이지에 보여지는 상품이미지파일명을 모두 조회(select)하는 메소드
	@Override
	public List<ImageVO> imageSelectAll() throws SQLException {
		
		List<ImageVO> imgList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select imgno, imgfilename "
						+ " from tbl_main_image "
						+ " order by imgno asc ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				ImageVO imgvo = new ImageVO();
				imgvo.setImgno(rs.getInt(1));
				imgvo.setImgfilename(rs.getString(2));
				
				imgList.add(imgvo);
			}
			
		} finally {
			close();
		}
		
		return imgList;
	}

	
	// === Ajax(JSON)를 사용해 상품목록을 "더보기" 방식으로 페이징 처리 해주기 위해 스펙별로 제품의 전체갯수 알아오게하기	
	@Override
	public int totalPspecCount(String fk_snum) throws SQLException {
		
		int totalCount = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select count(*) "
						+ " from tbl_product "
						+ " where fk_snum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_snum);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalCount = rs.getInt(1);
			
		} finally {
			close();
		}
		
		return totalCount;
	}

	
	// Ajax(JSON)를 이용한 더보기 방식(페이징처리)으로 상품정보를 8개씩 잘라서(start ~ end) 조회해오기
	@Override
	public List<ProductVO> selectBySpecName(Map<String, String> paraMap) throws SQLException {
		
		List<ProductVO> prodList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select pnum, pname, code, pcompany, pimage1, pimage2, pqty, price, saleprice, sname, pcontent, point, pinputdate "
					+ " from  "
					+ " ( "
					+ "    select row_number() over(order by pnum desc) AS RNO "
					+ "         , pnum, pname, C.code, pcompany, pimage1, pimage2, pqty, price, saleprice, S.sname, pcontent, point "
					+ "         , to_char(pinputdate, 'yyyy-mm-dd hh24:mi:ss') as pinputdate "
					+ "    FROM tbl_product P "
					+ "    JOIN tbl_category C "
					+ "    ON P.fk_cnum = C.cnum "
					+ "    JOIN tbl_spec S "
					+ "    ON P.fk_snum = S.snum "
					+ "    where S.sname = ? "
					+ " ) V "
					+ " where RNO between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("sname"));
			pstmt.setString(2, paraMap.get("start"));
			pstmt.setString(3, paraMap.get("end"));
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductVO pvo = new ProductVO();
				pvo.setPnum(rs.getInt(1));			// 제품번호
				pvo.setPname(rs.getString(2));		// 제품명
				
				BuyerTypeVO categvo = new BuyerTypeVO();
				categvo.setCode(rs.getString(3)); 
				pvo.setCategvo(categvo); 				// 카테고리코드
				pvo.setPcompany(rs.getString(4));   	// 제조회사명
	            pvo.setPimage1(rs.getString(5));    	// 제품이미지1   이미지파일명
	            pvo.setPimage2(rs.getString(6));    	// 제품이미지2   이미지파일명
	            pvo.setPqty(rs.getInt(7));          	// 제품 재고량
	            pvo.setPrice(rs.getInt(8));         	// 제품 정가
	            pvo.setSaleprice(rs.getInt(9));			// 판매가(할인판매)
	            
	            ShoesCategoryVO spvo = new ShoesCategoryVO();
	            spvo.setSname(rs.getString(10));		// 스펙명
	            pvo.setSpvo(spvo);
	            
	            pvo.setPcontent(rs.getString(11));  	// 제품설명 
	            pvo.setPoint(rs.getInt(12));        	// 포인트 점수        
	            pvo.setPinputdate(rs.getString(13));	// 제품입고일자
	            
	            prodList.add(pvo);
			}// end of while----------------------------------------------------
			
		} finally {
			close();
		}
		
		return prodList;
	}// end of public List<ProductVO> selectBySpecName(Map<String, String> paraMap) throws SQLException-----------

	
	// tbl_category 테이블에서 카테고리 대분류 번호(cnum), 카테고리코드(code), 카테고리명(cname)을 조회해오기 
    // VO 를 사용하지 않고 Map 으로 처리해보겠습니다.
	@Override
	public List<HashMap<String, String>> getCategoryList() throws SQLException {

		List<HashMap<String, String>> categoryList = new ArrayList<>();
		
		try {
			conn = ds.getConnection(); // 본인의 오라클DB와 연동
			
			String sql = " select cnum, code, cname "
					+ " from tbl_category "
					+ " order by cnum asc ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs =pstmt.executeQuery();
			
			while (rs.next()) {
				
				HashMap<String, String> map = new HashMap<>();
				map.put("cnum", rs.getString(1));
				map.put("code", rs.getString(2));
				map.put("cname", rs.getString(3));
				
				categoryList.add(map); // categoryList에 map의 값을 넣어준다.
				
			}// end of while (rs.next())
			
			
		} finally {
			close();
		}
		
		
		return categoryList;
		
		
	}// end of public List<HashMap<String, String>> getCategoryList()——————————————————

	
	// 특정 카테고리에 속하는 제품들을 페이지바를 이용한 페이징 처리하여 조회(select)해오기
	@Override
	public List<ProductVO> selectProductByCategory(Map<String, String> paraMap) throws SQLException {
		
		
		List<ProductVO> prodList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			
			String sql = " select cname, sname, pnum, pname, pcompany, pimage1, pimage2, pqty, price, saleprice, pcontent, point, pinputdate "
					+ " from "
					+ " ( "
					+ "    select rownum AS RNO, cname, sname, pnum, pname, pcompany, pimage1, pimage2, pqty, price, saleprice, pcontent, point, pinputdate "
					+ "    from "
					+ "    ( "
					+ "        select C.cname, S.sname, pnum, pname, pcompany, pimage1, pimage2, pqty, price, saleprice, pcontent, point, pinputdate "
					+ "        from "
					+ "        (select pnum, pname, pcompany, pimage1, pimage2, pqty, price, saleprice, pcontent, point "
					+ "              , to_char(pinputdate, 'yyyy-mm-dd') as pinputdate, fk_cnum, fk_snum "
					+ "         from tbl_product "
					+ "         where fk_cnum = ? "
					+ "         order by pnum desc "
					+ "     ) P "
					+ "     JOIN tbl_category C "
					+ "     ON P.fk_cnum = C.cnum "
					+ "     JOIN tbl_spec S "
					+ "     ON P.fk_snum = S.snum "
					+ "    ) V "
					+ " ) T "
					+ " where T.RNO between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));		
			int sizePerPage = 10;
			
			pstmt.setString(1, paraMap.get("cnum"));
			
		/*
			 === 페이징 처리 공식 === WHERE RNO between (조회하고자하는 페이지번호 * 한페이지당 보여줄 행의개수) - (한페이지당
			 보여줄 행의개수 - 1) and (조회하고자하는 페이지번호 * 한페이지당 보여줄 행의개수);
		 */
			
			 pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
			 pstmt.setInt(3, (currentShowPageNo * sizePerPage));
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {

				ProductVO pvo = new ProductVO();
	             
	             pvo.setPnum(rs.getInt("pnum"));      // 제품번호
	             pvo.setPname(rs.getString("pname")); // 제품명
	             
	             BuyerTypeVO categvo = new BuyerTypeVO(); 
	             categvo.setCname(rs.getString("cname"));  // 카테고리명  
	             pvo.setCategvo(categvo);                  // 카테고리 

	             pvo.setPcompany(rs.getString("pcompany")); // 제조회사명
	             pvo.setPimage1(rs.getString("pimage1"));   // 제품이미지1   이미지파일명
	             pvo.setPimage2(rs.getString("pimage2"));   // 제품이미지2   이미지파일명
	             pvo.setPqty(rs.getInt("pqty"));            // 제품 재고량
	             pvo.setPrice(rs.getInt("price"));          // 제품 정가
	             pvo.setSaleprice(rs.getInt("saleprice"));  // 제품 판매가(할인해서 팔 것이므로)
	               
	             ShoesCategoryVO spvo = new ShoesCategoryVO(); 
	             spvo.setSname(rs.getString("sname")); // 스펙이름 
	             pvo.setSpvo(spvo); // 스펙 
	               
	             pvo.setPcontent(rs.getString("pcontent"));       // 제품설명 
	             pvo.setPoint(rs.getInt("point"));              // 포인트 점수        
	             pvo.setPinputdate(rs.getString("pinputdate")); // 제품입고일자                                             
	             
	             prodList.add(pvo);
	             
				}// end of while----------------------------------------------------
				
			} finally {
				close();
			}
			
			return prodList;
		
	}

	
	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 제품에 대한 총페이지 알아오기
	@Override
	public int getTotalPage(Map<String, String> paraMap) throws SQLException {
		
		int totalPage = 0;
	      
	      try {
	         conn = ds.getConnection();
	         String sql =  " select ceil(count(*)/10) "
	         			 + " from tbl_product "
	         			 + " where fk_cnum = ? ";
	         

	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, paraMap.get("cnum"));

	         rs = pstmt.executeQuery();
	         
	         rs.next(); // 무조건 존재하기 때문에 (count(*) 이기 때문)
	         
	         totalPage = rs.getInt(1);
	         
	      } finally {
	         close();
	      }
	      
	      return totalPage;
	      
	}

	
	@Override
	public boolean isExist_cnum(String cnum) throws SQLException {
		
		boolean isExists = false;
		
		try {
			conn = ds.getConnection(); // DBCP 에서 가지고 옴
			
			String sql = " select * "
					   + " from tbl_category "
					   + " where cnum = ? ";
			// 행이 있나 없나만 알아오면 된다.
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cnum);
			
			rs = pstmt.executeQuery();
			
			isExists = rs.next(); // .next()는 다음 행이 있는지 없는지 확인해준다. 행이 있으면 true 그 말은 즉 중복되는 아이디가 있다는 뜻이다.
					   // .next()는 다음 행이 있는지 없는지 확인해준다. 행이 없으면 false 그 말은 즉 사용가능한 유저아이디라는 뜻이다.
			
		} finally {
			close();
		}
		
		return isExists;	
		
	}

	
	
	// spec 목록을 조회해오기
   @Override
   public List<ShoesCategoryVO> selectSpecList() throws SQLException {
	  
	  List<ShoesCategoryVO> specList = new ArrayList<>(); 
	  
	  try {
		 conn = ds.getConnection();
		 
		 String sql = " select snum, sname "+
				   " from tbl_spec "+
				   " order by snum asc ";
			   
		 pstmt = conn.prepareStatement(sql);
		 
		 rs = pstmt.executeQuery();
		 
		 while(rs.next()) {
			
			ShoesCategoryVO spvo = new ShoesCategoryVO();
			spvo.setSnum(rs.getInt(1));
			spvo.setSname(rs.getString(2));
			
			specList.add(spvo);
			
		 }// end of while(rs.next()) ------------------------------------------------------
		 
	  }
	  finally {
		 close();
	  }
	  
	  return specList;
	  
   }// end of public List<SpecVO> selectSpecList() throws SQLException ----------------------

   
   // 제품번호 채번 해오기
	@Override
	public int getPnumOfProduct() throws SQLException {
		
		int pnum = 0;
		  
		  try {
			 conn = ds.getConnection();
			 
			 String sql = " select seq_tbl_product_pnum.nextval AS PNUM "+
					   " from dual ";
				   
			 pstmt = conn.prepareStatement(sql);
			 rs = pstmt.executeQuery();
			 
			 rs.next();
	         pnum = rs.getInt(1);
			 
		  }
		  finally {
			 close();
		  }
		  
		  return pnum;
	}// end of public int getPnumOfProduct() throws SQLException
	
	
	//tbl_product 테이블에 insert 하기
	@Override
	public int productInsert(ProductVO pvo) throws SQLException {
		int result = 0;
	    
	    try {
	       conn = ds.getConnection();
	       
	       String sql = " insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, prdmanual_systemFileName, prdmanual_orginFileName, pqty, price, saleprice, fk_snum, pcontent, point) " +  
	                  " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	       
	       pstmt = conn.prepareStatement(sql);
	       
	       pstmt.setInt(1, pvo.getPnum());
	       pstmt.setString(2, pvo.getPname());
	       pstmt.setInt(3, pvo.getFk_cnum());    
	       pstmt.setString(4, pvo.getPcompany()); 
	       pstmt.setString(5, pvo.getPimage1());    
	       pstmt.setString(6, pvo.getPimage2()); 
	       pstmt.setString(7, pvo.getPrdmanual_systemFileName());
	       pstmt.setString(8, pvo.getPrdmanual_orginFileName());
	       pstmt.setInt(9, pvo.getPqty()); 
	       pstmt.setInt(10, pvo.getPrice());
	       pstmt.setInt(11, pvo.getSaleprice());
	       pstmt.setInt(12, pvo.getFk_snum());
	       pstmt.setString(13, pvo.getPcontent());
	       pstmt.setInt(14, pvo.getPoint());
	          
	       result = pstmt.executeUpdate();
	       
	    } finally {
	       close();
	    }
	    
	    return result;
		
	}

	
	// tbl_product_imagefile 테이블에 제품의 추가이미지 파일명 insert 해주기
	@Override
	public int product_imagefile_Insert(int pnum, String attachFileName) throws SQLException {
	
		int result = 0;
	    
	    try {
	       conn = ds.getConnection();
	       
	       String sql = " insert into tbl_product_imagefile(imgfileno, fk_pnum, imgfilename) "+ 
	                  " values(seqImgfileno.nextval, ?, ?) ";
	       
	       pstmt = conn.prepareStatement(sql);
	       
	       pstmt.setInt(1, pnum);
	       pstmt.setString(2, attachFileName);
	       
	       result = pstmt.executeUpdate();
	       
	    } finally {
	       close();
	    }
	    
	    return result;
		
	}// end of public int product_imagefile_Insert(int pnum, String attachFileName)--------


	//제품번호를 가지고서 해당 제품의 정보를 조회해오기
	@Override
	public ProductVO selectOneProductByPnum(String pnum) throws SQLException {
	    ProductVO pvo = null;
	    
	    try {
	        conn = ds.getConnection(); 
	        
	        String sql = " select S.sname, pnum, pname, pcompany, price, saleprice, point, pqty, pcontent, pimage1, pimage2, prdmanual_systemFileName, nvl(prdmanual_orginFileName,'없음') AS prdmanual_orginFileName "+  
	                   " from "+
	                   " ( "+
	                   "  select fk_snum, pnum, pname, pcompany, price, saleprice, point, pqty, pcontent, pimage1, pimage2, prdmanual_systemFileName, prdmanual_orginFileName "+
	                   "  from tbl_product "+
	                   "  where pnum = ? "+
	                   " ) P JOIN tbl_spec S "+
	                   " ON P.fk_snum = S.snum ";
	        
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, pnum);
	        
	        rs = pstmt.executeQuery();
	        
	        if(rs.next()) {
	           
	           String sname = rs.getString(1);     // "HIT", "NEW", "BEST" 값을 가짐 
	           int    npnum = rs.getInt(2);        // 제품번호
	           String pname = rs.getString(3);     // 제품명
	           String pcompany = rs.getString(4);  // 제조회사명
	           int    price = rs.getInt(5);        // 제품 정가
	           int    saleprice = rs.getInt(6);    // 제품 판매가
	           int    point = rs.getInt(7);        // 포인트 점수
	           int    pqty = rs.getInt(8);         // 제품 재고량
	           String pcontent = rs.getString(9);  // 제품설명
	           String pimage1 = rs.getString(10);  // 제품이미지1
	           String pimage2 = rs.getString(11);  // 제품이미지2
	           String prdmanual_systemFileName = rs.getString(12); // 파일서버에 업로드되어지는 실제 제품설명서 파일명
	           String prdmanual_orginFileName = rs.getString(13);  // 웹클라이언트의 웹브라우저에서 파일을 업로드 할때 올리는 제품설명서 파일명 
	           
	           pvo = new ProductVO(); 
	           
	           ShoesCategoryVO spvo = new ShoesCategoryVO();
	           spvo.setSname(sname);
	           
	           pvo.setSpvo(spvo);
	           pvo.setPnum(npnum);
	           pvo.setPname(pname);
	           pvo.setPcompany(pcompany);
	           pvo.setPrice(price);
	           pvo.setSaleprice(saleprice);
	           pvo.setPoint(point);
	           pvo.setPqty(pqty);
	           pvo.setPcontent(pcontent);
	           pvo.setPimage1(pimage1);
	           pvo.setPimage2(pimage2);
	           pvo.setPrdmanual_systemFileName(prdmanual_systemFileName);
	           pvo.setPrdmanual_orginFileName(prdmanual_orginFileName);
	           
	        }// end of if-----------------------------
	        
	    } finally {
	       close();
	    }
	    
	    return pvo;      
	}


	//제품번호를 가지고 해당제품에 추가된 이미지 정보를 조회해오기
	@Override
	public List<String> getImagesByPnum(String pnum) throws SQLException {
		
		List<String> imgList = new ArrayList<>();
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select imgfilename "+
	                     " from tbl_product_imagefile "+
	                     " where fk_pnum = ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, pnum);
	         
	         rs = pstmt.executeQuery();
	         
	         while(rs.next()) {
	            String imgfilename = rs.getString(1); // 이미지파일명 
	            imgList.add(imgfilename); 
	         }
	         
	      } finally {
	         close();
	      }
	      
	      return imgList;
	      
	}// end of public List<String> getImagesByPnum(String pnum)---


}// end of public class ProductDAO implements InterProductDAO-----
