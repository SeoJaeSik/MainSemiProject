/*
 * package jaesik.controller;
 * 
 * import java.util.HashMap; import java.util.Map; import java.util.Random;
 * 
 * import javax.servlet.http.HttpServletRequest; import
 * javax.servlet.http.HttpServletResponse; import
 * javax.servlet.http.HttpSession;
 * 
 * import common.controller.AbstractController; import
 * member.controller.GoogleMail; import member.model.InterMemberDAO; import
 * member.model.MemberDAO;
 * 
 * public class SubmitCouponAction extends AbstractController {
 * 
 * @Override public void execute(HttpServletRequest request, HttpServletResponse
 * response) throws Exception {
 * 
 * // 이메일 입력받아 해당이메일로 유저가 존재하면 쿠폰 일련번호를 발급. String userid =
 * request.getParameter("userid"); String email = request.getParameter("email");
 * 
 * InterMemberDAO mdao = new MemberDAO(); Map<String, String> paraMap = new
 * HashMap<>(); paraMap.put("userid", userid); paraMap.put("email", email);
 * 
 * boolean isUserExist = mdao.isUserExist(paraMap);
 * 
 * boolean sendMailSuccess = false; // 메일이 정상적으로 전송되었는지 유무를 알아오기 위한 용도
 * 
 * if (isUserExist) { // 회원으로 존재하는 경우 인증코드 메일보내기 실행
 * 
 * Random rnd = new Random(); String certificationCode = ""; // 인증코드는 영문소문자 5글자
 * + 숫자7글자
 * 
 * for (int i=0; i<5; i++) {
 * 
 * min 부터 max 사이의 값으로 랜덤한 정수를 얻으려면 int rndnum = rnd.nextInt(max - min + 1) +
 * min; 영문 소문자 'a' 부터 'z' 까지 랜덤하게 1개를 만든다.
 * 
 * char rndchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a'); certificationCode
 * += rndchar; }
 * 
 * for (int i=0; i<7; i++) { int rndnum = rnd.nextInt(9 - 0 + 1) + 0;
 * certificationCode += rndnum; }
 * 
 * // 랜덤하게 생성한 코드를 비밀번호 찾기를 하고자하는 사용자에게 전송 GoogleMail mail = new GoogleMail();
 * 
 * try { mail.sendmail(email, certificationCode); sendMailSuccess = true; //
 * 메일전송이 성공시 true
 * 
 * HttpSession session = request.getSession();
 * session.setAttribute("certificationCode", certificationCode); // 발급한 인증코드
 * session에 저장
 * 
 * } catch (Exception e) { // 메일전송이 실패한경우 System.out.println("메일 전송이 실패함");
 * e.printStackTrace(); }
 * 
 * }
 * 
 * request.setAttribute("isUserExist", isUserExist);
 * request.setAttribute("userid", userid); request.setAttribute("email", email);
 * request.setAttribute("sendMailSuccess", sendMailSuccess);
 * 
 * request.setAttribute("method", method);
 * 
 * super.setRedirect(false); super.setViewPage("/WEB-INF/login/pwdFind.jsp");
 * 
 * }
 * 
 * }
 */