<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page import="megaboxClass.*" %>
<jsp:useBean id="memberDTO" class="megaboxClass.MemberDTO"/>
<jsp:setProperty property="*" name = "memberDTO"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	MemberDAO memberDAO = new MemberDAO();
	boolean result = memberDAO.selectMember(memberDTO);
	if(result){
		session.setAttribute("loginid", memberDTO.getUserid());
		System.out.println(session.getAttribute("loginid"));
%>
		<%-- <c:set var="loginid" value="${memberDTO.userid }" scope="session"/> --%>
		<c:redirect url="mainpage.jsp"/>
		
<%
	}else {
%>
		<script>
			alert("로그인 실패하였습니다.");
			history.back();
		</script>
<%
	}
%>