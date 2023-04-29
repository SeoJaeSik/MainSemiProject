<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- footer 시작 --%>
<footer id="footer" class="container-fluid px-0">
	<div id="footer_top">
		<div id="footer_top_container" class="container py-4 px-0">
			<div id="footer_title">JOIN THE<br>FAMILY</div>
			<div id="footer_content">Enjoy 10% off your first online purchase and<br>stay up to date on all things MOSCOT.</div>
			<div id="footer_email">
				<input id="footer_email_input" type="text" placeholder="Enter email">
				<div id="email_submit_button" onclick="goSubscribe()" class="button" >SUBSCRIBE</div>
				<span style="font-size: 10pt; color: white;">See our <a style="color: white; text-decoration: underline; letter-spacing: 1px;" href="https://privacy.moscot.com/">Privacy Policy</a></span>
			</div> 
		</div>
	</div>
	
	<div id="footer_center" style="overflow:hidden;">
		<div id="footer_center_container" class="row">
			<div id="footer_center_left" class="col-md-6 px-5 pt-4">
				<p id="foot_info"> 
					<a style="color:black; font-weight: bold; text-decoration-line: none;" href="https://www.nbkorea.com/support/terms.action?tabCode=PP">개인정보 처리방침</a> / 이용약관 / (주)이랜드월드패션사업부 <br>
					서울특별시 금천구 가산디지털1로 159 이랜드월드<br>
					온라인 고객센터 : 1566-0086<br>
					AS/오프라인 고객센터 : 080-999-0456<br>
					대표 이메일 : abcd1234@naver.com<br>
					호스팅 서비스 제공자 : (주)라드씨엔에스<br><br>
					대표이사 : 최운식   사업자등록번호 : 113-85-19030<br>
					통신판매업신고 : 금천구청 제 2005-01053<br>
					개인정보보호책임자 : 최운식 
				</p>
			</div>
			
			<div id="footer_center_right" class="col-md-6">
				<div id="foot_complain">
					<div id="complain_title">ASK A MOSCOT FRAME FIT SPECIALIST</div>
					<div id="complain_content">
						<p id="complain_content_p">
							Whether you're a MOSCOT collector or visiting for<br>
							the very first time, we're here to assist!
						</p>
						<div style="display: flex; justify-content: space-around;"class="space-around">
							<p>
								<a type="button" class="complain_menu" data-toggle="popover_complain" title="온라인 고객센터" data-placement="bottom" data-content="1566 - 0086" style="color: black; text-decoration: none;">
									<i class="fa-solid fa-phone fa-2xl mb-4" style="color: #000000;"></i>
									<span style="font-size: 8pt; letter-spacing: 1px; display:block;">(+82) MOSACOYA</span>
								</a> 
							</p>
							<p>
								<a type="button" class="complain_menu" data-toggle="popover_complain" title="메일 문의사항" data-placement="bottom" data-content="support@mosacoya.com" style="color: black; text-decoration: none;">
									<i class="fa-regular fa-envelope fa-2xl mb-4" style="color: #000000;"></i>
									<span style="font-size: 8pt; letter-spacing: 1px; display:block;">support@mosacoya.com</span>
								</a>
							</p>
							<p>
								<a type="button" data-toggle="modal" data-target="#exampleModal" class="complain_menu" style="color: black; text-decoration: none;">
									<i class="fa-regular fa-comment fa-2xl mb-4" style="color: #000000;"></i>
									<span style="font-size: 8pt; letter-spacing: 1px; display:block;">Chat With Us</span>
								</a>
							</p>
						</div>
					</div>
				</div>
			</div>
			
		</div>
	</div>
	
	<div id="footer_bottom">
		<div id="foot_social">
			<ul id="social_list">
				<li class="social_items"><a href="https://www.facebook.com/MOSCOT/" target="_blank"><i class="fa-brands fa-facebook-f fa-xl" style="color: #000000;"></i></a></li>
				<li class="social_items"><a href="https://www.tiktok.com/@moscotnyc" target="_blank"><i class="fa-brands fa-tiktok fa-xl" style="color: #000000;"></i></a></li>
				<li class="social_items"><a href="https://www.instagram.com/moscotnyc/" target="_blank"><i class="fa-brands fa-instagram fa-xl" style="color: #000000;"></i></a></li>
				<li class="social_items"><a href="https://www.youtube.com/user/moscotnyc" target="_blank"><i class="fa-brands fa-youtube fa-xl" style="color: #000000;"></i></a></li>
			</ul>
		</div>
	</div>
	<div id="footer_bottom2">
		<div id="foot_last">
			<ul id="foot_bottom_list">
				<li class="foot_bottom_list"><p>&copy; 2023 MOSACOYA</p></li>
				<li class="foot_bottom_list"><p>Made By</p></li>
				<li class="foot_bottom_list"><p>Oh Yun Hwan</p></li>
				<li class="foot_bottom_list"><p>Seo Su Kyung</p></li>
				<li class="foot_bottom_list"><p>Seo Jae Sik</p></li>
				<li class="foot_bottom_list"><p>Shin Jun Ha</p></li>
				<li class="foot_bottom_list"><p>Yong Su Jin</p></li>
			</ul>
		</div>
	</div>
	<div>
		<button type="button" data-toggle="modal" data-target="#complainModal" class="btn px-3 py-2" style="z-index:1; font-weight: 700; justify-content: center; align-items: center; display: flex; position: fixed; top: 90%; left: 89%; background-color: #fdd007; color: #645510; fill: #645510; border-radius: 999rem; border: none;">
			<span>
				<svg width="20" height="20" viewBox="0 0 20 20" aria-hidden="true" class="mr-2 mb-1"> 
					<path d="M11,12.3V13c0,0-1.8,0-2,0v-0.6c0-0.6,0.1-1.4,0.8-2.1c0.7-0.7,1.6-1.2,1.6-2.1c0-0.9-0.7-1.4-1.4-1.4 c-1.3,0-1.4,1.4-1.5,1.7H6.6C6.6,7.1,7.2,5,10,5c2.4,0,3.4,1.6,3.4,3C13.4,10.4,11,10.8,11,12.3z"></path>
					<circle cx="10" cy="15" r="1"></circle>
					<path d="M10,2c4.4,0,8,3.6,8,8s-3.6,8-8,8s-8-3.6-8-8S5.6,2,10,2 M10,0C4.5,0,0,4.5,0,10s4.5,10,10,10s10-4.5,10-10S15.5,0,10,0 L10,0z"></path>
				</svg>
			</span>
			<span>고객센터</span>
		</button>
	</div>
	<%-- 고객센터 Modal --%>
	<div class="modal fade" id="complainModal">
		<div class="modal-dialog">
			<div class="modal-content">
		      
				<!-- Modal header -->
				<div class="modal-header" style="background-color: #fdd007; text-align: center;">
					<h5 class="modal-title" style="margin-left: 40%;">LET'S CHAT!</h5> 
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<!-- Modal body -->
				<div class="modal-body" style="padding: 2rem;"> 
					We apologize we aren't online at the moment. Please leave us a message and we'll get back to you as soon as we can. Thanks!
					<form name="customer_content">
						<div class="mt-3">
							<p style="font-weight: 700; margin-bottom: 0.5rem;">아이디</p>
							<input id="userid" name="userid" type="text" size="20" style="border-radius: 4px; border: 1px solid rgb(216, 220, 222); width: 100%; padding: 10px;"/>
						</div>
						<div class="mt-3">
							<p style="font-weight: 700; margin-bottom: 0.5rem;">제목</p>
							<input id="board_title" name="board_title" size="50" type="text" style="border-radius: 4px; border: 1px solid rgb(216, 220, 222); width: 100%; padding: 10px;">
						</div>
						<div class="mt-3">
							<p style="font-weight: 700; margin-bottom: 0.5rem;">메시지</p>
							<textarea id="board_content" name="board_content" size="500" style="border-radius: 4px; border: 1px solid rgb(216, 220, 222); width: 100%; padding: 10px;" rows="5" cols="30"></textarea>
						</div>
					</form>
				</div>
				<!-- Modal footer -->
				<div class="modal-footer">
					<button onclick="send_message()" type="button" class="btn btn-dark">메시지 보내기</button>
				</div>
				
			</div>
		</div>
	</div>
	<%-- 고객센터 Modal  끝--%>
</footer>
<%-- footer 끝 --%> 

<form name="submit_email">
	<input type="hidden" name="email" />
</form>


</body>
</html>