package jaesik.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import jaesik.model.JS_InterMemberDAO;
import jaesik.model.JS_MemberDAO;
import yunhwan.model.ProductVO;

public class SearchProductAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String buyer_type = request.getParameter("buyer_type");
		String search_word = request.getParameter("search_word");
		
		if ( buyer_type == null ||
		   ( !"100".equals(buyer_type) && 
			 !"200".equals(buyer_type) && 
			 !"300".equals(buyer_type) )) {
			buyer_type = "";
		}
		if ( search_word == null ||
		   ( search_word != null && search_word.trim().isEmpty()) ) {
			search_word = "";
		}

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("buyer_type", buyer_type);
		paraMap.put("search_word", search_word);
		
		JS_InterMemberDAO dao = new JS_MemberDAO();
		
		// 타입과 검색단어를 받아와 검색하는 메소드
		List<ProductVO> prodList = dao.selectSearchProduct(paraMap);
		
		request.setAttribute("prodList", prodList);
		request.setAttribute("search_word", search_word);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/jaesik/searchProduct.jsp");
		
	}

}
