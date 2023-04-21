package common.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.SendResult;

import myshop.model.ImageVO;
import myshop.model.InterProductDAO;
import myshop.model.ProductDAO;

public class IndexController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

			super.setRedirect(false);
			super.setViewPage(request.getContextPath()+"/WEB-INF/jaesik/index.jsp");
		}
		// 익셉션 처리를 해주지 않으면 http 500 과같은 에러페이지를 유저가 볼 수 있다.
		// 이를 바탕으로 해킹시도가 있을 수 있기 때문에 반드시 익셉션처리를 해줘야 한다.
	

}
