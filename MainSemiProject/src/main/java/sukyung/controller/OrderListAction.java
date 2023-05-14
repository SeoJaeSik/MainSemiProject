package sukyung.controller;

import java.text.DecimalFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import sujin.model.MemberVO;
import sukyung.model.*;

public class OrderListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		if(super.checkLogin(request)) { // 로그인한 경우

			String order_no = request.getParameter("order_no");
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			String userid = request.getParameter("userid");
			
			if(loginuser.getUserid().equals(userid)) {
				// 로그인한 회원아이디와 GET 방식으로 넘어온 아이디가 같은지 확인
				
			// *** 1. 주문정보, 주문상세내역 정보 조회
				InterProductDAO pdao = new ProductDAO();
				
				// 주문번호(order_no) 를 이용하여 주문정보(주문테이블, 배송테이블) 조회(select)
				Map<String, String> orderMap = pdao.showOrderList(order_no);
				request.setAttribute("orderMap", orderMap);

				// 주문번호(order_no) 를 이용하여 주문상세내역 정보(주문상세테이블, 상품테이블) 조회(select)
				List<OrderDetailVO> orderDetailList = pdao.showOrderDetailList(order_no);
				request.setAttribute("orderDetailList", orderDetailList);
				
				String method = request.getMethod();

				if(!"POST".equalsIgnoreCase(method)) { // GET 방식일때

					// session 에 저장해놨던 주문정보, 배송정보 삭제
					session.removeAttribute("prodMap");
					session.removeAttribute("shipMap");

					super.setRedirect(false);
					super.setViewPage("/WEB-INF/sukyung/orderList.jsp");
				}

				else { // POST 방식 ==> 트랜잭션
					
				// *** 2. 주문완료 email 발송
					GoogleMail mail = new GoogleMail();
					
					StringBuilder sb = new StringBuilder();
					DecimalFormat df = new DecimalFormat("#,###");
					
					sb.append("<div style='background-color: #fefce7; padding-left:50px; padding: 30px; border-top: solid 3px gold; border-bottom: solid 3px gold;'> ");
					sb.append(" <table style='border-collapse: separate; border-spacing: 0 15px; margin: auto; width:90%;'> ");
					sb.append("	  <thead> ");
					sb.append("		<tr>");
					sb.append("		  <th colspan='5' style='padding: 10px; text-align: center;'>");
					sb.append("			<h1 style='text-align: center;'><a style='color:black; text-align:center; line-height:40px; font-size: 30px; font-weight: bold; text-decoration: none !important; text-underline: none;' href='http://localhost:9090/SemiProject_MOSACOYA/index.moc'>MOSACOYA</a></h1>");
					sb.append("		  </th>");
					sb.append("		</tr>");
					sb.append("		<tr> ");
					sb.append("   	  <th style='text-align: center;'>주문번호</th> ");
					sb.append("   	  <th style='text-align: center;'>주문날짜</th> ");
					sb.append("   	  <th colspan='3' style='text-align: center;'>배송정보</th> ");
					sb.append("   	  <th style='text-align: center;'>결제금액</th> ");
					sb.append("		</tr> ");
					sb.append("	  </thead> ");
					sb.append("	  <tbody> ");
					sb.append("		<tr> ");
					sb.append("   	  <td style='text-align: center;'><div style='margin-top: 25px;'>"+orderMap.get("order_no")+"</div></td> ");
					sb.append("   	  <td style='text-align: center;'><div style='margin-top: 25px;'>"+orderMap.get("orderdate")+"</div></td> ");
					sb.append("   	  <td colspan='3' style='font-size: 10pt; text-align: left; line-height: 25px;'> ");
					sb.append("   	  	<div><label style='width: 17%; text-align:right; margin-right: 5px;'>수령자성명 : </label>"+orderMap.get("delivery_name")+"</div> ");
					sb.append("   	  	<div><label style='width: 17%; text-align:right; margin-right: 5px;'>수령자연락처 : </label>"+orderMap.get("delivery_mobile")+"</div> ");
					sb.append("   	  	<div><label style='width: 17%; text-align:right; margin-right: 5px;'>수령자주소 : </label>"+orderMap.get("delivery_address")+"</div> ");
					sb.append("   	  </td> ");
					sb.append("   	  <td id='total_price' style='font-size: 12pt; font-weight: bold; text-align: center;'><div style='margin-top: 25px;'>"+df.format(Integer.parseInt(orderMap.get("total_price")))+"원</div></td> ");
					sb.append("		</tr> ");
					sb.append("		<tr> ");
					sb.append("   	  <td style='padding: 20px;'></td> ");
					sb.append("		</tr> ");
					sb.append("		<tr> ");
					sb.append("   	  <td colspan='5'> ");
					sb.append("   	  	<table style='width: 85%; margin: auto; border-collapse: separate; border-spacing: 0 15px; padding: 20px; background-color: #fff9e5; border: solid 1px #f2f2f2;'> ");
					sb.append("	  		  <thead> ");
					sb.append("				<tr>");
					sb.append("   	  			<th> </th> ");
					sb.append("   	  			<th colspan='2' style='text-align: center;'>주문상품/옵션</th> ");
					sb.append("   	  			<th style='text-align: center;'>주문수량</th> ");
					sb.append("   	  			<th style='text-align: center;'>주문금액</th> ");
					sb.append("				</tr> ");
					sb.append("	  		  </thead> ");
					sb.append("	  		  <tbody> ");
					for(int i=0; i<orderDetailList.size(); i++) {
						sb.append("			<tr> ");
						sb.append("	  			<td> </td> ");
						sb.append("	  			<td style='text-align: center;'><img style='border: solid 1px #f2f2f2;' src='"+orderDetailList.get(i).getPvo().getProduct_image()+"' width='150' /></td> ");
						sb.append("	  			<td style='text-align: left; font-size: 10pt;'> ");
						sb.append("	  			  <div style='margin-top: 25px;'> ");
						sb.append("	  			  <div>"+orderDetailList.get(i).getPvo().getProduct_name()+"</div> ");
						sb.append("	  			  <div>"+orderDetailList.get(i).getPvo().getProduct_color()+"<span>&nbsp;</span><span>"+orderDetailList.get(i).getPvo().getProduct_size()+"</span></div> ");
						sb.append("	  			</td> ");
						sb.append("	  			<td style='text-align: center;'><div style='margin-top: 25px;'>"+orderDetailList.get(i).getOrder_count()+" 개</div></td> ");
						sb.append("	  			<td style='font-size: 12pt; font-weight: bold; text-align:center;'><div style='margin-top: 25px;'>"+df.format(orderDetailList.get(i).getOrder_price())+"원</div></td> ");
						sb.append("			</tr> ");
					} // end of for
	
					sb.append("	  		  </tbody> ");
					sb.append("   	  	</table> ");
					sb.append("   	  </td> ");
					sb.append("		</tr> ");
					sb.append("	  </tbody> ");
					sb.append(" </table> ");
					sb.append("	<div style='width: 30%; margin: auto;'><a href='http://localhost:9090/MainSemiProject/member/myaccount.moc' style='display:block; border-radius: 5px; margin: auto; color:black; text-align:center; background-color:#fdd007; width:250px; padding: 10px; font-size: 13pt; font-weight: bold; text-decoration: none !important; text-underline: none;' >이전 주문내역 확인하기</a></div> ");
					sb.append("</div> ");
					
					String emailContents = sb.toString();
					mail.sendmail_OrderFinish(loginuser.getEmail(), loginuser.getName(), emailContents);

					boolean result = false;
					if(emailContents != null) {
						result = true;
					}
					
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("result", result);
					
					String json = jsonObj.toString();
					request.setAttribute("json", json);
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/sukyung/jsonview.jsp");
					
				} // end of POST
				
			} // end of if(loginuser.getUserid().equals(userid))

			else { // 로그인을 안한 경우
				super.setRedirect(true);
				super.setViewPage(request.getContextPath()+"/login/login.moc");
			}
			
		} // if(super.checkLogin(request)) 로그인한 경우

		else { // 로그인을 안한 경우
			super.setRedirect(true);
			super.setViewPage(request.getContextPath()+"/login/login.moc");
		}

	} // end of public void execute(HttpServletRequest request, HttpServletResponse response)

}
