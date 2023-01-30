<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Scm Left :: 반품지시서</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- duDatePicker import css-->
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/duDatePicker/duDatepicker.css">
<!-- duDatePicker import js -->
<script type="text/javascript" src="${CTX_PATH}/js/duDatePicker/duDatepicker.js"></script>

<script type="text/javascript">
	
	//제품정보 페이징 처리
	var PageSize = 5;
	var PageBlock = 5;

	/*OnLoad event */
	$(function() {
		//반품지시서 목록 조회
		returnPurchaseList();
		
		//clickckbox();	//체크박스
		
		//버튼 이벤트 등록	(검색)	
		board_search();
		
	});
	
	function board_search(){
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
			
			switch (btnId) {
 				case 'searchBtn' :
 					board_search(); 
					break;
			}
		});
	
	}
	
	
	//주문내역 전체 조회
	function returnPurchaseList(currentPage) {
				
		currentPage = currentPage || 1;
					
		var param = {
					
				currentPage : currentPage,
				pageSize : pageSize
		
		}
			
		var resultCallBack = function(data){
			rplr(data, currentPage); //(returnPurchaseListResult)
				
		}
		callAjax("/pur/returnPurchaseList.do", "post", "text", true, param, resultCallBack );
	} 	
	//전체 주문내역 페이징 처리
	function rplr(data, currentPage) {
			//console.log("data" + data);

		$("#returnPurchaseList").empty().append(data);

		var totalCnt = $("#totalCnt").val();
		var pagingnavi = getPaginationHtml(currentPage, totalCnt, PageSize, PageBlock, 'returnPurchaseList');

		//(paginationHtml);
		$("#pagingnavi").empty().append(pagingnavi);
		$("#currentPage").val(currentPage);
	}

	//모달팝업
	function ModalStart(RE_CODE){
		
		ModalClose();
		
		var param ={RE_CODE : RE_CODE};
		var resultCallback2 = function(returndata){
			console.log("returndata : " + JSON.stringify(returndata));
			
		var list = returndata.result;
		var value = [list.RE_CODE, list.loginID, list.PD_NAME, list.PD_CODE, list.RE_AMT];
		var name = ['#RE_CODE', '#loginID', '#PD_NAME', '#PD_CODE', '#RE_AMT'];
		
			for(i=0; i<name.length; i++){
				console.log(name[i] + " :: " + value[i]);
				$(name[i]).append(value[i]);
			}
			
			ModalPop("#layer1");
		}
		callAjax("returnPurchaseOne.do", "post", "json", true, param, resultCallback2);
	}
	
	//주문내역 검색	`			Purchase ----> Order
	function searchreturnOrderList(currentPage) {

			currentPage = currentPage || 1;

			var searchKey = document.getElementById("searchKey").value;
			var searchWord = document.getElementById("searchWord").value;

			var sdate = $("#sdate").val();
			var edate = $("#edate").val();

			if ($("#clickckbox").is(":checked")) {
				alert("checked");
				checkBoxStatus = "checked";

			} else {
				//alert("unChecked");
				checkBoxStatus = "unChecked";
			}
			var param = {

				searchKey : searchKey,
				searchWord : searchWord,
				currentPage : currentPage,
				pageSize : pageSize,
				sdate : sdate,
				edate : edate,
				checkBoxStatus : checkBoxStatus
			}
			console.log("sdate : " + sdate + ", edate : " + edate);

			var resultCallBackSearch = function(data) {
				checkBoxListResult(data, currentPage);

			}

			callAjax("/pur/returnPurchaseList.do", "post", "text", true, param, resultCallBackSearch);
		}


		
// 		//단건 상세조회
// 		function returnOrderDetail(BORD_CODE, currentPage) {
// 			currentPage = currentPage || 1;

// 			var param = {
// 				BORD_CODE : BORD_CODE,
// 				currentPage : currentPage,
// 				pageSize : modalPageSize
// 			}
// 			var resultCallBack = function(data) {
// 				returnOrderDetailResult(data, currentPage);
// 			}
// 			callAjax("returnOrderDetailMd.do", "post", "text", true, param,	resultCallBack);
// 		}
// 		//단건 상세조회콜백
// 		function returnOrderDetailResult(data, currentPage) {
// 			//console.log(data);

// 			$("listModalOrdDtl").empty().append(data);

// 			var modalTotalCnt = $("#modalTotalCnt").val();
// 		}
		
		

		//확인버튼 클릭
		function confirmBtnClickEvent(BORD_TYPE, BORD_CODE) {
			if (BORD_TYPE == "1") {
				$("#btnSendConfirm").show();
			} else {
				$("#btnSendConfirm").hide();
			}

			returnOrderone(BORD_CODE);
			ordDtlList(BORD_CODE);
		}

		function setOrdModal(object) {

		}
		
