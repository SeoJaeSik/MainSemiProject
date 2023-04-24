<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% String ctxPath = request.getContextPath(); %>  


<!-- 다음소스 가져오기 !-->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
	
	// -----5> ▷ "이메일 중복확인" 을 클릭했는지 여부를 알아오기 위한 용도 -----
	let b_flag_emailDuplicate_click = false; 

	// -----3> ▷ "우편번호 찾기" 를 클릭했는지 여부를 알아오기 위한 용도 -----
	let b_flag_zipcodeSearch_click = false; 

	// *[으앙]* 우편번호가 변경되었는지 여부를 알아오기 위한 용도로 쓰인다.
	let b_flag_zipcode_change = false; 
	
	// *[으앙]* 이메일이 변경되었는지 여부를 알아오기 위한 용도로 쓰인다.
	let b_flag_email_change = false; 
	
	
	$(document).ready(function(){
		
		$("span.error").hide();  // 처음에 경고문구 다 안 뜨게 숨겨놓고,
		$("input#name").focus(); // 성명 입력창에 포커스를 놓는다
		
	/*	$("input#name").bind("blur",function(){
			alert("확인용1: 포커스를 가졌다가 포커스를 잃어버렸군요.");
		});
	*/	
	/*	$("input#name").blur(function(){
			alert("확인용2: 포커스를 가졌다가 또 포커스를 잃어버렸군요. 으이고");
		});
	*/
	
		// == 1) 아이디가 name 인 것이 포커스를 잃어버렸을 경우 이벤트(blur) 처리
		$("input#name").blur( (e) => { /* e.target 대신 $(this) 쓰고 싶으면 화살표함수 쓰면 안된당 */
			
			if( $(e.target).val().trim() == "" ) {
				// 1-1 입력하지 않았거나 공백만 입력했을 경우 
				
				// 테이블의 모든 태그 중 input 태그를 선택해 비활성화 할지 말지선택 [true, false]
				$("table#tblMemberRegister :input").prop("disabled", true); /* => 태그로 못 쓴다는 뜻임 */
				$(e.target).prop("disabled", false);                        /* => 태그를 사용할 수 있음 */
				/*
					=== 선택자의 class 알아오기 : 선택자.attr('class') 또는 선택자.prop('class')	
					=== 선택자의 id 알아오기    : 선택자.attr('id') 또는 선택자.prop('id')
					=== 선택자의 name 알아오기  : 선택자.attr('name') 또는 선택자.prop('name')
					>>>> .prop() 와 .attr() 의 차이 <<<<            
			             .prop() ==> form 태그내에 사용되어지는 엘리먼트의 disabled, selected, checked 의 속성값 확인 또는 변경하는 경우에 사용함. 
			             .attr() ==> 그 나머지 엘리먼트의 속성값 확인 또는 변경하는 경우에 사용함.	
				*/
				
				/* $(e.target).next().show();  또는 */
				$(e.target).parent().find("span.error").show();
				$(e.target).focus();
			}
			else {
				// 1-2 공백만이 아닌 글자를 입력한 경우 
				$("table#tblMemberRegister :input").prop("disabled", false); /* => 태그로 못 쓴다는 뜻임 */
				
				/* $(e.target).next().hide();  또는 */
				$(e.target).parent().find("span.error").hide();
			}
			
		});//end of 1) $("input#name").blur()----------------------------
	
		
		
		// == 3) 아이디가 pwd 인 것이 포커스를 잃어버렸을 경우 이벤트(blur) 처리
		$("input#pwd").blur( (e) => { 
			
			// 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규식 2 => 좋음
			const regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
			
			const bool = regExp.test($(e.target).val()); /* 정규표현식에 맞으면 true, 아니면 false */
			if(bool == false) { 
				
				// 3-1 암호가 정규표현식이 맞는 경우 
				$("table#tblMemberRegister :input").prop("disabled", true); /* => 태그로 못 쓴다는 뜻임 */
				$(e.target).prop("disabled", false);                        /* => 태그를 사용할 수 있음 */
				
				/* $(e.target).next().show();  또는 */
				$(e.target).parent().find("span.error").show();
				$(e.target).focus();
			}
			else {
				
				// 3-2 암호가 정규표현식이 아닌 경우 
				$("table#tblMemberRegister :input").prop("disabled", false); /* => 태그로 못 쓴다는 뜻임 */
				
				/* $(e.target).next().hide();  또는 */
				$(e.target).parent().find("span.error").hide();
			}

		});//end of 3) $("input#pwd").blur()----------------------------
		
		
		// == 4) 아이디가 pwdcheck 인 것이 포커스를 잃어버렸을 경우 이벤트(blur) 처리
		$("input#pwdcheck").blur( (e) => { 
			
			if( $("input#pwd").val() != $("input#pwdcheck").val() ) {
				
				// 4-1 다른경우
				$("table#tblMemberRegister :input").prop("disabled", true); /* => 태그로 못 쓴다는 뜻임 */
				$(e.target).prop("disabled", false);                        /* => 태그를 사용할 수 있음 */
				$("input#pwd").prop("disabled", false);                     // 둘 다 살리고 포커스를 비밀번호에 주겠다
				
				/* $(e.target).next().show();  또는 */
				$(e.target).parent().find("span.error").show();
				$("input#pwd").focus();
			}
			else {
				
				// 4-2 같은경우 
				$("table#tblMemberRegister :input").prop("disabled", false); /* => 태그로 못 쓴다는 뜻임 */
				
				/* $(e.target).next().hide();  또는 */
				$(e.target).parent().find("span.error").hide();
			}
			
		});//end of 4) $("input#pwdcheck").blur()----------------------------
	
		
		// == 5) 아이디가 email 인 것이 포커스를 잃어버렸을 경우 이벤트(blur) 처리
		$("input#email").blur( (e) => { 
			
			// 이메일 체크 정규식 => 좋음
			const regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; 
			
			const bool = regExp.test($(e.target).val()); /* 정규표현식에 맞으면 true, 아니면 false */
			if(bool == false) { 
				
				// 5-1 이메일이 정규표현식이 맞는 경우 
				$("table#tblMemberRegister :input").prop("disabled", true); /* => 태그로 못 쓴다는 뜻임 */
				$(e.target).prop("disabled", false);                        /* => 태그를 사용할 수 있음 */
				
				/* $(e.target).next().show();  또는 */
				$(e.target).parent().find("span.error").show();
				$(e.target).focus();
			}
			else {
				
				// 5-2 이메일이 정규표현식이 아닌 경우 
				$("table#tblMemberRegister :input").prop("disabled", false); /* => 태그로 못 쓴다는 뜻임 */
				
				/* $(e.target).next().hide();  또는 */
				$(e.target).parent().find("span.error").hide();
			}

		});//end of 5) $("input#email").blur()----------------------------
		
		
		// == 6) 아이디가 hp2 인 것이 포커스를 잃어버렸을 경우 이벤트(blur) 처리
		$("input#hp2").blur( (e) => { 
			
			const regExp = /^[1-9][0-9]{2,3}$/i; /* 첫자리만 1-9 가, 그 뒤 최소2~최대3 는 0-9 가 들어올 수 있따 */ 
			
			const bool = regExp.test($(e.target).val()); /* 정규표현식에 맞으면 true, 아니면 false */
			if(bool == false) { 
				
				// 6-1 가운데 전화번호 3-4자리가 정규표현식이 맞는 경우 
				$("table#tblMemberRegister :input").prop("disabled", true); /* => 태그로 못 쓴다는 뜻임 */
				$(e.target).prop("disabled", false);                        /* => 태그를 사용할 수 있음 */
				
				/* $(e.target).next().show();  또는 */
				$(e.target).parent().find("span.error").show();
				$(e.target).focus();
			}
			else {
				
				// 6-2 가운데 전화번호 3-4자리가 정규표현식이 아닌 경우 
				$("table#tblMemberRegister :input").prop("disabled", false); /* => 태그로 못 쓴다는 뜻임 */
				
				/* $(e.target).next().hide();  또는 */
				$(e.target).parent().find("span.error").hide();
			}

		});//end of 6) $("input#hp2").blur()----------------------------
		
		
		// == 7) 아이디가 hp3 인 것이 포커스를 잃어버렸을 경우 이벤트(blur) 처리
		$("input#hp3").blur( (e) => { 
			
		//	const regExp = /^[0-9]{4}$/g; /* 숫자 4자리만 들어옴 */ 
		//  또는
			const regExp = /^\d{4}$/g;
			
			const bool = regExp.test($(e.target).val()); /* 정규표현식에 맞으면 true, 아니면 false */
			if(bool == false) { 
				
				// 7-1 마지막 전화번호 4자리가 정규표현식이 맞는 경우 
				$("table#tblMemberRegister :input").prop("disabled", true); /* => 태그로 못 쓴다는 뜻임 */
				$(e.target).prop("disabled", false);                        /* => 태그를 사용할 수 있음 */
				
				/* $(e.target).next().show();  또는 */
				$(e.target).parent().find("span.error").show();
				$(e.target).focus();
			}
			else {
				
				// 7-2 마지막 전화번호 4자리가 정규표현식이 아닌 경우 
				$("table#tblMemberRegister :input").prop("disabled", false); /* => 태그로 못 쓴다는 뜻임 */
				
				/* $(e.target).next().hide();  또는 */
				$(e.target).parent().find("span.error").hide();
			}

		});//end of 7) $("input#hp3").blur()----------------------------
		
		
		// == 8) 우편번호 찾기 버튼 클릭하면 우편번호찾기를 실행하는 함수를 다음에서 가져와 복붙한다!!!
		$("img#zipcodeSearch").click(function(){ 
		
			new daum.Postcode({
		        oncomplete: function(data) {
		        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

					// 각 주소의 노출 규칙에 따라 주소를 조합한다.
		            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		            let addr = ''; // 주소 변수
		            let extraAddr = ''; // 참고항목 변수

		            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                addr = data.roadAddress;
		            } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                addr = data.jibunAddress;
		            }

		            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
		            if(data.userSelectedType === 'R'){
		                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                    extraAddr += data.bname;
		                }
		                // 건물명이 있고, 공동주택일 경우 추가한다.
		                if(data.buildingName !== '' && data.apartment === 'Y'){
		                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                }
		                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                if(extraAddr !== ''){
		                    extraAddr = ' (' + extraAddr + ')';
		                }
		                // 조합된 참고항목을 해당 필드에 넣는다.
		                document.getElementById("extraAddress").value = extraAddr;
		            
		            } else {
		                document.getElementById("extraAddress").value = '';
		            }

		            // 우편번호와 주소 정보를 해당 필드에 넣는다.
		            document.getElementById('postcode').value = data.zonecode;
		            document.getElementById("address").value = addr;
		            // 커서를 상세주소 필드로 이동한다.
		            document.getElementById("detailAddress").focus();
	        	}
	    	}).open();
			
		});//end of == 8) $("img#zipcodeSearch").click()----------------
		
		
		////////////////////////////////////////////////////////////////
		
		// 9) 성별
		// ~~~~~ 패스 ~~~~~
		
		// 10) 생년월일
		/* jQuery 에서는 `` 사용할 때 $ 를 잘 이해하지 못하므로 문자열결합으로만 하거나 $ 앞에 \ 를 써주면 된다 */
		
		// 10-1 생년월일 중 년도 를 보여주는 곳
		$("input#birthyyyy").keyup(function(e){
			alert("생년월일은 키보드로 입력하지 마시고 마우스로 선택하세요~");
			$(e.target).val("1950"); /* 1950 으로 디폴트값 잡혀짐 */
		});
		
		
		// 10-2 생년월일 중 월 을 보여주는 곳
		let mm_html ="";
		for(let i=1; i<13; i++) {
			
			if(i < 10) {
				mm_html += "<option value = '0" + i + "'>0" + i + "</option>";
			}
			else {
				mm_html += "<option value = '" + i + "'>" + i + "</option>";
			}
		}
	//	console.log(mm_html);
	
		$("select#birthmm").html(mm_html);
		
		
		// 10-3 생년월일 중 일에 값을 넣어주는 곳
		<%-- 주석 이렇게 안하니까 서버에서 오류가 나다말다해서 꼭 이렇게 써주기!
		// !!!! 중요 !!!!
	    // 확장자가 html 인 문서에서는 백틱 사용시 변수는 ${변수명} 으로 사용하면 된다.
	    // 그런데 확장자가 jsp 인 문서에서는 백틱 사용시 변수를 ${변수명} 으로 사용해 버리면
	    // request영역에 저장된 값을 불러들이는 ${requestScope.키값} 으로 인식해서 
	    // ${변수명}을 request 영역에 저장된 변수를 불러들이는 것으로 사용되어진다.
	    // 그래서 확장자가 jsp 인 문서에서는 백틱 사용시 $앞에 반드시 \를 붙여주어야 올바르게 동작한다.
		--%>
		let dd_html =``;
		for(let i=1; i<32; i++) {
			
			if(i < 10) {
				dd_html += `<option value = '0\${i}'>0\${i}</option>`;
			}
			else {
				dd_html += `<option value = '\${i}'>\${i}</option>`;
			}
		}
	//	console.log(dd_html);
	
		$("select#birthdd").html(dd_html);
		
		
		// -----------------------------------------
		// 아래는 로그인한 사용자의 생월,생일을 넣어주는 것이다.
		const birthday = "${sessionScope.loginuser.birthday}"; /* birthday = "19970510" */
		
		$("input#birthyyyy").val(birthday.substring(0,4));
		$("select#birthmm").val(birthday.substring(4,6)); 
		$("select#birthdd").val(birthday.substring(6));
		// -----------------------------------------		
		
        /////////////////////////////////////////////////////
        
        
        // == 13) "우편번호 찾기" 를 클릭했을 때 이벤트 처리하기
        // 3> "우편번호 찾기" 를 클릭했을 때 이벤트 처리하기 (false -> true 로 변경)
        $("img#zipcodeSearch").click(function(){
        	b_flag_zipcode_change = true; 
        	// *[으앙]* 우편번호가 변경되었는지 여부를 알아오기 위한 용도로 쓰인다.
        	
        	b_flag_zipcodeSearch_click = true;
        	// ▷ "우편번호 찾기" 를 클릭했는지 여부를 알아오기 위한 용도
        	
        });//end of 13)------------------------------------------------
        
        
        // 13-1) 우편번호 입력란에 키보드로 입력할 경우 막아주는 이벤트 처리하기
   //   $("input#postcode").bind("keyup", function(){}); => 이처럼 표현해도 되지만 유지보수 측면에서 아래처럼 데이터타입까지 보이게 표기하는 것이 좋다
        $("input:text[id='postcode']").keyup(function(){
        	
        	b_flag_zipcode_change = true; 
        	// *[으앙]* 우편번호가 변경되었는지 여부를 알아오기 위한 용도로 쓰인다.
        	
        	alert("우편번호 입력은 \" 우편번호찾기 \" 클릭으로만 됩니다."); /* 백틱써도됨 */
        	$(this).val("");
        	
        });
        
 		
     	// 15-1) 위에서 그치면 처음 중복확인만 누르면 그다음에도 중복된 email을 입력했음에도 확인을 안눌러도 가입하기로 넘어가므로
        // 수정 버튼을 클릭시 "email중복확인" 을 클릭했는지 알아보기 위한 용도로 무조건 email 값이 변경되면 초기화 시킨다!
        $("input#email").bind("change",function(){
          	
        	b_flag_email_change = true; // *[으앙]* 이메일이 변경되었는지 여부를 알아오기 위한 용도로 쓰인다.
			
        	b_flag_emailDuplicate_click = false;
			// email 에 입력한 이메일값이 변경되면 b_flag_emailDuplicate_click 을 false 로 초기화 해준다.
        });
        
        
	});//end of $(document).ready(function(){})----------------
	
	
	
	// =========== 함수선언 ===========
		
	// (2) 15) 위 "이메일 중복확인" 을 클릭했을 때 이벤트 처리하기 해주는 함수
	function isExistEmailCheck() {
		
		b_flag_emailDuplicate_click = true;
        // ▷5> "이메일 중복확인" 을 클릭했는지 여부를 알아오기 위한 용도
    	
    	// 입력하고자 하는 이메일이 DB 에 존재하는지 알아와야한다.
    	/*
            Ajax (Asynchronous JavaScript and XML)란?
          	==> 이름만 보면 알 수 있듯이 '비동기(순서X) 방식의 자바스크립트와 XML' 로서
                Asynchronou s JavaScript + XML 인 것이다.
                한마디로 말하면, Ajax 란? Client 와 Server 간에 XML 데이터를 JavaScript 를 사용하여 비동기 통신으로 주고 받는 기술이다.
                하지만 요즘에는 데이터 전송을 위한 데이터 포맷방법으로 XML 을 사용하기 보다는 JSON(Javascript Standard Object Notation) 을 더 많이 사용한다. 
                참고로 HTML은 데이터 표현을 위한 포맷방법이다.
                그리고, 비동기식이란 어떤 하나의 웹페이지에서 여러가지 서로 다른 다양한 일처리가 개별적으로 발생한다는 뜻으로서, 
                어떤 하나의 웹페이지에서 서버와 통신하는 그 일처리가 발생하는 동안 일처리가 마무리 되기전에 또 다른 작업을 할 수 있다는 의미이다.
        */ 
        // [방법1] : jQuery 를 사용한 Ajax
        // => dataType 이 "json" 인 경우
  	  	$.ajax({
        	
        	url:"<%= ctxPath%>/member/emailDuplicateCheck.up",
        	data:{"email":$("input#email").val()}, // -> 공백이 없으므로 email 이라고 "" 를 빼도 된다
			        	 /* data 는 url 로 전송해야할 데이터를 말한다. */
			        	 /* $("input#email").val() 를 url 로 보내기 위해 사용하는 key 값을 email 로 설정 */
        	type:"post", // type 을 생략하면 기본값이 get 이다 
        				 /* 여기 method 아니고 type 이다 주의! */
        	dataType:"json", // Javascript Standard Object Notation.  dataType은 url 로 부터 실행되어진 결과물을 받아오는 데이터타입을 말한다.
		                     // 만약에 dataType:"xml" 으로 해주면 url 로 부터 받아오는 결과물은 xml 형식이어야 한다. 
		                     // 만약에 dataType:"json" 으로 해주면 url 로 부터 받아오는 결과물은 json 형식이어야 한다.
        	async:true,  // async:true 는 비동기 방식을 말한다. async 를 생략하면 기본값이 비동기 방식인 async:true 이다.
                         // async:false 는 동기 방식을 말한다.(url 에 결과물을 받아올 때까지 그대로 대기하고 있는 것) 지도를 할 때는 반드시 동기방식인 async:false 를 사용해야만 지도가 올바르게 나온다.
        	success:function(json){  
        		// 파라미터 json 에 {"isExists":true} 또는 {"isExists":false} 이 들어오게 된다.	        		 
        	
        		if(json.isExists) {
        			// 입력한 email 이 이미 사용중이라면
        			
        			 const loginuser_email = "${sessionScope.loginuser.email}";
        			 if(loginuser_email == $("input#email").val()){
                         $("span#emailCheckResult").html("기존에 사용하던 email 인 " + $("input#email").val()+ " 을 유지합니다.").css("color","navy");
                     }
                     else {
                         $("span#emailCheckResult").html($("input#email").val()+" 은 중복된 email 이므로 사용불가 합니다.").css("color","red");
                         $("input#email").val("");
                     }
        			 
        		//	$("span#emailCheckResult").html($("input#email").val() + " 은 이미 사용중인 email 입니다.").css("color","red");
        		//	$("input#email").val(""); /* 중복됐다고 경고하면서 싹 비움 */
        		
        		}
        		else if(!json.isExists && $("input#email").val().trim() != ""){
        			// 입력한 email 이 존재하지 않는 경우라면
        			$("span#emailCheckResult").html($("input#email").val() + " 은 사용가능한 email 입니다.").css("color","blue");
        		}
        		
        	},
        	error:function(request, status, error){ // 어딘가 잘못된 부분이 발생하면 alert 를 띄운다
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
                         
        });// end of [방법1]-------------------- 	
      
    		
    };//end of (2)-------------------
		
		
	
	// (1) "수정" 버튼 클릭시 호출되는 함수
	function goEdit() {
		
		// ***** 필수입력사항에 모두 입력이 되었는지 검사한다. *****//
		let b_flag_requiredInfo = false;
		
		$("input.requiredInfo").each(function(index, elt){
			
			if( $(elt).val().trim() == "" ) {
				alert("*표시된 필수입력사항은 모두 입력하셔야 합니다.");
				b_flag_requiredInfo = true; /*  */
				return false; // for 에서 쓰는 break 와 동일
			}
		});
		
		if(b_flag_requiredInfo) {
			return; // 함수종료
		}
		// *********************************************//
			
		
		// 5> 이메일을 변경한 경우에만 "이메일 중복확인" 을 클릭했는지 여부 알아오기
		if( b_flag_emailDuplicate_click == false && b_flag_email_change == true) {
			/* 클릭안했을 때 */
			alert("이메일 중복확인 을 클릭해야 합니다.");
			return; // 함수종료
		}
		
	
		// 3> "우편번호 찾기" 를 클릭했는지 여부 알아오기
		if( b_flag_zipcodeSearch_click == false && b_flag_zipcode_change == true) {
			alert("우편번호 찾기 를 클릭해 우편번호를 입력하셔야 합니다.");
			return; // 함수종료
		}
		else {
			/* 우편번호 찾기를 클릭했을 때 */
			
			const regExp = /^\d{5}$/g; // 숫자 5자리만 들어오도록 검사해주는 정규표현식 객체 생성 (g는 뭐더라)
			
			const bool = regExp.test($("input:text[id='postcode']").val());
			
			if(bool == false) {
				alert("우편번호 형식에 맞지 않습니다.");
				$("input:text[id='postcode']").val(""); /* 틀린거 지우고, */
				b_flag_zipcodeSearch_click == false;    /* 클릭안한거랑 똑같이 false 로 변경 */
				return; // 함수종료
			}
			
			/* -- 주소 및 상세주소 입력에 대한 유효성 검사하기는 생략! 스스로 해보기! -- */
			/*
			
			~
			~
			~
			
			*/
			
		}
		
		// ==========================================================
		// ==> 위 경우처럼 뭔가 선택되지 않은 경우에는 아래로 넘어가지 않고 return 된다 
		
		
		////////////////////////////////////////
		
		// === 암호 변경 했는지를 알아주는 지표 ===
		let gogo = true;
		
		// === 현재 사용중인 암호로는 변경할 수 없다! ====
		$.ajax({
			url:"<%= ctxPath%>/member/duplicatePwdCheck.up",
			data:{"new_pwd":$("input#pwd").val(), "userid":"${sessionScope.loginuser.userid}"},
			type:"post",
			dataType:"json",
			async: false, /* !!! 동기방식 !!! => url 에서 결과를 받아올 때 까지 //// 아래 if 문으로 넘어가면 안된다 */
			success:function(json){
				// json => {"n":0} 또는 {"n":1}
				
				if(json.n == 1) {
					$("span#duplicate_pwd").html("현재 사용중인 암호로 변경은 불가합니다.");
					gogo = false;
					return;
				}
			},
        	error:function(request, status, error){ // 어딘가 잘못된 부분이 발생하면 alert 를 띄운다
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
			
		});
		
		////////////////////////////////////////
		
		if( gogo == true ) {
			const frm = document.editFrm;
			frm.action = "<%= ctxPath%>/member/memberEditEnd.up";
			frm.method = "post";
			frm.submit();
		}
		
	}//end of (1) goEdit()---------------------------
	
	
</script>

<div align="center">
<form name="editFrm">

   	<div id="head" align="center">
      	::: 회원수정 (<span style="font-size: 10pt; font-style: italic;"><span class="star">*</span>표시는 필수입력사항</span>) :::
   	</div>
   	
   	<table id="tblMemberUpdate">
      	<tr>
         	<td style="width: 20%; font-weight: bold;">성명&nbsp;<span class="star">*</span></td>
         	<td style="width: 80%; text-align: left;">
             	<input type="hidden" name="userid" value="${sessionScope.loginuser.userid}" readonly />
             	<input type="text" name="name" id="name" value="${sessionScope.loginuser.name}" class="requiredInfo" required /> 
            	<span class="error">성명은 필수입력 사항입니다.</span>
         	</td>
      	</tr>
      	<tr>
         	<td style="width: 20%; font-weight: bold;">비밀번호&nbsp;<span class="star">*</span></td>
         	<td style="width: 80%; text-align: left;"><input type="password" name="pwd" id="pwd" class="requiredInfo" required />
            	<span class="error">암호는 영문자,숫자,특수기호가 혼합된 8~15 글자로만 입력가능합니다.</span>
         		<span id="duplicate_pwd" style="color:red;"></span>
         	</td>
      	</tr>
      	<tr>
         	<td style="width: 20%; font-weight: bold;">비밀번호확인&nbsp;<span class="star">*</span></td>
         	<td style="width: 80%; text-align: left;"><input type="password" id="pwdcheck" class="requiredInfo" required /> 
            	<span class="error">암호가 일치하지 않습니다.</span>
         	</td>
      	</tr>
      	<tr>
         	<td style="width: 20%; font-weight: bold;">이메일&nbsp;<span class="star">*</span></td>
         	<td style="width: 80%; text-align: left;"><input type="text" name="email" id="email" value="${sessionScope.loginuser.email}" class="requiredInfo" required /> 
             	<span class="error">이메일 형식에 맞지 않습니다.</span>
              	<%-- ==== 퀴즈 시작 ==== --%>
                <span style="display: inline-block; width: 80px; height: 30px; border: solid 1px gray; border-radius: 5px; font-size: 8pt; text-align: center; margin-left: 10px; cursor: pointer;" onclick="isExistEmailCheck();">이메일중복확인</span> 
              	<span id="emailCheckResult"></span>
               	<%-- ==== 퀴즈 끝 ==== --%>
         	</td>
      	</tr>
      	<tr>
         	<td style="width: 20%; font-weight: bold;">연락처</td>
         	<td style="width: 80%; text-align: left;">
             	<input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp;
             	<input type="text" id="hp2" name="hp2" size="6" maxlength="4" value="${ fn:substring(sessionScope.loginuser.mobile, 3, 7) }" />&nbsp;-&nbsp;
             	<input type="text" id="hp3" name="hp3" size="6" maxlength="4" value="${ fn:substring(sessionScope.loginuser.mobile, 7, 11) }" />
             
           <%-- <input type="text" id="mobile" name="mobile" size="20" maxlength="20" value="${sessionScope.loginuser.mobile}" /> --%>  
             	<span class="error">휴대폰 형식이 아닙니다.</span>
         	</td>
      	</tr>
      	<tr>
         	<td style="width: 20%; font-weight: bold;">우편번호</td>
         	<td style="width: 80%; text-align: left;">
            	<input type="text" id="postcode" name="postcode" value="${sessionScope.loginuser.postcode}" size="6" maxlength="5" />&nbsp;&nbsp;
            	<!-- 우편번호 찾기 -->
            	<img id="zipcodeSearch" src="<%= ctxPath %>/images/b_zipcode.gif" style="vertical-align: middle;" />
            	<span class="error">우편번호 형식이 아닙니다.</span>
         	</td>
      	</tr>
      	<tr>
         	<td style="width: 20%; font-weight: bold;">주소</td>
         	<td style="width: 80%; text-align: left;">
            	<input type="text" id="address" name="address" value="${sessionScope.loginuser.address}" size="40" /><br/>
             	<input type="text" id="detailAddress" name="detailAddress" value="${sessionScope.loginuser.detailaddress}" size="40" />&nbsp;<input type="text" id="extraAddress" name="extraAddress" value="${sessionScope.loginuser.extraaddress}" size="40" /> 
             	<span class="error">주소를 입력하세요</span>
         	</td>
      	</tr>
      
        <%-- ==== 생년월일 시작 ==== --%>
      	<tr>
         	<td style="width: 20%; font-weight: bold;">생년월일</td>
         	<td style="width: 80%; text-align: left;">
            	<input type="number" id="birthyyyy" name="birthyyyy" min="1950" max="2050" step="1" style="width: 80px;" required />
            
            	<select id="birthmm" name="birthmm" style="margin-left: 2%; width: 60px; padding: 8px;"  >
            	</select> 
            
            	<select id="birthdd" name="birthdd" style="margin-left: 2%; width: 60px; padding: 8px;" >
            	</select> 
         	</td>
      	</tr>
      	<%-- ==== 생년월일 끝 ==== --%>      
      
      	<tr>
         	<td colspan="2" class="text-center">
         	<%-- 
            	<button type="button" class="btn btn-secondary btn-sm mt-3" id="btnUpdate"  onClick="goEdit();"><span style="font-size: 15pt;">수정</span></button>
            	<button type="button" class="btn btn-secondary btn-sm mt-3 ml-5" onClick="self.close()"><span style="font-size: 15pt;">취소</span></button>
         	--%>
            <%-- 또는 --%>            
            	<input type="button" class="btn btn-secondary btn-sm mt-3" id="btnUpdate" onClick="goEdit();" value="수정" style="font-size: 15pt;" />
            	<input type="button" class="btn btn-secondary btn-sm mt-3 ml-5" onClick="self.close()" value="취소" style="font-size: 15pt;" /> 
         	</td>
      	</tr>
   	</table>

</form>
</div>
