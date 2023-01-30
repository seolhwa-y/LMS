<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Scm Left :: 반품지시서</title>
<c:if test="${sessionScope.userType ne 'A'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<!-- duDatePicker import css-->
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/duDatePicker/duDatepicker.css">
<!-- duDatePicker import js -->
<script type="text/javascript" src="${CTX_PATH}/js/duDatePicker/duDatepicker.js"></script>

<script type="text/javascript">
	
	//제품정보 페이징 처리
	var returnPageSize = 10;
	var returnPageBlock = 5;
	var vueReturnDirection;

	
	
	function init(){
		
		console.log(${returnDirList});
		console.log(${totalCnt});
		
		
		/* 반품지시서 목록 */
		vueReturnDirection = new Vue({
			el : "#ReturnDirList",
			data : {
				cpname : "",			
				sdate : "",
				edate : "",
				returnDirectionList : ${returnDirList},
				pagenavi : getPaginationHtml(1, ${totalCnt}, returnPageSize, returnPageBlock, 'vueReturnDirection.searchReturnDirection'),
				currentPage : 1,
			},
			methods : {
				// 반품지시서 목록
				searchReturnDirection : function(pageNum){
					var currentPage = pageNum || 1;
					
					var param = {
						cpname : vueReturnDirection.cpname,			
						sdate : vueReturnDirection.sdate.replaceAll("-",""),
						edate : vueReturnDirection.edate.replaceAll("-",""),
						currentPage : currentPage,
						pageSize : returnPageSize

					}
					var resultCallBack = function(data){
						console.log(data);
						
						vueReturnDirection.returnDirectionList = data.returnDirList;
				    	vueReturnDirection.pagenavi = getPaginationHtml(currentPage, data.totalCnt, returnPageSize, returnPageBlock, 'vueReturnDirection.searchReturnDirection');
				    	vueReturnDirection.currentPage = data.currentPage;
					}
					callAjax("/scm/returnDirList.do", "post", "json", true, param, resultCallBack );
				}
			}
		});
	}

</script>
</head>
<body onload="init()">
	<form id="myForm" action="" method="">
		<div id="mask"></div>
		<div id="wrap_area">
			<div id="container">
				<ul>
					<li class="lnb">
						<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> 
					</li>
					<li class="contents">
						<div class="content">
							<p class="Location">
								<a href="/dashboard/dashboard.do" class="btn_set home">메인으로</a> 
								<a class="btn_nav">작업지시서</a>
								 <span class="btn_nav bold">반품지시서</span> 
								<a href="" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>반품 지시서</span>
								<span class="fr"> 									
								</span>
							</p>

							<div id="ReturnDirList">
								<div class="conTitle" style="margin: 0 25px 10px 0; " align=center>
						    		<span>기업 고객명</span>
									<input type="text" style="width: 160px; height: 30px;" v-model= "cpname"  />  
									<input type="date" style="width: 160px; height: 30px;" v-model= "sdate"  />  
									<input type="date" style="width: 160px; height: 30px;" v-model= "edate" />  
									<a v-on:click = "searchReturnDirection()" class="btnType blue" id="searchBtn" name="btn" >
										<span>검  색</span>
									</a>
								</div>
								<table class="col">
									<colgroup>
										<col width="15%">
										<col width="15%">
										<col width="20%">
										<col width="10%">
										<col width="15%">
										<col width="10%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">주문일자</th>
											<th scope="col">기업고객명</th>
											<th scope="col">제품명</th>
											<th scope="col">반품 개수</th>
											<th scope="col">금액</th>
											<th scope="col">승인여부</th>											
										</tr>
									</thead>
									<tbody id="returnDirList">
										<tr v-for = "(item, index) in returnDirectionList" v-if = "returnDirectionList.length > 0">
											<td>{{ item.jordDate }}</td>
											<td>{{ item.company }}</td>
											<td>{{ item.pdName }}</td>
											<td>{{ item.reAmt }}</td>
											<td>{{ item.returnPrice }}</td>
											<td v-if = "item.reType == 0">미승인</td>
											<td v-else-if = "item.reType == 1">승인</td>
											<td v-else>반려</td>
										</tr>
										<tr v-else-if = "returnDirectionList.length == 0">
											<td>검색된 데이터가 없습니다.</td>
										</tr>
									</tbody>
								</table>
								
								<!-- 페이징 처리 -->
								<div class="paging_area" id="pagingnavi" v-html = "pagenavi"></div>
								<input type="hidden" v-model="currentPage" > 
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
	
	</form>
</body>
</html>