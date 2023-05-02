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
        
        if (category == null || category.trim().isEmpty()) {
            return;
        }

        Map<String, String> paraMap = new HashMap<>();
		paraMap.put("start", start);  
        paraMap.put("category", category);
        
        String end = String.valueOf( Integer.parseInt(start) + Integer.parseInt(len) - 1);
		paraMap.put("end", end);  

        JSONArray jsonArr = new JSONArray();

        List<ProductVO> productList = null;

        switch (category) {
            case "1":
                productList = pdao.selectProduct(paraMap);
                break;
            case "2":
                productList = pdao.selectAllRunningProduct(paraMap);
                break;
            case "3":
                productList = pdao.selectAllWalking(paraMap);
                break;
            case "4":
                productList = pdao.selectAllGolf(paraMap);
                break;
            case "5":
                productList = pdao.selectAllSandal(paraMap);
                break;
            case "6":
                productList = pdao.selectMenAll(paraMap);
                break;
            case "7":
                productList = pdao.selectMenRunning(paraMap);
                break;
            case "8":
                productList = pdao.selectMenWalking(paraMap);
                break;
            case "9":
                productList = pdao.selectMenGolf(paraMap);
                break;
            case "10":
                productList = pdao.selectMenSandal(paraMap);
                break;
            case "11":
                productList = pdao.selectWomenAll(paraMap);
                break;
            case "12":
                productList = pdao.selectWomenRunning(paraMap);
                break;
            case "13":
                productList = pdao.selectWomenWalking(paraMap);
                break;
            case "14":
                productList = pdao.selectWomenGolf(paraMap);
                break;
            case "15":
                productList = pdao.selectWomenSandal(paraMap);
                break;
            case "16":
                productList = pdao.selectKidAll(paraMap);
                break;
            case "17":
                productList = pdao.selectKidRunning(paraMap);
                break;
            case "18":
            	productList = pdao.selectKidsAqua(paraMap);
                break;
            case "19":
            	productList = pdao.selectKidSandals(paraMap);
                break;
            default :     
        }

        if (productList != null && !productList.isEmpty()) {
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

