<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="memberDTO" class="megaboxClass.MemberDTO"></jsp:useBean>

<jsp:setProperty property="*" name="memberDTO"/>
<jsp:useBean id="memberDAO" class="megaboxClass.MemberDAO"/>


<%
	boolean result = memberDAO.insertMember(memberDTO);

	if(result){
		
%>
		<script>
			alert("회원가입 되었습니다. 메인페이지로 이동합니다.");
			location.href="mainpage.jsp";
		</script>
<%
	}else{
%>
		<script>
			alert("회원가입에 실패했습니다.");
			location.href="megaMember.jsp";
		</script>
<%
	} 
%>
