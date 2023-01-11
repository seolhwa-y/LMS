<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${productList eq 0 }">
	<tr>
		<td colspan="3">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>
<c:if test="${productList > 0 }">
	<c:forEach items="${productTBody}" var="list">
		<tr>
			<td>${list.}</td>
			<td>${list.}</td>
			<td>${list.}</td>
			<td>${list.}</td>
			<td>${list.}</td>
			<td>${list.}</td>
		</tr>
		<%-- <input type="hidden" id="selectli_no" name="selectli_no" value ="${list.li_no}"/> --%>
	</c:forEach>
</c:if>

<input type="hidden" id="dtlListCnt" name="dtlListCnt" value="${searchlistcnt}" />
