<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Job Korea :: 반품지시서 목록</title>


<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/duDatePicker/duDatepicker.css">
<script type="text/javascript" src="${CTX_PATH}/js/duDatePicker/duDatepicker.js"></script>


<script type="text/javascript">
	/* 초기 공지 사항 뷰 선언문 */
	var listCount = 10;
	var pageCount = 10;
	var vueSearch;	// 서치바
	var vuePurchaseReturnDirection; // 반품지시서 리스트
	var vuePurchaseReturnDirectionModal; // 반품지시서 상세보기

	function init() {
		
		console.log(${result});
		/* 서치바 */
		vueSearch = new Vue({
			 el : '#divSearchBar',  
             data : {
            	 type : 'all', 
            	 keyword : '',
            	 startDate : '',
            	 endDate : '',
             },
             methods : {
            	 /* 반품지시서 조회 */
            	 searchBordReturnList : function(pageNum){
            		 var currentPage = (pageNum != undefined ? pageNum : vuePurchaseReturnDirection.pageNum) || 1;           		 
            		 if(vueSearch.endDate.replaceAll("-", "") - vueSearch.startDate.replaceAll("-", "") < 0) return swal("날짜를 다시 선택하세요.");

  					 var param = {
 							 pageNum : currentPage, 
 							 listCount : listCount,
 							 type : vueSearch.type, // 검색 타입
 							 keyword : vueSearch.keyword, // 검색어
 							 startDate : vueSearch.startDate.replaceAll("-", ""),
 							 endDate : vueSearch.endDate.replaceAll("-", ""),
 					 } 
  					 
 					 var listCallBack = function(data) {
  						vuePurchaseReturnDirection.purReturnDirectionList = data.result.purReturnDirectionList;
  						vuePurchaseReturnDirection.pagenavi = getPaginationHtml(currentPage, data.result.purReturnDirectionCount, listCount, pageCount, 'paging');
  						vuePurchaseReturnDirection.pageNum = currentPage;
 					 }
 					
 					 callAjax("/pur/searchReturnPurchase", "post", "json", true, param, listCallBack);
            	 }
             }
		});
		
	    /* 반품지시서 리스트 */
		vuePurchaseReturnDirection = new Vue({
			  el : '#divPurReturnList',
			  data : {
				  purReturnDirectionList: ${result}.purReturnDirectionList,
				  pagenavi: getPaginationHtml(1, ${result}.purReturnDirectionCount, listCount, pageCount, 'paging'),
			   	  pageNum : 1,
			  },
			  methods : {
				  /* 반품지시서 상세보기 */
				  showBordReturnDirectionDetail : function(reCode){
					  var param = {
							  pageNum : vuePurchaseReturnDirection.pageNum, 
	 						  listCount : listCount,
							  reCode : reCode, 
	 				  } 
	  					 
	 				  var listCallBack = function(data) {
	 					 console.log(data);
	 					  
						  vuePurchaseReturnDirectionModal.reCode = data.result.purReturnDirectionList[0].reCode,
						  vuePurchaseReturnDirectionModal.companyName = data.result.purReturnDirectionList[0].companyName,
						  vuePurchaseReturnDirectionModal.name = data.result.purReturnDirectionList[0].name,
						  vuePurchaseReturnDirectionModal.pdName = data.result.purReturnDirectionList[0].pdName,
						  vuePurchaseReturnDirectionModal.reAmt = data.result.purReturnDirectionList[0].reAmt,
						  vuePurchaseReturnDirectionModal.pdPrice = data.result.purReturnDirectionList[0].pdPrice,
						  vuePurchaseReturnDirectionModal.total = data.result.purReturnDirectionList[0].total,
						  vuePurchaseReturnDirectionModal.whName = data.result.purReturnDirectionList[0].whName,
						  
						  gfModalPop("#divBordReturnDirectionModal");
	 				}
	 					
	 					 callAjax("/pur/searchReturnPurchase", "post", "json", true, param, listCallBack);
	            	 }
			  },
		});	  
	    
	    /* 반품지시서 상세보기 모달 */
		vuePurchaseReturnDirectionModal = new Vue({
			el : '#divBordReturnDirectionModal',
			data : {
				reCode : "",
				companyName : "",
				name : "",
				pdName : "",
				reAmt : "",
				pdPrice : "",
				total : "",
				whName : "",
				purOut : true, // 보여라
			},
			methods : {
				/* 발주지시서 입금처리 */
				updBordReturnDirection : function(){
					 var param = {
							 pageNum : vuePurchaseReturnDirection.pageNum, 
	 						 listCount : listCount,
	 						 reOut : '1',
							 reCode : vuePurchaseReturnDirectionModal.reCode, 
	 				 } 
	  					 
	 				 var listCallBack = function(data) { 
						  vueSearch.searchBordReturnList();
						  gfCloseModal();
	 				}
	 					
	 					 callAjax("/pur/updateReturnPurchase", "post", "json", true, param, listCallBack);
				},
				/* 모달 닫기 */
				modalClose : function(){
					gfCloseModal();
				},
			},
		});
	}
	
	// 페이징 처리를 위해 해당 function 연결
	function paging(pageNum){
		vueSearch.searchBordReturnList(pageNum);
	}
