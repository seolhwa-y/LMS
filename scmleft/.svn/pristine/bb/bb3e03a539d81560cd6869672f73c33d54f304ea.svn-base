<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Job Korea :: 발주지시서 목록</title>


<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/duDatePicker/duDatepicker.css">
<script type="text/javascript" src="${CTX_PATH}/js/duDatePicker/duDatepicker.js"></script>


<script type="text/javascript">
	/* 초기 공지 사항 뷰 선언문 */
	var listCount = 10;
	var pageCount = 10;
	var vueSearch;	// 서치바
	var vuePurchaseDirection; // 발주지시서 리스트
	var vuePurchaseDirectionModal; // 발주지시서 상세보기

	function init() {
		
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
            	 /* 발주지시서 조회 */
            	 searchPurchasedirList : function(pageNum){
            		 var currentPage = (pageNum != undefined ? pageNum : vuePurchaseDirection.pageNum) || 1;           		 
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
  						vuePurchaseDirection.purDirectionList = data.result.purDirectionList;
  						vuePurchaseDirection.pagenavi = getPaginationHtml(currentPage, data.result.purDirectionCount, listCount, pageCount, 'paging');
  						vuePurchaseDirection.pageNum = currentPage;
 					 }
 					
 					 callAjax("/pur/searchPurDirectionList", "post", "json", true, param, listCallBack);
            	 }
             }
		});
		
	    /* 발주지시서 리스트 */
		vuePurchaseDirection = new Vue({
			  el : '#divPurchaseList',
			  data : {
				  purDirectionList: ${result}.purDirectionList,
				  pagenavi: getPaginationHtml(1, ${result}.purDirectionCount, listCount, pageCount, 'paging'),
			   	  pageNum : 1,
			  },
			  methods : {
				  /* 발주지시서 상세보기 */
				  showBordDirectionDetail : function(bordCode){
					  var param = {
							  pageNum : vuePurchaseDirection.pageNum, 
	 						  listCount : listCount,
							  bordCode : bordCode, 
	 				  } 
	  					 
	 				  var listCallBack = function(data) {
						  vuePurchaseDirectionModal.bordCode = data.result.purDirectionList[0].bordCode,
						  vuePurchaseDirectionModal.companyName = data.result.purDirectionList[0].companyName,
						  vuePurchaseDirectionModal.name = data.result.purDirectionList[0].name,
						  vuePurchaseDirectionModal.pdName = data.result.purDirectionList[0].pdName,
						  vuePurchaseDirectionModal.bordAmt = data.result.purDirectionList[0].bordAmt,
						  vuePurchaseDirectionModal.pdPrice = data.result.purDirectionList[0].pdPrice,
						  vuePurchaseDirectionModal.total = data.result.purDirectionList[0].total,
						  vuePurchaseDirectionModal.whName = data.result.purDirectionList[0].whName,
						  
						  gfModalPop("#divBordDirectionModal");
	 				}
	 					
	 					 callAjax("/pur/searchPurDirectionDetail", "post", "json", true, param, listCallBack);
	            	 }
			  },
		});	  
	    
	    /* 발주지시서 상세보기 모달 */
		vuePurchaseDirectionModal = new Vue({
			el : '#divBordDirectionModal',
			data : {
				bordCode : "",
				companyName : "",
				name : "",
				pdName : "",
				bordAmt : "",
				pdPrice : "",
				total : "",
				whName : "",
				purOut : true, // 보여라
			},
			methods : {
				/* 발주지시서 입금처리 */
				updBordDirection : function(){
					 var param = {
							 pageNum : vuePurchaseDirection.pageNum, 
	 						 listCount : listCount,
	 						 bordType : '3',
							 bordCode : vuePurchaseDirectionModal.bordCode, 
	 				 } 
	  					 
	 				 var listCallBack = function(data) { 
						  vueSearch.searchPurchasedirList();
						  gfCloseModal();
	 				}
	 					
	 					 callAjax("/pur/updateBorderDirection", "post", "json", true, param, listCallBack);
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
		vueSearch.searchPurchasedirList(pageNum);
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
							<span class="btn_nav bold">발주지시서 목록</span> 
							<a onClick="top.location='javascript:location.reload()'" class="btn_set refresh">새로고침</a>
						</p>
						
						<!-- 검색 영역 -->
						<div id="divSearchBar">
							<p class="conTitle" id="searcharea">
								<span>발주지시서 목록</span> 
							 	<span id = "search"  class="fr"> 
									<select id="searchKey" name="searchKey"  v-model="type">
									    <option value="all" selected="selected">전체</option>
										<option value="companyName" >업체명</option>
										<option value="pdName" >제품명</option>
									</select>
									<input class="datetype" type="date" v-model = "startDate">
									<input class="datetype" type="date" v-model = "endDate">
									<input type="text" id="searchWord"  v-model="keyword" placeholder="" style="height:27px"> 
									<a class="btnType blue" name="search" v-on:click = "searchPurchasedirList()">
										<span>검색</span>
									</a>							 
							</span>
						</div>
						
						<!-- 발주지시서 리스트 영역 -->
						<div id="divPurchaseList">
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
									    <th scope="col">발주번호</th>
										<th scope="col">납품업체</th>
										<th scope="col">제품명</th>
										<th scope="col">날짜</th>
										<th scope="col">여부</th>
									</tr>
								</thead>
								<tbody>
									<tr v-for = " (item, index) in purDirectionList" v-if = "purDirectionList.length > 0">
										<td>{{ item.bordCode }}</td>
										<td>{{ item.companyName }}</td>
										<td>{{ item.pdName }}</td>
										<td>{{ item.dirDate }}</td>
										<td v-if = "item.bordType == 2">{{ item.typeName }}</td>
										<td v-else-if = "item.bordType == 3" style = "color: red; font-weight: bold;">{{ item.typeName }}</td>
										<td v-else-if = "item.bordType == 1">
											<a class="btnType blue" v-on:click = "showBordDirectionDetail(item.bordCode)"><span>입금</span></a>
										</td>
									</tr>
									<tr v-if = "purDirectionList.length == 0">
		                            	<td colspan="6">검색된 데이터가 없습니다.</td>
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
	<div id="divBordDirectionModal" class="layerPop layerType2" style="width: 53.8rem;">
		<dl>
			<dt>
				<strong>발주지시서 상세보기</strong>
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
							<th scope="col">발주번호</th>
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
							<td>{{ bordCode }}</td>
							<td>{{ companyName }}</td>
							<td>{{ name }}</td>
							<td>{{ pdName }}</td>
							<td>{{ bordAmt }}</td>
							<td>{{ pdPrice }}</td>
							<td>{{ total }}</td>
							<td>{{ whName }}</td>
						</tr>
					</tbody>
				</table>
				<div class="btn_areaC mt30">
					<a class="btnType blue" v-on:click = "updBordDirection()" v-show = "purOut"><span>송금확인</span></a>
					<a class="btnType gray" v-on:click = "modalClose()"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
	</div>
</form>
	
</body>
</html>