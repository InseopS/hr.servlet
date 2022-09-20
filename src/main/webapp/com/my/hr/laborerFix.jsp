<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8' %>
<%@ page import='java.time.format.DateTimeFormatter' %>
<%@ page import='java.time.*' %>
<%@ page import='com.my.hr.service.*' %>
<%@ page import='com.my.hr.domain.Laborer' %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%
	LaborerService laborerService = new LaborerServiceImpl();
	
	String laborerId = request.getParameter("laborerId");
	int id = Integer.parseInt(laborerId); 
	String laborerName = request.getParameter("laborerName");
	String hireDate = request.getParameter("hireDate");
	LocalDate date = LocalDate.parse(hireDate, DateTimeFormatter.ISO_DATE);
	
	Laborer laborer = new Laborer(id, laborerName, date);
	
	laborerService.fixLaborer(laborer);
%>