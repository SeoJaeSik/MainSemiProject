package common.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jaesik.model.JS_InterMemberDAO;
import jaesik.model.JS_MemberDAO;
import yunhwan.model.BuyerTypeVO;

public class IndexController extends AbstractController {

   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	   
	   
	   JS_InterMemberDAO pdao = new JS_MemberDAO();
	   List<BuyerTypeVO> buyerType = pdao.selectBuyerTypeList();
	   
	   request.setAttribute("buyerType", buyerType);
	   
	   super.setRedirect(false);
	   super.setViewPage("/WEB-INF/jaesik/index.jsp");
   }

}