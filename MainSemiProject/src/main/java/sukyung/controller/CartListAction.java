package sukyung.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import sukyung.model.InterProductDAO;
import sukyung.model.ProductDAO;
import sukyung.model.ProductVO;

public class CartListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// tbl_cart 테이블에서 select
		String userid = "iyou1";
		
		InterProductDAO pdao = new ProductDAO();
		List<ProductVO> cartList = pdao.showCartList(userid);
		
		request.setAttribute("cartList", cartList);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/sukyung/cart.jsp");
		
	} // end of public void execute(HttpServletRequest request, HttpServletResponse response)

}
