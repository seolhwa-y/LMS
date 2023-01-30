<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
					

						    
						
							<c:if test="${totalCnt eq 0 }">
								<tr>
									<td colspan="7">배송지시서가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalCnt > 0 }">
								<c:forEach items="${deliveryBuyerList}" var="list">
									<tr onclick="javascript:deliveryModalOpen('${list.dir_code}')">								
										<td>${list.jord_code}</td>
										<td>${list.company}</td>
										<td>${list.jord_wishdate}</td>	
										<td>${list.name}</td>	
										<td>${list.wh_name}</td>
										<!-- 글자 색 다르게 주기 -->					
									    <c:if test="${list.sh_type == '배송완료'}"> 
											<td style="color: skyblue;font-weight: bold;">배송완료</td>
										</c:if>
										<c:if test="${list.sh_type == '배송중'}">
											<td style="color: green;font-weight: bold;">배송중</td>
										</c:if>
										<c:if test="${list.sh_type == '배송대기'}">
											<td style="color: red;font-weight: bold;">배송대기</td>
										</c:if>																												
									</tr>							
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalCnt" value="${totalCnt}"/>