</script>

</head>
<body onload="init()">
<form id="myForm" action=""  method="">
	<div id="wrap_area">
		<div id="container">
			<ul>
				<li class="lnb">
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> 
				</li>
				<li class="contents">
					<div class="content">
						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a> 
							<a href="#" class="btn_nav">납품업체</a> 
							<span class="btn_nav bold">반품지시서 목록</span> 
							<a onClick="top.location='javascript:location.reload()'" class="btn_set refresh">새로고침</a>
						</p>
						
						<!-- 검색 영역 -->
						<div id="divSearchBar">
							<p class="conTitle" id="searcharea">
								<span>반품지시서 목록</span> 
							 	<span id = "search"  class="fr"> 
									<select id="searchKey" name="searchKey"  v-model="type">
									    <option value="all" selected="selected">전체</option>
										<option value="companyName" >업체명</option>
										<option value="pdName" >제품명</option>
									</select>
									<input class="datetype" type="date" v-model = "startDate">
									<input class="datetype" type="date" v-model = "endDate">
									<input type="text" id="searchWord"  v-model="keyword" placeholder="" style="height:27px"> 
									<a class="btnType blue" name="search" v-on:click = "searchBordReturnList()">
										<span>검색</span>
									</a>							 
							</span>
						</div>
						
						<!-- 반지시서 리스트 영역 -->
						<div id="divPurReturnList">
							<table class="col">
								<colgroup>
		                        	<col width="8%">
		                        	<col width="10%">
		                        	<col width="10%">
		                        	<col width="20%">
		                        	<col width="10%">
		                        </colgroup>
								<thead>
									<tr>
									    <th scope="col">반품번호</th>
										<th scope="col">납품업체</th>
										<th scope="col">제품명</th>
										<th scope="col">날짜</th>
										<th scope="col">여부</th>
									</tr>
								</thead>
								<tbody>
									<tr v-for = " (item, index) in purReturnDirectionList" v-if = "purReturnDirectionList.length > 0">
										<td>{{ item.reCode }}</td>
										<td>{{ item.companyName }}</td>
										<td>{{ item.pdName }}</td>
										<td>{{ item.dirDate }}</td>
										<td v-if = "item.reType == 2">{{ item.typeName }}</td>
										<td v-else-if = "item.reType == 1 && item.reOut == 1" style = "color: red; font-weight: bold;">입금완료</td>
										<td v-else-if = "item.reType == 1 ">
											<a class="btnType blue" v-on:click = "showBordReturnDirectionDetail(item.reCode)"><span>입금</span></a>
										</td>
										
									</tr>
									<tr v-if = "purReturnDirectionList.length == 0">
		                            	<td colspan="5">검색된 데이터가 없습니다.</td>
		                            </tr>   
								</tbody>
							</table>
							<div class = "paging_area"  id = "divPurDirectionPaging" v-html = "pagenavi"></div>
                           	<input type="hidden" v-model="pageNum" />
						</div>
					</div>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- 모달팝업 -->
	<div id="divBordReturnDirectionModal" class="layerPop layerType2" style="width: 53.8rem;">
		<dl>
			<dt>
				<strong>반품지시서 상세보기</strong>
			</dt>
			<dd class="content">
				<table class="col">
					<colgroup>
			            <col width="8%">
			            <col width="10%">
			            <col width="10%">
			            <col width="20%">
			            <col width="8%">
			            <col width="10%">
			            <col width="10%">
			            <col width="10%">
		            </colgroup>
					<thead>
						<tr>
							<th scope="col">반품번호</th>
							<th scope="col">납품업체</th>
							<th scope="col">납품 담당자</th>
							<th scope="col">제품명</th>
							<th scope="col">수량</th>
							<th scope="col">단가</th>
							<th scope="col">합계</th>
							<th scope="col">창고명</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>{{ reCode }}</td>
							<td>{{ companyName }}</td>
							<td>{{ name }}</td>
							<td>{{ pdName }}</td>
							<td>{{ reAmt }}</td>
							<td>{{ pdPrice }}</td>
							<td>{{ total }}</td>
							<td>{{ whName }}</td>
						</tr>
					</tbody>
				</table>
				<div class="btn_areaC mt30">
					<a class="btnType blue" v-on:click = "updBordReturnDirection()" v-show = "purOut"><span>송금확인</span></a>
					<a class="btnType gray" v-on:click = "modalClose()"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
	</div>
</form>
	
</body>
</html>