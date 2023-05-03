package shinjh.myshop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import shinjh.myshop.model.*;

public class ProductAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 로그인 또는 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임. 
//	    super.goBackURL(request);
	    // 로그인을 하지 않은 상태에서 특정제품을 조회한 후 "장바구니 담기"나 "바로주문하기" 할때와 "제품후기쓰기" 를 할때 
	    // 로그인 하라는 메시지를 받은 후 로그인 하면 시작페이지로 가는 것이 아니라 방금 조회한 특정제품 페이지로 돌아가기 위한 것임.

		String product_name = request.getParameter("product_name"); // 제품이름
		String product_color = request.getParameter("product_color"); // 제품색상
		
		InterProductDAO pdao = new ProductDAO();
		
		ProductVO pvo;
		
		if(product_color != null) {
			
			// 제품이름과 색상을 가지고서 해당 제품의 정보를 조회해오기
			pvo = pdao.selectOneProduct(product_name, product_color);

		}
		else {
			
			// 제품이름을 가지고서 해당 제품의 정보를 조회해오기
			pvo = pdao.selectProductByName(product_name);
		}
		
		if(pvo == null) {
			// GET방식이므로 사용자가 웹브라우저 주소창에서 장난쳐서 존재하지 않는 제품번호를 입력한다.
			
			String message = "검색하신 제품은 존재하지 않습니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		else {
			// 제품이 있는 경우
			
			// 제품이름과 색상을 가지고 해당제품에 추가된 이미지 정보를 조회해오기
			List<String> imgList = pdao.getImages(product_name, pvo.getProduct_color());
			
			// 제품이름을 가지고 색상 이미지를 가져오기
			List<String> colorList = pdao.getColorByName(product_name);
			
			// 제품이름과 색상을 가지고 사이즈 선택지를 가져오기 
			List<Integer> sizeList = pdao.getSize(product_name, pvo.getProduct_color());
			
			request.setAttribute("pvo", pvo);
			request.setAttribute("imgList", imgList); // 해당 제품의 추가된 이미지 정보
			request.setAttribute("colorList", colorList); // 해당 제품의 색상 이미지
			request.setAttribute("sizeList", sizeList); // 해당 제품의 사이즈 선택지
			
//			super.setRedirect(false);
			super.setViewPage("/WEB-INF/shinjh/product.jsp");
		}

	}

}
