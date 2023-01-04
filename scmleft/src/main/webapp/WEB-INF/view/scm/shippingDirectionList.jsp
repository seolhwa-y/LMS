<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
									
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<c:if test="${totalCnt eq 0 }">
		<tr>
			<td colspan="6">배송 지시서가  존재하지 않습니다.</td>
		</tr>
	</c:if>
	
	<c:if test="${totalCnt > 0 }">
			 <c:forEach items="${shippingDirectionList}" var="list">
			<tr onclick="javascript:shippingModalOpen('${list.dir_code}');">
				<td>${list.jord_code}</td>
				<td>${list.pd_name}</td>
				<td>${list.jord_date}</td>
				<td>${list.pd_corp}</td>
				<td>
				   <fmt:formatNumber value="${list.jord_amt}" pattern="#,###,###,###"></fmt:formatNumber>
				</td>
				<td>${list.jord_wishdate}</td>				
				<td> ${list.sh_type}</td>
			</tr>
			</c:forEach>				
		</c:if>
		
<input type="hidden" id="totalCnt" value="${totalCnt}"> 