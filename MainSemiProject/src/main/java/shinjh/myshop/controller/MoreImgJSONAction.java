package shinjh.myshop.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import shinjh.myshop.model.*;

public class MoreImgJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String product_name = request.getParameter("product_name");
		String product_color = request.getParameter("product_color");
		
		InterProductDAO pdao = new ProductDAO();
		
		// 제품이름과 색상을 가지고서 해당 제품의 정보를 조회해오기
		ProductVO pvo = pdao.selectOneProduct(product_name, product_color);
		
		// 제품이름과 색상을 가지고 해당제품에 추가된 이미지 정보를 조회해오기
		List<String> imgList = pdao.getImages(product_name, product_color);
		
		// 이미지 가져와서 맨처음에 넣기
		imgList.add(0, pvo.getProduct_image());
		
		// 제품이름과 색상을 가지고 사이즈 선택지를 가져오기 
		List<Integer> sizeList = pdao.getSize(product_name, pvo.getProduct_color());
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("imgList", imgList);
		jsonObj.put("sizeList", sizeList);
		
		String json = jsonObj.toString();
		request.setAttribute("json", json);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/shinjh/jsonview.jsp");
	}
}
