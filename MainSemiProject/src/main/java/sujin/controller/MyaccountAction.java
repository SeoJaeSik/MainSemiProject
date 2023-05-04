package sujin.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import sujin.model.InterMemberDAO;
import sujin.model.MemberDAO;
import sujin.model.MemberVO;
import sujin.model.OrderDetailVO;
import sujin.model.OrderVO;
import jaesik.model.BoardVO;
import jaesik.model.JS_InterMemberDAO;
import jaesik.model.JS_MemberDAO;

public class MyaccountAction extends AbstractController {
   
	@Override
   	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
      
    //	System.out.println("loginuser 확인 : " + loginuser);
      
		if ( loginuser != null ) {
			// 로그인한 경우
    	  
			InterMemberDAO modrdao = new MemberDAO();
			
			// ==== 주문번호(order_no) 를 이용하여 주문정보(주문테이블, 배송테이블) 조회(select) ====
			List<OrderVO> ovolist = modrdao.selectMemberOrderNo(loginuser.getUserid());
			//	System.out.println("ovolist 확인 : " + ovolist);
		
			for(int i=0; i<ovolist.size(); i++) {
				ovolist.get(i); // 배열을 loginuser 객체에 설정
			}
	
			request.setAttribute("ovolist", ovolist);
			
			
			// ==== 주문번호(order_no) 를 이용하여 주문상세정보(주문테이블, 주문상세테이블, 제품테이블) 조회(select) ====
			List<OrderDetailVO> ovodetaillist = modrdao.selectOrderDetailList(loginuser.getUserid());
			
		//	System.out.println("ovodetaillist 확인 : " + ovodetaillist);
			
			for(int i=0; i<ovodetaillist.size(); i++) {
				ovodetaillist.get(i); // 배열을 loginuser 객체에 설정
			}
	
			request.setAttribute("ovodetaillist", ovodetaillist);
			
			   
			///////////////////////////////////////////
    	  
			String searchType = request.getParameter("searchType"); 
			String searchWord = request.getParameter("searchWord");
         
			if ( searchType == null ||
					( !"fk_userid".equals(searchType) && 
							!"board_title".equals(searchType) &&
							!"board_content".equals(searchType) )) {
				searchType = "";
			}
			if ( searchWord == null ||
					( searchWord != null && searchWord.trim().isEmpty()) ) {
				searchWord = "";
			}
         
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("searchType", searchType);
			paraMap.put("searchWord", searchWord);
         
			// 페이징 처리를 한 회원 또는 검색한 회원 목록 보여주기
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			// 사용자가 보고자하는 페이지바의 페이지 번호이다. 페이지에 처음 들어왔을 경우에는 null이다.
			// 그래서 null이라면 1페이지가 되어야 한다. (default 값)
			if ( currentShowPageNo == null ) {
				currentShowPageNo = "1";
			}

			try {
				Integer.parseInt(currentShowPageNo);
			} catch (NumberFormatException e) {
				currentShowPageNo = "1";
			}
			// get방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 문자를 입력하면 1페이지로 이동하게 막아준다.

			paraMap.put("currentShowPageNo", currentShowPageNo);
			// 조회하고자하는 페이지번호

			JS_InterMemberDAO mdao = new JS_MemberDAO();
			int totalPage = mdao.getBoardTotalPage(paraMap);

			if ( !(0 < Integer.parseInt(currentShowPageNo) && Integer.parseInt(currentShowPageNo) <= totalPage)) { 
				currentShowPageNo = "1";
				paraMap.put("currentShowPageNo", currentShowPageNo);
			}
         
			List <BoardVO> boardList = mdao.selectPagingBoard(paraMap);
         
			request.setAttribute("boardList", boardList);
			request.setAttribute("searchType", searchType);
			request.setAttribute("searchWord", searchWord);
         
         
			String pageBar = "";
			int blockSize = 10;
			// 블럭사이즈는 블럭당 보여지는 페이지 번호의 개수 10개씩
			int loop = 1;
			// 반복되어질 횟수로 1부터 증가하여 1개 블럭을 이루는 페이지 번호의 개수까지만 증가하는 용도
         
			int pageNo = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
			// 페이지 바에서 보여지는 첫번째 번호이다.
         
         
			// [맨처음][이전] 만들기
			if ( Integer.parseInt(currentShowPageNo) != 1 ){
				pageBar += "<li class='page-item'><a class='page-link bg-dark text-white' href='myaccount.moc?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1'>처음</a></li>"; 
			}
			if ( pageNo != 1) {
				pageBar += "<li class='page-item'><a class='page-link bg-dark text-white' href='myaccount.moc?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>이전</a></li>"; 
			}
         
         
			while( !(loop > blockSize || pageNo > totalPage) ) {
				if (pageNo == Integer.parseInt(currentShowPageNo) ) {
					pageBar += "<li class='page-item active'><a class='page-link bg-dark text-white' href='#'>"+pageNo+"</a></li>"; 
				}
				else {
					pageBar += "<li class='page-item'><a class='page-link bg-dark text-white' href='myaccount.moc?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
				}

				loop++; 	// 1 2 3 4 5 6 7 8 9 10
				pageNo++; 	//  1  2  3  4  5  6  7  8  9 10
                    		// 11 12 13 14 15 16 17 18 19 20
                    		// 21 22 23 24 25 26 27 28 29 30
			} // end while 
         
         
			// [다음][마지막] 만들기
			if ( pageNo <= totalPage ) {
				pageBar += "<li class='page-item'><a class='page-link bg-dark text-white' href='myaccount.moc?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>다음</a></li>"; 
			}
			if ( !(Integer.parseInt(currentShowPageNo) == totalPage) ){
				pageBar += "<li class='page-item'><a class='page-link bg-dark text-white' href='myaccount.moc?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'>끝</a></li>"; 
			}
         
			request.setAttribute("pageBar", pageBar);

			super.setRedirect(false);
			super.setViewPage("/WEB-INF/sujin/member/myaccount.jsp");
         
		}
		else {
			// 로그인을 안했을 경우
         
			String message = "비정상적인 접근입니다. 로그인 후 이용해주세요.";
			String loc = "javascript:history.back()";
         
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
      
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jaesik/msg.jsp");
      }
      
   }

}