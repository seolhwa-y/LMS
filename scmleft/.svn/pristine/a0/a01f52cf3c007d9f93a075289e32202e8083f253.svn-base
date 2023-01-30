<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
						   
	<c:if test="${transactionHistoryCnt eq 0 }">
		<tr>
			<td colspan="3">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
	<c:if test="${transactionHistoryCnt > 0 }">
		<c:forEach items="${SalesStatusModel}" var="list">
			<tr>
				<td><a href = "javascript:fListclick('${list.pd_corp}')">${list.pd_corp}</a></td>
				<td>${list.macul}</td>
			</tr>
			<%-- <input type="hidden" id="selectli_no" name="selectli_no" value ="${list.li_no}"/> --%>
		</c:forEach>
	</c:if>
	
	<input type="hidden" id="searchlistcnt" name="searchlistcnt" value ="${searchlistcnt}"/>