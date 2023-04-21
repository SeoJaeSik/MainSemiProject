package common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ErrorController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// super.setRedirect(false); // forward 방식
		super.setViewPage("/WEB-INF/error/error.jsp");
		
	}

}
