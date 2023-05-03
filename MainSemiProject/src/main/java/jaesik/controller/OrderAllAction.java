package jaesik.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import jaesik.model.JS_InterMemberDAO;
import jaesik.model.JS_MemberDAO;
import sujin.model.MemberVO;

public class OrderAllAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if ( loginuser != null && loginuser.getAdmin() == 1 ) {
			
			JS_InterMemberDAO mdao = new JS_MemberDAO();
		
	    	int sizePerPage = 10;
	    	int totalPage = 0;
	         
	    	// 모든 사용자들이 주문한 갯수를 알아온다.
	    	int totalCountOrder = mdao.getTotalCountOrder();
	                  
	    	totalPage = (int) Math.ceil( (double)totalCountOrder/sizePerPage );
	                  //                       17.0/10 = 1.7‬ ==> 2.0  ==> 2
	                  //                       20.0/10 = 2.0 ==> 2.0  ==> 2 
	         
	    	// System.out.println("~~~ 확인용 totalPage : " + totalPage);
	                  
	        //   -- 조회하고자 하는 페이지번호를 받아와야 한다.
	        String str_currentShowPageNo = request.getParameter("currentShowPageNo"); 
	                  
	        int currentShowPageNo = 0;
	                  
	        try {
	        	if(str_currentShowPageNo == null) {
	        		currentShowPageNo = 1; 
	        	}
	        	else {
	        		currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
	                 
	        		if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
	                   currentShowPageNo = 1;
	                }
	        	}
	        } catch (NumberFormatException e) {
	        	currentShowPageNo = 1;
	        }
	                  
	        // 모든 사용자들의 주문내역을 페이징 처리하여 조회해온다.
	        List<HashMap<String, String>> orderList = mdao.getOrderList(currentShowPageNo, sizePerPage); 
	                        
	        //  -- 페이지바 만들기 
	        String url = "/member/admin/orderAll.moc";
	        int blockSize = 10;
	        //  blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 갯수이다.
	                  
	      //        1 2 3 4 5 6 7 8 9 10 [다음][마지막]                -- 1개 블럭
	      //  [처음][이전] 11 12 13 14 15 16 17 18 19 20 [다음][마지막]  -- 1개 블럭
	      //  [처음][이전] 21 22                                      -- 1개 블럭 
	         
	        int loop = 1;
	        // loop 는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 갯수(위의 설명상 지금은 10(==blockSize)까지만 증가하는 용도이다.
	         
	        int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1; 

	        String pageBar = "";
	         
	        // *** [맨처음][이전] 만들기 *** // 
	        if(pageNo != 1) {
	        	pageBar += "<li class='page-item'><a class='page-link' href='"+url+"?currentShowPageNo=1'>[처음]</a></li>";
	        	pageBar += "<li class='page-item'><a class='page-link' href='"+url+"?currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
	        }
	         
	        while( !(loop > blockSize || pageNo > totalPage) ) {
	            
	        	if(pageNo == currentShowPageNo) {
	        		pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>";  
	        	}
	            else {
	               pageBar += "<li class='page-item'><a class='page-link' href='"+url+"?currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
	            }
	            
	            loop++;
	            pageNo++;
	        }// end of while----------------------
	         
	        // *** [다음][마지막] 만들기 *** // 
	        if( pageNo <= totalPage ) {
	        	pageBar += "<li class='page-item'><a class='page-link' href='"+url+"?currentShowPageNo="+pageNo+"'>[다음]</a></li>";
	            pageBar += "<li class='page-item'><a class='page-link' href='"+url+"?currentShowPageNo="+totalPage+"'>[끝]</a></li>";
	        }
			
			
		}
		else {
			// 로그인을 안했거나 일반 사용자가 해당 url을 접속한 경우
			
			String message = "관리자만 접근이 가능합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
		
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jaesik/msg.jsp");
		}
		
	}

}
