package jaesik.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.controller.AbstractController;
import jaesik.model.JS_InterMemberDAO;
import jaesik.model.JS_MemberDAO;
import sujin.model.MemberVO;
import yunhwan.model.BuyerTypeVO;
import yunhwan.model.ProductVO;
import yunhwan.model.ShoesCategoryVO;

public class ProductRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if ( loginuser != null && loginuser.getAdmin() == 1 ) {
			// 관리자로만 로그인한 경우 일반유저와 로그아웃일때 url만 입력해서 들어오는 것을 막아야 한다.
			
			String method = request.getMethod();
			
			if( !"POST".equalsIgnoreCase(method) ) {

				// 카테고리 목록
				
				JS_InterMemberDAO pdao = new JS_MemberDAO();
				List<BuyerTypeVO> buyerType = pdao.selectBuyerTypeList();
				List<ShoesCategoryVO> categoryList = pdao.selectCategoryList();
				List<String> colorList = pdao.selectColorList();
				List<String> sizeList = pdao.selectSizeList();
				
				request.setAttribute("buyerType", buyerType);
				request.setAttribute("categoryList", categoryList);
				request.setAttribute("colorList", colorList);
				request.setAttribute("sizeList", sizeList);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/jaesik/productRegister.jsp");
			}
			else {
				// 제품 등록하러 가기

				MultipartRequest mtrequest = null;

				// 1. 첨부되어진 파일을 디스크의 어느 경로에 업로드 할 것인지 그 경로를 설정해야 한다.
				ServletContext svlCtx = session.getServletContext();
				String uploadFileDir = svlCtx.getRealPath("/images");
				
				// System.out.println("첨부되어지는 이미지 파일이 올라가는 절대경로 : "+uploadFileDir);
				// C:\NCS\workspace(jsp)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\MyMVC\images
				// 위의 경로는 서버의 운영경로이며 실제경로(개발경로)에서 운영경로는 자동적으로 연동이 되어있는데 운영경로에서 실제경로는 연동이 되어있지 않다.
			
			/*
	             MultipartRequest의 객체가 생성됨과 동시에 파일 업로드가 이루어 진다.
	                   
	             MultipartRequest(HttpServletRequest request,
	                              String saveDirectory, -- 파일이 저장될 경로
	                           	  int maxPostSize,      -- 업로드할 파일 1개의 최대 크기(byte)
	                              String encoding,
	                              FileRenamePolicy policy) -- 중복된 파일명이 올라갈 경우 파일명다음에 자동으로 숫자가 붙어서 올라간다.   
	                  
	             파일을 저장할 디렉토리를 지정할 수 있으며, 업로드제한 용량을 설정할 수 있다.(바이트단위). 
	             이때 업로드 제한 용량을 넘어서 업로드를 시도하면 IOException 발생된다. 
	             또한 국제화 지원을 위한 인코딩 방식을 지정할 수 있으며, 중복 파일 처리 인터페이스를사용할 수 있다.
	                        
	             이때 업로드 파일 크기의 최대크기를 초과하는 경우이라면 
	             IOException 이 발생된다.
	             그러므로 Exception 처리를 해주어야 한다.
	             
	        */
			
				// 파일을 업로드 해준다.
				try {
					mtrequest = new MultipartRequest(request, uploadFileDir, 10*1024*1024, "UTF-8", new DefaultFileRenamePolicy() );
				} catch (IOException e) {
					request.setAttribute("message", "업로드 되어질 경로가 잘못되었거나 또는 최대 용량 10MB가 초과되었으므로 파일업로드 실패");
					request.setAttribute("loc", request.getContextPath()+"/shop/admin/productRegister.moc");
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
					return;
				}
				
				// 첨부 이미지 파일, 제품설명서 파일을 올렸으니 그 다음으로 제품정보 (제품명, 정가, 제품수량, ...)를 DB의 tbl_product에 insert 한다
				
				// 새로운 제품 등록시 form 태그에서 입력한 값들을 얻어오기
				String buyer_type = mtrequest.getParameter("buyer_type");
				String shoes_category = mtrequest.getParameter("shoes_category");
				String product_name = mtrequest.getParameter("product_name");
				String product_color = mtrequest.getParameter("product_color");
				String product_size = mtrequest.getParameter("product_size");
				String product_date = mtrequest.getParameter("product_date");
				String stock_count = mtrequest.getParameter("stock_count");
				String product_price = mtrequest.getParameter("product_price");
				String product_content = mtrequest.getParameter("product_content");
				String product_image = mtrequest.getOriginalFileName("product_image");

				
				product_image = request.getContextPath()+"/images/"+product_image;
		
				JS_InterMemberDAO pdao = new JS_MemberDAO();
				int product_no = pdao.getProduct_no();
				
				ProductVO pvo = new ProductVO();
				
				String product_no_full = buyer_type+"_"+shoes_category+"_"+product_no;
				pvo.setProduct_no(buyer_type+"_"+shoes_category+"_"+product_no);
				pvo.setProduct_name(product_name);
				pvo.setFk_shoes_category_no(Integer.parseInt(shoes_category));
				pvo.setProduct_price(Integer.parseInt(product_price));
				pvo.setProduct_color(product_color);
				pvo.setProduct_size(Integer.parseInt(product_size));
				pvo.setProduct_image(product_image);
				pvo.setProduct_date(product_date);
				pvo.setProduct_content(product_content);
				pvo.setStock_count(Integer.parseInt(stock_count));
				
	            String message = "";
	            String loc = "";
	            
	            try {
	            	pdao.productInsert(pvo);
	            	// tbl_product 테이블에 insert
	            	
	            	
	            	// 추가이미지파일이 있다라면 tbl_product_imagefile (자식테이블) 테이블에 제품의 추가이미지 파일명 insert 해주기
	            	String str_attachCount = mtrequest.getParameter("attachCount"); 
	            	// str_attachCount 이 추가이미지 파일의 개수이다. "" "0" ~ "10" 이 들어온다.
	            	
	            	int attachCount = 0;
	            	
	            	if ( !"".equals(str_attachCount) ) {
	            		attachCount = Integer.parseInt(str_attachCount);
	            	}
	            	
	            	// 첨부파일의 파일명 (파일서버에 업로드 되어진 실제파일명) 알아오기
	            	for (int i=0; i<attachCount; i++) {
	            		String attachFileName = mtrequest.getOriginalFileName("attach"+i);
	            		attachFileName = request.getContextPath()+"/images/plusimage/"+attachFileName;
	            		pdao.product_imagefile_Insert(product_no_full, attachFileName);
	            		
	            	} // end for
	            	
	            	message = "제품등록 성공";
	            	loc = request.getContextPath()+"/shop/allproduct.moc";
	            	
	            } catch (SQLException e) {
	            	 e.printStackTrace();
	                 message = "제품등록 실패";
	                 loc = request.getContextPath()+"/shop/admin/productRegister.moc";
	            }
	            
	            request.setAttribute("message", message);
	            request.setAttribute("loc", loc);
				
	            super.setRedirect(false);
	            super.setViewPage("/WEB-INF/jaesik/msg.jsp");
				
			}
			
			
			
		}
		else {
			String message = "접근 불가합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jaesik/msg.jsp");
			
		}
		
	}

}
