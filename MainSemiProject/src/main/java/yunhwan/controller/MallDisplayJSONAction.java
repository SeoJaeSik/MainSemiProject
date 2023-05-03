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
        String category = request.getParameter("category");

        System.out.println(category);
        
        InterProductDAO pdao = new ProductDAO();
        
        Map<String, String> paraMap = new HashMap<>();
		paraMap.put("start", start);  
        paraMap.put("category", category);
        
        String end = String.valueOf( Integer.parseInt(start) + Integer.parseInt(len) - 1);
		paraMap.put("end", end);  

        JSONArray jsonArr = new JSONArray();

        List<ProductVO> productList = pdao.selectProduct(paraMap);

        if (productList.size() > 0) {
            for (ProductVO pvo : productList) {
                JSONObject jsonObj = new JSONObject();
                jsonObj.put("product_no", pvo.getProduct_no());
                jsonObj.put("product_name", pvo.getProduct_name());
                jsonObj.put("fk_shoes_category_no", pvo.getFk_shoes_category_no());
                jsonObj.put("product_image", pvo.getProduct_image());
                jsonObj.put("stock_count", pvo.getStock_count());
                jsonObj.put("product_price", pvo.getProduct_price());
                jsonObj.put("product_content", pvo.getProduct_content());
                jsonObj.put("product_date", pvo.getProduct_date());
                jsonObj.put("upload_date", pvo.getUpload_date());
                jsonObj.put("product_color", pvo.getProduct_color());
                jsonObj.put("product_size", pvo.getProduct_size());
                jsonObj.put("sale_count", pvo.getSale_count());
                jsonArr.put(jsonObj);
            }
        }
        else {
			String message = "준비된 제품이 없습니다. 문의사항은 관리자에게 연락주십시오. 감사합니다.";
            String loc = "javascript:history.back()";
               
            request.setAttribute("message", message);
            request.setAttribute("loc", loc);
              
            super.setRedirect(false);   
            super.setViewPage("/WEB-INF/msg.jsp");
            
		}// end of else--------------------

        String json = jsonArr.toString();
        request.setAttribute("json", json);
        super.setRedirect(false);
        super.setViewPage("/WEB-INF/jsonview.jsp");
        
    }// end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception-----------------
}

