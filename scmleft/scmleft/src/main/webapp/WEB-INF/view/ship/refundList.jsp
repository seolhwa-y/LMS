<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
						   
	<c:if test="${refundListCnt eq 0 }">
		<tr>
			<td colspan="3">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
	<c:if test="${refundListCnt > 0 }">
		<c:forEach items="${RefundBuyerModel}" var="list">
			<tr>
				<td><a href="javascript:fdtlList('${list.re_code}', '1')">${list.dir_code}</a></td>
				<td>${list.company}</td>
				<td>${list.sum}원</td>
				<td>${list.re_date}</td>
			</tr>
			<input type="hidden" id="loginID" name="loginID" value ="${list.loginID}"/>
		</c:forEach>
	</c:if>
	
	<input type="hidden" id="refundListCnt" name="refundListCnt" value ="${refundListCnt}"/> 