<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
									
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 자바스크립트 실행 시 -->
<%-- <c:if test="${totalCnt eq 0 }">
		<tr>
			<td colspan="6">제품이  존재하지 않습니다.</td>
		</tr>
	</c:if>
	
	<c:if test="${totalCnt > 0 }">
			 <c:forEach items="${productInfoList}" var="list">
			 <tr onclick="javascript:pdModalOpen('${list.modelCode}')"> 
				<td>${list.modelCode}</td>
				<td>${list.modelName}</td>
				<td>${list.pdCode}</td>
				<td>${list.pdName}</td>
				<td>${list.pdCorp}</td>
				<td>
				   <fmt:formatNumber value="${list.pdPrice}" pattern="#,###,###,###"></fmt:formatNumber>
				</td>
				<td>${list.name}</td>				
			</tr> 
			</c:forEach>				
		</c:if>
		
<input type="hidden" id="totalCnt" value="${totalCnt}">  --%>