package yunhwan.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import yunhwan.model.InterProductDAO;
import yunhwan.model.ProductDAO;

public class AllProductAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// (ALL)전체제품 목록 나타내기 + Ajax(JSON)를 사용하여 HIT 상품목록을 스크롤 방식으로 페이징 처리하여 보여줄 것이다. //
		InterProductDAO pdao = new ProductDAO();
		
	//	int totalALLCount = pdao.totalAllProductCount("1"); // HIT 상품의 전체개수를 알아온다.
		
		
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/yunhwan/AllProduct.jsp");
		
	}

}
