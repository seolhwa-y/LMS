<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						    
	<c:if test="${totalCntAdmsmtLecList eq 0 }">
		<tr>
			<td colspan="9">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
	 
	<c:if test="${totalCntAdmsmtLecList > 0 }">
		<c:set var="nRow" value="${pageSize*(currentPageComnGrpCod-1)}" />
		<c:forEach items="${WHInventoryFormModel}" var="list">
			<tr style="cursor:pointer" onClick="fListLecPersonList(1,'${list.model_code}','${list.wh_code}')">
				<td>${list.wh_code}</td>
				<td>${list.model_code}</td>
				<td>${list.wh_name}</td>
				<td>${list.pd_name}</td>
				<td>${list.wh_stock}</td>
				<td>${list.wh_addr}</td>
			</tr>
			<c:set var="nRow" value="${nRow + 1}" />
		</c:forEach>
	</c:if>
	
	<input type="hidden" id="totalCntComnGrpCod" name="totalCntComnGrpCod" value ="${totalCntAdmsmtLecList}"/>