<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
						   
	<c:if test="${refundDtlListCnt eq 0 }">
		<tr>
			<td colspan="3">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
	<c:if test="${refundDtlListCnt > 0 }">
		<c:forEach items="${RefundBuyerDtlModel}" var="list">
			<tr>
				<td>${list.re_code}</td>
				<td>${list.model_code}</td>
				<td>${list.model_name}</td>
				<td>${list.pd_code}</td>
				<td>${list.pd_name}</td>
				<td>${list.pdcorp}</td>
				<td>${list.re_amt}</td>
				<td>${list.pd_price}원</td>
			</tr>
			<input type="hidden" id="dtl_re_code" name="dtl_re_code" value ="${list.re_code}"/> 
			<input type="hidden" id="wh_code" name="wh_code" value ="${list.wh_code}"/>
			<input type="hidden" id="model_code" name="model_code" value ="${list.model_code}"/>  
			<input type="hidden" id="re_amt" name="re_amt" value ="${list.re_amt}"/>
			<input type="hidden" id="re_date" name="re_date" value ="${list.re_date}"/> 
			<input type="hidden" id="loginID" name="loginID" value ="${list.loginID}"/> 
		</c:forEach>
	</c:if>
	
	<input type="hidden" id="refundDtlListCnt" name="refundDtlListCnt" value ="${refundDtlListCnt}"/> 
	