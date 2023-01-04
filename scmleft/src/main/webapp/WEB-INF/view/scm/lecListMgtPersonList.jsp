<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
			<c:if test="${totalCntAdmsmtLecPersonList eq 0 }">
				<tr>
					<td colspan="4">정보가 없습니다.</td>
				</tr>
			</c:if>
	 		
			<c:if test="${totalCntAdmsmtLecPersonList > 0 }">
				<c:set var="nRow" value="${pageSize*(currentPageComnDtlCod-1)}" />
				<c:forEach items="${admsmtLecPersonListMgtModel}" var="list">
					<tr>
						<td>${list.model_code}</td>
						<td>${list.pd_name}</td>
						<td>${list.input}</td>
						<td>${list.output}</td>							
					</tr>
					<c:set var="nRow" value="${nRow + 1}" />
				</c:forEach>
			</c:if>
							
		<input type="hidden" id="totalCntComnDtlCod" name="totalCntComnDtlCod" value ="${totalCntAdmsmtLecPersonList}"/>