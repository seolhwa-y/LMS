<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
					
					<c:if test="$modalTotalCnt">
						<tr>
						 <td colspan="7">발주내역이 존재하지 않습니다.</td>
						</tr>
					</c:if>
					
					<c:if test="${modalTotalCnt > 0}">
						<c:set var="nRow" value="${pageSize*(currentPageModal-1) }">
							<c:forEach items="${modalOrdDtlList}" var="list">
								<tr style="text-align : center">
									<td></td>
								</tr>
							</c:forEach>
						</c:set>
					</c:if>