</script>
<body>
<form id="myForm" action="" method="">
		<input type="hidden" id="currentPage" value=""> 
		<input type="hidden" id="currentPageModal" value=""> 

		<div id="mask"></div>
		<div id="wrap_area">


			<h2 class="hidden">header 영역</h2>
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
			<h2 class="hidden">컨텐츠 영역</h2>
			<div id="container">
				<ul>
					<li class="lnb">
						<!-- lnb 영역 --> <jsp:include
							page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
					</li>
					<li class="contents">
						<!-- contents -->
						<h3 class="hidden">contents 영역</h3> <!-- content -->
						<div class="content">

							<p class="Location">
								<a href="/dashboard/dashboard.do" class="btn_set home">메인으로</a> 
								<a class="btn_nav">기업고객</a>
								 <span class="btn_nav bold">반품 내역 관리</span> 
								<a href="" class="btn_set refresh">새로고침</a>
							</p>
						
							<p class="conTitle">
								<span>반품 내역 관리</span>
								
							</p>
						
							<div class="OrderList">
							<div class="conTitle" style="margin: 0 25px 10px 0; " align=center>
							
							<select name="searchKey" id="searchKey">
								<option value="cpname" id="option1">업체명</option>
								<option value="pdname" id="option2">제품명</option>													
							</select>
							<input type="text" style="width: 160px; height: 30px;" id="searchWord" name="searchWord" onkeypress="if( event.keyCode == 13 ){searchreturnOrderList();}"> 
							<input type="date" style="width: 160px; height: 30px;" id="sdate" name="sdate" onkeypress="if( event.keyCode == 13 ){searchreturnOrderList();}"> 
							<input type="date" style="width: 160px; height: 30px;" id="edate" name="edate"  onkeypress="if( event.keyCode == 13 ){searchreturnOrderList();}"> 
							<a href="javascript:searchOrdDtManagementList()" class="btnType blue" onkeydown="enterKey()" name="search" ><span>검  색</span></a>
						    <!-- enter입력하면 검색실행   -->
						  
						   <span style="margin: 10px; ">
						   	<input type="checkbox" id="depositCheck" > 승인
						   </span>
						   
							</div>
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="15%">
										<col width="15%">
										<col width="15%">
										<col width="10%">
										<col width="20%">
										<col width="10%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">반품번호</th>
											<th scope="col">반품회사</th>
											<th scope="col">반품제품</th>
											<th scope="col">반품수량</th>
											<th scope="col">날짜</th>
											<th scope="col">입금확인</th>											
										</tr>
									</thead>
									<tbody id="listOrdDtManagement"></tbody>
								</table>
								
								<!-- 페이징 처리 -->								
								<div class="paging_area" id="pagingnavi"></div> 																				
							</div>
						</div> <!--// content -->							
						<h3 class="hidden">풋터 영역</h3> <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>							
					</li>
				</ul>
			</div>
		</div>
							
						
		<!-- Modal 시작 -->
	<div id="layer1" class="layerPop layerType2" style="width: 900px;">
		<dl>
			<dt>
				<strong>반품 지시서</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="50px">
						<col width="40px">
						<col width="40px">
						<col width="50px">
						<col width="40px">
<%-- 					<col width="60px"> --%>
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">반품번호</th>
								<td><input style="text-align: center;" type="text" class="inputTxt p100" name="RE_CODE" id="RE_CODE" readonly="readonly"/></td>
							<th scope="row">반품회사</th>
								<td><input style="text-align: center;" type="text" class="inputTxt p100" name="loginID" id="loginID" readonly="readonly"/></td><br>
							<th scope="row">제품명</th>
								<td><input style="text-align: center;" type="text" class="inputTxt p100" name="PD_NAME" id="PD_NAME" readonly="readonly"/></td>
							<th scope="row">제품번호</th>
								<td><input style="text-align: center;" type="text" class="inputTxt p100" name="PD_CODE" id="PD_CODE" readonly="readonly"/></td><br>
							<th scope="row">반품수량</th>
								<td><input style="text-align: center;" type="text" class="inputTxt p100" name="RE_AMT" id="RE_AMT" readonly="readonly"/></td>
						</tr>
					</tbody>
				</table>
				
				<!-- 테이블 페이지 네비게이션 영역 -->
				<div class="pagingArea" id="ModalPurchaseDtlPagination"></div>	

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="javascript:sendPurchaseDirection()" class="btnType blue" id="btnSendConfirm" name="btn"><span>전송</span></a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="javascript:gfCloseModal()"	class="btnType gray" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>	
							
	
	</form>
</body>
</html>