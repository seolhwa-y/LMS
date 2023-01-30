<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
		
		<!-- 갯수가 0인 경우  -->
		<c:if test="${totalCnt eq 0 }">
			<tr>
				<td colspan="6">반품지시서가 없습니다.</td>
			</tr>
		</c:if>
		
		
		<!-- 갯수가 있는 경우  -->
		<c:if test="${totalCnt > 0 }">	
			<c:set var="nRow" value="${pageSize*(currentPage-1)}" /> 
			 <c:forEach items="${returnDirList}" var="list">
			<tr>
				<td>${list.JORD_DATE}</td>
				<td>${list.COMPANY}</td>
				<td>${list.PD_NAME}</td>
				<td>${list.RE_AMT}</td>
				<td>
				<fmt:formatNumber value="${list.RETURN_PRICE}" pattern="#,###,###,###"></fmt:formatNumber>
				</td>
				
				<td>${list.loginID}</td>		
				<td>										
				<c:choose>
					<c:when test="${list.RE_TYPE == 0}">
					미승인
					</c:when>
					<c:when test="${list.RE_TYPE == 1}">
					승인
					</c:when>
					<c:otherwise>
					반려
					</c:otherwise>
				</c:choose>
				</td>
			</tr>
			 <c:set var="nRow" value="${nRow + 1}" /> 
			</c:forEach>				
		</c:if>
		
<input type="hidden" id="totalCnt" value="${totalCnt}"> 
