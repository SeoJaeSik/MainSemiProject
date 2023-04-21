<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<jsp:include page="header.jsp"/>

<body>
 <div class="container mt-5 mx-auto bg-white">
	<form id="loginFrm" name="loginFrm">
		<table id="loginTbl">
	    	<thead>
	           <tr>
	               <th id="th" style="margin-bottom: 50px;">LOGIN</th>
	           </tr>
	        </thead>
	         
	        <tbody>
	           <tr>
	               <td>
		               <!-- <label class="text-input__label p2 is-active" > ID </label> -->
		               <input type="text" id="loginUserid" name="userid" size="30" class="box " autocomplete="off" placeholder = "ID" />
		           </td> <%-- autocomplete : 이전 입력했던 기록들 보여주기 --%>
	           </tr>   
	           <tr>
	               <td>
	               	   <!-- <label class="text-input__label p2 is-active" > Password </label> -->
	               	   <input type="password" id="loginPwd" name="pwd" size="30" class="box" placeholder = "PASSWORD"/>
	               </td>
	           </tr>
	           <tr>
	               <td colspan="2" align="center" style="padding: 10px;">
	               	   <input type="checkbox" id="saveid" name="saveid" /><label for="saveid"> &nbsp;id save </label><br>
	                   <button style="font-weight:bold;" size="30" type="button" id="btnSubmit" class="btn btn-warning">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CONTINUE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
	           	   </td>
	           </tr>
	      
	           <%-- === 아이디 찾기, 비밀번호 찾기 === --%>
	           <tr>
	               <td id="userid_pwd_find" class="p2" colspan="2" align="center">
	                   <a class="p2 underline" style="cursor: pointer;" >Forget your id?</a> 
	                   <a class="p2 underline" style="cursor: pointer;" >Forget your passward?</a> 
	                   <br>
	               	   "Don't have an account?" 
	               	   <a class="p2 underline" style="cursor: pointer;" href="#">Register now.</a>
	               </td>
	           </tr>
	            
	           
	        </tbody>
	    </table>
	</form>
</div>	 
</body>  
</html>

<jsp:include page="footer.jsp"/>