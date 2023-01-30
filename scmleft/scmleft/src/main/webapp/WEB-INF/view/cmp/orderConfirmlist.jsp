 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${orderConfirmMgtcnt eq 0 }">
								<tr>
									<td colspan="2">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:if test="${orderConfirmMgtcnt  > 0 }">
								<c:forEach items="${orderConfirmlist}" var="list">							
									<tr> 
										<td>${list.company}</td>
										<td>${list.PD_NAME}</td>
										<td>${list.JORD_AMT}</td>
										<td><fmt:formatNumber value="${list.PD_PRICE}" pattern="#,###,###"/> </td>
										<td>${list.JORD_DATE}</td>
										<td><a href="javascript:Sclick" class="btnType blue" id="btnsuccess" name="btn"><span style = "cursor : pointer">승인</span></a></td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="refundConfirmMgtcnt" name="orderConfirmMgtcnt" value ="${orderConfirmMgtcnt}"/>
							<input type="hidden" id="loginID" name="loginID" value ="${loginID}"/>
							<input type="hidden" id=DIR_CODE name="DIR_CODE" value ="${DI.DIR_CODE}"/>
							
		