<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
									
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<c:if test="${totalCnt eq 0 }">
		<tr>
			<td colspan="6">제품이  존재하지 않습니다.</td>
		</tr>
	</c:if>
	
	<c:if test="${totalCnt > 0 }">
			 <c:forEach items="${productInfoList}" var="list">
			 <tr onclick="javascript:pdModalOpen();"> 
				<td>${list.model_code}</td>
				<td>${list.model_name}</td>
				<td>${list.pd_code}</td>
				<td>${list.pd_name}</td>
				<td>${list.pd_corp}</td>
				<td>
				   <fmt:formatNumber value="${list.pd_price}" pattern="#,###,###,###"></fmt:formatNumber>
				</td>
				<td>${list.name}</td>				
			</tr> 
			</c:forEach>				
		</c:if>
		
<input type="hidden" id="totalCnt" value="${totalCnt}"> 