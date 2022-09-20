<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8' %>
<%@ page import='com.my.hr.service.*' %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%
	LaborerService laborerService = new LaborerServiceImpl();
	
	String laborerId = request.getParameter("laborerId");
	int id = Integer.parseInt(laborerId); 
	
	laborerService.delLaborer(id);
%>