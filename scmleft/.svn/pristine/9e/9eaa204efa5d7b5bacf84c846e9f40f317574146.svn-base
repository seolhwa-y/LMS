 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${refundConfirmMgtcnt eq 0 }">
								<tr>
									<td colspan="2">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:if test="${refundConfirmMgtcnt  > 0 }">
								<c:forEach items="${refundConfirmlist}" var="list">							
									<tr> 
										<td>${list.name}</td>
										<td>${list.PD_NAME}</td>
										<td>${list.JORD_DATE}</td>
										<td>${list.RE_DATE}</td>
										<td>${list.RE_AMT}</td>
										<td><fmt:formatNumber value="${list.PD_PRICE}" pattern="#,###,###"/> </td>
										<td><p><a href ="javascript:Sclick('${list.RE_CODE}','1' )" id="Sbtn"
										 class = "btnType blue" 
										 >
										<span style = "cursor : pointer">승 인</span></a></p>
										<br>
										<p><a class = "btnType blue" 
										onclick="javascript:Sclick('${list.RE_CODE}','2' )" id='Bbtn'>
										<span>반려</span></a></td></p>
										
									</tr>
								</c:forEach>	
							</c:if>
							
							<input type="hidden" id="refundConfirmMgtcnt" name="refundConfirmMgtcnt" value ="${refundConfirmMgtcnt}"/>
							<input type="hidden" id="loginID" name="loginID" value ="${loginID}"/>
							
		