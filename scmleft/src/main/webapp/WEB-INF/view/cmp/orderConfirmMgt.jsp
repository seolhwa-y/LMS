<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 구매승인</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://unpkg.com/axios@0.12.0/dist/axios.min.js"></script>
<script src="https://unpkg.com/lodash@4.13.1/lodash.min.js"></script>

<script type="text/javascript">
	
	/* 초기 공지 사항 뷰 선언문 */
	var listCount = 10;
	var pageCount = 10;
	var vueSearch;	// 서치바
	var vueOrderConfirm; // 발주승인 리스트


/** 기존 담당자 jQuery 방식
	//페이지 관리 
    
    var pagesize = 5;
    var pagenumsize = 5;

    
	// OnLoad event 
		$(function() {
		
		// 게시판 조회
		orderConfirm();
		
		fRegisterButtonClickEvent();
		
		
	});
	
		// 버튼 이벤트 등록 
		function fRegisterButtonClickEvent() {
			$('a[name=btn]').click(function(e) {
				e.preventDefault();

				var btnId = $(this).attr('id');
				
				switch (btnId) {
					case 'btnSearch' : 
						orderConfirm();  //누르면 jquery실행하라는 의미 
						break;
					case 'btnsuccess' : 
						alert("승인 되었습니다.");  //누르면 jquery실행하라는 의미 
						break;
				}
			});
		}
	
		function orderConfirm(clickpagenum) {
			
			clickpagenum = clickpagenum || 1;
			
			var DIR_CODE = $("#DIR_CODE").val();
			
			var sdate = $("#sdate").val();
			var edate = $("#edate").val();
			
			var param = {
					
					searchtype : $("#searchtype").val(),
					searchvalue : $("#searchvalue").val(),
					sdate : sdate,
					edate : edate,
					clickpagenum : clickpagenum,
					pagesize : pagesize,
					DIR_CODE : DIR_CODE
			};
			
			var firstsearchcallback = function(returndata) {
				
				console.log("returndata : " + returndata);
				
				firstsearchcallbackprocess(returndata,clickpagenum);				
			}			
			callAjax("/cmp/orderConfirmMgt.do", "post", "text", true, param, firstsearchcallback);			
		}
		
		function Sclick() {
			$("#DIR_CODE").val(DIR_CODE);
			console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@22" + DIR_CODE);
			alert("승인 되었습니다.");
		}
		
		function firstsearchcallbackprocess(returndata,clickpagenum) {

			$("#orderConfirmMgt").empty().append(returndata);
			
			console.log("wqwqwqwqwqw 2222: " + orderConfirmMgt);
			
			console.log("DIR_CODE : " + DIR_CODE);
			
			var totalcnt = $("#orderConfirmMgtcnt").val();
			
			var paginationHtml = getPaginationHtml(clickpagenum, totalcnt, pagesize, pagenumsize, 'orderConfirm');
			
			console.log("paginationHtml : " + paginationHtml);
			
			$("#orderConfirmMgtPagination").empty().append( paginationHtml );
			
			$("#hclickpagenum").val(clickpagenum);
		} */	
		
		
		function init() {
			
			/* 서치바 */
			vueSearch = new Vue({
				 el : '#spanSearchBar',  
		         data : {
		        	 keyword : '',
		        	 startDate : '',
		        	 endDate : '',
		         },
		         methods : {
		        	 searchBorder : function(pageNum) {
		        		 var currentPage = (pageNum != undefined ? pageNum : vueOrderConfirm.pageNum) || 1;
		        		 if(vueSearch.endDate.replaceAll("-", "") - vueSearch.startDate.replaceAll("-", "") < 0) return swal("날짜를 다시 선택하세요.");
		        		 
		        		 var param = {
								 pageNum : currentPage, 
								 listCount : listCount,
								 keyword : vueSearch.keyword, // 검색어
								 startDate : vueSearch.startDate.replaceAll("-", ""),
								 endDate : vueSearch.endDate.replaceAll("-", ""),
						} 
						 
						var listCallBack = function(data) {
		        			 console.log(data);
		        			 console.log(data.result.orderConfirmList);
		        			 console.log(data.result.orderConfirmCount);
		        			 
		        			 vueOrderConfirm.orderConfirmList = data.result.orderConfirmList;
		        			 vueOrderConfirm.pagenavi = getPaginationHtml(currentPage, data.result.orderConfirmCount, listCount, pageCount, 'paging');
		        			 vueOrderConfirm.pageNum = currentPage;
						}
						
						callAjax("/cmp/searchOrderConfirmlist", "post", "json", true, param, listCallBack);
		        	 }
		         }
			});
			
		    /* 발주승인 리스트 */
			vueOrderConfirm = new Vue({
				  el : '#divOrderConfirmList',
				  data : {
					  orderConfirmList : ${result}.orderConfirmList,
					  pagenavi : getPaginationHtml(1, ${result}.orderConfirmCount, listCount, pageCount, 'paging'),
				   	  pageNum : '',
				  },
				  methods : {
					 confirmBorder : function(bordType, bordCode) {
						 var param = {
								 bordType : bordType,
								 bordCode : bordCode,
						} 
						 
						var listCallBack = function(data) { 
							 console.log(data.messge);
							 vueSearch.searchBorder(vueOrderConfirm.pageNum);
						}
						
						callAjax("/cmp/updateBorderType", "post", "json", true, param, listCallBack);
					 }
				 }
			});	  
		}
		
		
		// 페이징 처리를 위해 해당 function 연결
		function paging(pageNum){
			vueSearch.searchBorder(pageNum);
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
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
								<span class="btn_nav bold">승인</span> 
								<span class="btn_nav bold">구매승인</span> 
								<a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
							</p>
							<p class="conTitle">
								<span>구매 승인</span>

								<!-- 검색영역 -->
								<span class="fr" id = "spanSearchBar"> 
									<span> 제품명 </span> 
									<input type="text"style="width: 300px; height: 25px;" id="searchvalue" name="searchvalue" v-model="keyword"> 
									<input type="date" id="sdate" v-model="startDate"> 
									<span> ~ </span> 
									<input type="date" id="edate" v-model="endDate">
									<a class="btnType blue" id="btnsearch" name="btn" v-on:click="searchBorder()"> 
										<span>검 색</span>
									</a>
								</span>
							</p>


							<!-- 발주승인 테이블 영역 -->
							<div id = "divOrderConfirmList">
								<table class="col">
									<colgroup>
										<col width="10%">
										<col width="20%">
										<col width="10%">
										<col width="15%">
										<col width="10%">
										<col width="20%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">발주업체명</th>
											<th scope="col">제품명</th>
											<th scope="col">수량</th>
											<th scope="col">금액</th>
											<th scope="col">구매일자</th>
											<th scope="col">구매 승인</th>
										</tr>
									</thead>
									<tbody>
										<tr v-for = " (item, index) in orderConfirmList" v-if = "orderConfirmList.length > 0">
											<td> {{ item.companyName }} </td>
											<td> {{ item.pdName }} </td>
											<td> {{ item.bordAmt }} </td>
											<td> {{ item.total }} </td>
											<td> {{ item.dirDate }} </td>
										 	<td v-if = "item.bordType == 0"> 
												<a class="btnType blue" v-on:click="confirmBorder('1', item.bordCode)"> 
													<span>승인</span>
												</a> 
												<a class="btnType gray" v-on:click="confirmBorder('2', item.bordCode)"> 
													<span>반려</span>
												</a> 
											</td>
											<td v-if="item.bordType != 0">{{ item.typeName }}</td>
										</tr>
										<tr v-else-if = "orderConfirmList.length == 0">
											<td colspan="6">검색된 데이터가 없습니다.</td>
										</tr>
									</tbody>
								</table>
								<div class="paging_area" id="orderConfirmMgtPagination" v-html="pagenavi"></div>
								<input type="hidden" v-model="pageNum" />
							</div>
						</div>	
					</li>
				</ul>
			</div>
		</div>
	</form>
</body>
</html>
