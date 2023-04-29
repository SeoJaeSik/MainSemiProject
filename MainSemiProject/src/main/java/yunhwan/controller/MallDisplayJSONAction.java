package yunhwan.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import yunhwan.model.InterProductDAO;
import yunhwan.model.ProductDAO;
import yunhwan.model.ProductVO;

public class MallDisplayJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String start = request.getParameter("start");
		String len = request.getParameter("len"); // end 를 구하기 위해 가져온 것이다.
		
		InterProductDAO pdao = new ProductDAO();
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("start", start);  
		
		String end = String.valueOf( Integer.parseInt(start) + Integer.parseInt(len) - 1);
		paraMap.put("end", end);  
		
		//전체제품을 가져옴
		List<ProductVO> prodList = pdao.selectProduct(paraMap);
		// 전체제품 중 러닝화만 가져옴
		List<ProductVO> AllRunningProdList = pdao.selectAllRunningProduct(paraMap);
		
		JSONArray jsonArr = new JSONArray(); // []
		
		if( prodList.size() > 0 ) {
			// DB에서 조회해 온 결과물이 있을 경우
			
			for(ProductVO pvo : prodList) {
				
				JSONObject jsonObj = new JSONObject(); 						// {}
				jsonObj.put("product_no", pvo.getProduct_no()); 						// {"pnum":36, }
				jsonObj.put("product_name", pvo.getProduct_name());						// {"pname":36, "pname":"노트북30"}
				jsonObj.put("fk_shoes_category_no", pvo.getFk_shoes_category_no());			// {"pname":36, "pname":"노트북30", "code":"100000"}
				jsonObj.put("product_image", pvo.getProduct_image());					// {"pname":36, "pname":"노트북30", "code":"100000", "pcompany":"삼성전자"}
				jsonObj.put("stock_count", pvo.getStock_count());					// 생략
	            jsonObj.put("product_price", pvo.getProduct_price());
	            jsonObj.put("product_content", pvo.getProduct_content());
	            jsonObj.put("product_date", pvo.getProduct_date());
	            jsonObj.put("upload_date", pvo.getUpload_date());
	            jsonObj.put("product_color", pvo.getProduct_color());
	            jsonObj.put("product_size", pvo.getProduct_size());
	            jsonObj.put("sale_count", pvo.getSale_count());
				
	            jsonArr.put(jsonObj); 	// [{}]
	            						// [{},{}]
	            						// [{},{},{}]
			}// end of for--------------------
		
		}// end of if-------------------------

		
		String json = jsonArr.toString();			//  [ {},{},{}, ...... {} ]을 문자열로 변환하기
		// "[ {},{},{}, ...... {} ]"

		System.out.println("~~~ 확인용 json => " + json);			//  [ {},{},{}, ...... {} ]을 문자열로 변환하기
																// "[ {},{},{}, ...... {} ]"
		// DB에서 조회해온 결과가 있을경우
		// ~~~ 확인용 json => [{"pnum":36,"code":"100000","pname":"노트북30","pcompany":"삼성전자","saleprice":1000000,"discoutPercent":17,"point":60,"pinputdate":"2023-04-19 11:12:06","pimage1":"59.jpg","pqty":100,"pimage2":"60.jpg","pcontent":"30번 노트북","price":1200000,"sname":"HIT"},{"pnum":35,"code":"100000","pname":"노트북29","pcompany":"레노버","saleprice":1000000,"discoutPercent":17,"point":60,"pinputdate":"2023-04-19 11:12:06","pimage1":"57.jpg","pqty":100,"pimage2":"58.jpg","pcontent":"29번 노트북","price":1200000,"sname":"HIT"},{"pnum":34,"code":"100000","pname":"노트북28","pcompany":"아수스","saleprice":1000000,"discoutPercent":17,"point":60,"pinputdate":"2023-04-19 11:12:06","pimage1":"55.jpg","pqty":100,"pimage2":"56.jpg","pcontent":"28번 노트북","price":1200000,"sname":"HIT"},{"pnum":33,"code":"100000","pname":"노트북27","pcompany":"애플","saleprice":1000000,"discoutPercent":17,"point":60,"pinputdate":"2023-04-19 11:12:06","pimage1":"53.jpg","pqty":100,"pimage2":"54.jpg","pcontent":"27번 노트북","price":1200000,"sname":"HIT"},{"pnum":32,"code":"100000","pname":"노트북26","pcompany":"MSI","saleprice":1000000,"discoutPercent":17,"point":60,"pinputdate":"2023-04-19 11:12:06","pimage1":"51.jpg","pqty":100,"pimage2":"52.jpg","pcontent":"26번 노트북","price":1200000,"sname":"HIT"},{"pnum":31,"code":"100000","pname":"노트북25","pcompany":"삼성전자","saleprice":1000000,"discoutPercent":17,"point":60,"pinputdate":"2023-04-19 11:12:06","pimage1":"49.jpg","pqty":100,"pimage2":"50.jpg","pcontent":"25번 노트북","price":1200000,"sname":"HIT"},{"pnum":30,"code":"100000","pname":"노트북24","pcompany":"한성컴퓨터","saleprice":1000000,"discoutPercent":17,"point":60,"pinputdate":"2023-04-19 11:12:06","pimage1":"47.jpg","pqty":100,"pimage2":"48.jpg","pcontent":"24번 노트북","price":1200000,"sname":"HIT"},{"pnum":29,"code":"100000","pname":"노트북23","pcompany":"DELL","saleprice":1000000,"discoutPercent":17,"point":60,"pinputdate":"2023-04-19 11:12:06","pimage1":"45.jpg","pqty":100,"pimage2":"46.jpg","pcontent":"23번 노트북","price":1200000,"sname":"HIT"}]
		
		// ~~~ 확인용 json => []
		// 만약에 select된 정보가 없다면 [] 로 나오므로 null이 아닌 요소가 없는 빈 배열이다.
		
		request.setAttribute("json", json);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");

	}//end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception------------------------

}
