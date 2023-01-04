<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 빌립담당 -->

			<c:set var="nRow" value="${pageSize*(currentPage-1)}" />
			<c:forEach items="${listUser}" var="list">
				<tr>
					<td>${list.user_type}
					<c:set var = "company_name" value ="${list.company}"/>
					</td>
					<td>${list.loginID}</td>
					<c:if test="${company_name ne null and !company_name.isEmpty()}">
					<td><a href="javascript:fUserModal('${list.loginID}');">${list.company}</a></td>
					<td><a href="javascript:fUserModal('${list.loginID}');">${list.name}</a></td>
					</c:if>
					
					<c:if test="${company_name eq null or company_name.isEmpty()}">
					<td><a href="javascript:fUserModal('${list.loginID}');">${list.name}</a></td>
					<td>뿅</td>
					</c:if>
					<td>담당자명</td>
					<td>${list.hp}</td>
					<td>${list.status_yn}</td>
					<!-- List에 있는 js 함수 호출가능 이거 그대로 가지고 가기 때문에 !!  -->
				</tr>
				<!-- 
						 <c:set var="nRow" value="${nRow + 1}" />  -->
			</c:forEach>
										
		<input type="hidden" id="totalCnt" value="${totalCnt}">
		<!-- 이거 중간에 있으면 table 안먹힘  -->
