<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
		
		<!-- 갯수가 0인 경우  -->
		<c:if test="${totalCnt eq 0 }">
			<tr>
				<td colspan="6">주문내역이 없습니다.</td>
			</tr>
		</c:if>

		<!-- 갯수가 있는 경우  -->
		<c:if test="${totalCnt > 0 }">	
			<c:set var="nRow" value="${pageSize*(currentPage-1)}" /> 
			 <c:forEach items="${listOrdDtManagement}" var="list">
			<tr>
				<td>${list.BORD_CODE}</td>
				<td>${list.loginID}</td>
				<td>${list.MODEL_NAME}</td>
				<td>${list.BORD_AMT}</td>
				<td>${list.BORD_DATE}</td>	
				<c:if test="${list.BORD_TYPE == 1}">
					<td>Y</td>
					<td>
				    	<a class="btnType3 color1" id="depositConfirm" href="javascript:confirmBtnClickEvent('${list.BORD_TYPE}', '${list.BORD_CODE}');"><span>확인</span></a>
					</td>
				</c:if>	
				<c:if test="${list.BORD_TYPE == 0}">
			    	<td>N</td>
				    <td style="color: skyblue;font-weight: bold;">확인</td>
				</c:if>		
					<c:if test="${list.BORD_TYPE == 2}">
			    	<td>미승인</td>
				<td style="color: skyblue;font-weight: bold;">반려</td>
				</c:if>						
								
			</tr>
			 <c:set var="nRow" value="${nRow + 1}" /> 
			</c:forEach>				
		</c:if>
		
<input type="hidden" id="totalCnt" value="${totalCnt}"> 
