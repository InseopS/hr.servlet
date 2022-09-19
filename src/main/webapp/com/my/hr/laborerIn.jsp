<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8' %>
		if(isVal(${laborerName}) && isVal(${hireDate}) {
			let hireDate = Date.parse($('#hireDate').val())
<%
String laborerName = requst.${laborerName};
LocalDate hireDate = ${hireDate};
%>
 
<%
	laborerService.addLaborer();
%>
            laborers.push(laborer)
            listLaborers()
        }


