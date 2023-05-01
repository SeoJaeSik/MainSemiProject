package shinjh.myshop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import shinjh.myshop.model.*;

public class ProductAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String product_name = request.getParameter("product_name"); // 제품번호
		
		InterProductDAO pdao = new ProductDAO();
		
		// 제품이름을 가지고서 해당 제품의 정보를 조회해오기
		ProductVO pvo = pdao.selectOneProductByProduct_name(product_name);
		
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
			List<String> imgList = pdao.getImagesByProduct_name(product_name, pvo.getProduct_color());
			
			// 제품이름을 가지고 색상 이미지를 가져오기
			List<String> colorList = pdao.getColorByProduct_name(product_name);
			
			// 제품이름과 색상을 가지고 사이즈 선택지(사이즈, 재고수량)를 가져오기 
			List<Integer> sizeList = pdao.getSizeByProduct_size(product_name, pvo.getProduct_color());
			
			request.setAttribute("pvo", pvo);
			request.setAttribute("imgList", imgList); // 해당 제품의 추가된 이미지 정보
			request.setAttribute("colorList", colorList); // 해당 제품의 색상 이미지
			request.setAttribute("sizeList", sizeList); // 해당 제품의 사이즈 선택지
			
//			super.setRedirect(false);
			super.setViewPage("/WEB-INF/myshop/prodView.jsp");
		}

	}

}
