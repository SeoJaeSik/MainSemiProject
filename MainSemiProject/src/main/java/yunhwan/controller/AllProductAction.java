package yunhwan.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class AllProductAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 전체제품 목록 조회하기
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/yunhwan/AllProduct.jsp");
		
	}

}
