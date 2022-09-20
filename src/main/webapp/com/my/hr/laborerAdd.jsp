<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8' %>
<%@ page import='java.time.format.DateTimeFormatter' %>
<%@ page import='java.time.*' %>
<%@ page import='com.my.hr.service.*' %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%
	LaborerService laborerService = new LaborerServiceImpl();
	
	String laborerName = request.getParameter("laborerName");
	String hireDate = request.getParameter("hireDate");
	LocalDate date = LocalDate.parse(hireDate, DateTimeFormatter.ISO_DATE);
	
	laborerService.addLaborer(laborerName, date);
%>