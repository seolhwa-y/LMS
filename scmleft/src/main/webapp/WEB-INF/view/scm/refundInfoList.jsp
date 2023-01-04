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
			 <c:forEach items="${refundInfoList}" var="list">
			<tr onclick="javascript:rDtModal('${list.re_code}')">
				<td>${list.MODEL_NAME}</td>
				<td>${list.RE_DATE}</td>
				<td>${list.RE_AMT}</td>
				<td>${list.RE_PRICE}</td>
			</tr>
			 <c:set var="nRow" value="${nRow + 1}" /> 
			</c:forEach>				
		</c:if>
		
<input type="hidden" id="totalCnt" value="${totalCnt}"> 
<input type="hidden" id="re_code" value="${re_code}"> 
