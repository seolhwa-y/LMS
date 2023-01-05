<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Scm Left :: 주문내역 관리</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<!-- duDatePicker import css-->
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/duDatePicker/duDatepicker.css">
<!-- duDatePicker import js -->
<script type="text/javascript" src="${CTX_PATH}/js/duDatePicker/duDatepicker.js"></script>

<script type="text/javascript">

	//제품정보 페이징 처리
	var ordPageSize = 10;
	var ordPageBlock = 10;
	
	var modalPageSize = 5;
	var modalPageBlock = 5;
	
	var checkBoxStatus;
	
	$(document).ready(function() {
		// 목록 조회
		ordDtManagementList();
		
		//체크박스 작동 메소드
		checkBoxStatus();
		
		//엔터 검색
		$("#searchWord").keypress(function (e){
			if(e.which == 13){
				searchOrdDtManagementList();
			}
			
		
		});
	});
	
	
	//주문내역 전체 조회
	function ordDtManagementList(currentPage) {
			
		currentPage = currentPage || 1;
				
		var param = {
				
				currentPage : currentPage,
				pageSize : ordPageSize
	
			}
		
		var resultCallBack = function(data){
			ordDtManagementListResult(data, currentPage);
			
		}

		callAjax("/pur/ordDtManagementList.do", "post", "text", true, param, resultCallBack );
	} 
	
	//전체 주문내역 페이징 처리
    function ordDtManagementListResult(data, currentPage) {
    	console.log("data" + data);
		
    	$("#listOrdDtManagement").empty().append(data);
    	
    	var totalCnt = $("#totalCnt").val();
    	
    	//var list = $("#tmpList").val();

    	
		var pagingnavi = getPaginationHtml(currentPage, totalCnt, ordPageSize, ordPageBlock, 'ordDtManagementList');
		
		//(paginationHtml);
		$("#pagingnavi").empty().append(pagingnavi);
		$("#currentPage").val(currentPage);
		  	
    }
	
	
	//주문내역 검색
	function searchOrdDtManagementList(currentPage) {
		
		currentPage = currentPage || 1;
		
		var searchKey = document.getElementById("searchKey").value;
		var searchWord = document.getElementById("searchWord").value;
		
		var sdate = $("#sdate").val();
		var edate = $("#edate").val();
		
		if ($("#depositCheck").is(":checked")) {
			alert("checked");
			checkBoxStatus="checked";
		
		}		
		else{
			//alert("unChecked");
			checkBoxStatus="unChecked";			
		}				
		var param = {
				
				searchKey : searchKey,
				searchWord : searchWord,	
				currentPage : currentPage,
				pageSize : ordPageSize,
				sdate : sdate,
				edate : edate,
				checkBoxStatus : checkBoxStatus
				
			}
		console.log("sDate : " + sdate + ", edate : " + edate);
	
		var resultCallBackSearch = function(data){
			checkBoxListResult(data, currentPage);
			
		}

		callAjax("/pur/ordDtManagementList.do", "post", "text", true, param, resultCallBackSearch );
	} 
	
	
	//체크박스에 따른 변동 입금, 미입금
	function checkBoxStatus(currentPage){
		
		currentPage = currentPage || 1;
		
		$("#depositCheck").change(function(){
			if ($("#depositCheck").is(":checked")) {
				//alert("checked");
				checkBoxStatus="checked";
			
			}			
			else{
				//alert("unChecked");
				checkBoxStatus="unChecked";			
			}	
			var param = {
					currentPage : currentPage,
					pageSize : ordPageSize,				
					checkBoxStatus : checkBoxStatus
			}
			console.log(param);
			var resultCallBack = function(data){
				checkBoxListResult(data, currentPage);
			}
			callAjax("/pur/ordDtManagementList.do", "post", "text", true, param, resultCallBack);
		});
	}
	
	//체크박스 페이지네이션
	function checkBoxList(currentPage){
		currentPage = currentPage || 1;
		
		var searchKey = document.getElementById("searchKey").value;
		var searchWord = document.getElementById("searchWord").value;
		
		var sdate = $("sdate").val();
		var edate = $("edate").val();
		
		if($("depositCheck").is(":ckecked")){
			ckeckBoxStatus = "checked";	
		}else{
			ckeckBoxStatus = "unchecked";	
		}	
			var param = {
					
					searchKey : searchKey,
					searchWord : searchWord,	
					currentPage : currentPage,
					pageSize : ordPageSize,
					sdate : sdate,
					edate : edate,
					checkBoxStatus : checkBoxStatus
					
				}
			
			var resultCallBack = function(data){
				checkBoxListResult(data, currentPage);
				
			}
			
			callAjax("/pur/ordDtManagementList.do", "post", "text", true, param, resultCallBack );
		} 
	
	//체크박스 상태에 따른 화면
	function checkBoxListResult(data, currentPage){
		$("#listOrdDtManagement").empty().append(data);
		
		var totalCnt = $("#totalCnt").val();
    
    	
		var pagingnavi = getPaginationHtml(currentPage, totalCnt, ordPageSize, ordPageBlock, 'checkBoxList');
		
		//(paginationHtml);
		$("#pagingnavi").empty().append(pagingnavi);
		$("#currentPage").val(currentPage);
		  	
    }
	
	//단건 조회
	function ordDtManagementSelect(BORD_CODE){
		
		var param = {
				BORD_CODE : BORD_CODE
		}
		var resultCallBack = function(data){
			ordDtManagementSelectResult(data);			
		}		
		callAjax("/pur/ordDtManagementSelect.do", "post", "json", true, param, resultCallBack );
	} 
	
	//단건조회 콜백
	function ordDtManagementSelect(data){
		gfModalPop("#layer1");
		
		setOrdModal(data.ordDtManagementVO);
	}
	
	//단건 상세조회
	function ordDtlList(BORD_CODE, currentPage){
		currentPage = currentPage || 1;
		
		var param = {
				BORD_CODE : BORD_CODE,
				currentPage : currentPage,
				pageSize : modalPageSize
		}
		var resultCallBack = function(data){
			ordDtlListResult(data, currentPage);
		}
		callAjax("modalOrdDtl.do", "post", "text", true, param, resultCallBack);
	}
	
	//단건 상세조회콜백
	function ordDtlListResult(data, currentPage){
		console.log(data);
		
		$("listModalOrdDtl").empty().append(data);
		
		var modalTotalCnt = $("#modalTotalCnt").val();
	}
	
	//확인버튼 클릭
	function confirmBtnClickEvent(BORD_TYPE, BORD_CODE){
		if(BORD_TYPE == "1"){
			$("#btnSendConfirm").show();
		}else{
			$("#btnSendConfirm").hide();
		}
		
		ordDtManagementSelect(BORD_CODE);
		ordDtlList(BORD_CODE);
	}
	
	function setOrdModal(object){
		
	}
	
</script>

</head>
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
								 <span class="btn_nav bold">주문내역 관리</span> 
								<a href="" class="btn_set refresh">새로고침</a>
							</p>
						
							<p class="conTitle">
								<span>주문내역 관리</span>
								
							</p>
						
							<div class="OrderList">
							<div class="conTitle" style="margin: 0 25px 10px 0; " align=center>
							
							<select name="searchKey" id="searchKey">
								<option value="cpname" id="option1">업체명</option>
								<option value="pdname" id="option2">제품명</option>													
							</select>
							<input type="text" style="width: 160px; height: 30px;" id="searchWord" name="searchWord" onkeypress="if( event.keyCode == 13 ){searchOrdDtManagementList();}"> 
							<input type="date" style="width: 160px; height: 30px;" id="sdate" name="sdate" onkeypress="if( event.keyCode == 13 ){searchOrdDtManagementList();}"> 
							<input type="date" style="width: 160px; height: 30px;" id="edate" name="edate"  onkeypress="if( event.keyCode == 13 ){searchOrdDtManagementList();}"> 
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
										<col width="10%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">발주번호</th>
											<th scope="col">발주회사</th>
											<th scope="col">발주제품</th>
											<th scope="col">발주수량</th>
											<th scope="col">날짜</th>
											<th scope="col">임원승인여부</th>
											<th scope="col">입금확인</th>											
										</tr>
									</thead>
									<tbody id="listOrdDtManagement"></tbody>
								</table>
								
								<!-- 페이징 처리 -->								
								<div class="paging_area" id="pagingnavi">														
								</div> 																				
							</div>
							
						
									<!-- Modal 시작 -->
		<div id="layer1" class="layerPop layerType2" style="width: 900px;">
		<dl>
			<dt>
				<strong>발주 지시서</strong>
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
						<col width="60px">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">발주번호</th>
							<td><input style="text-align: center;" type="text" class="inputTxt p100" name="purchase_no" id="purchase_no" readonly="readonly"/></td>
							<th scope="row">회사명</th>
							<td><input style="text-align: center;" type="text" class="inputTxt p100" name="deli_company" id="deli_company" readonly="readonly"/></td>
							<th scope="row">발주날짜</th>
							<td><input style="text-align: center;" type="text" class="inputTxt p100" name="purchase_date" id="purchase_date" readonly="readonly"/></td>
						</tr>
					</tbody>
				</table>
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="50px">
						<col width="40px">
						<col width="40px">
						<col width="60px">
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">담당자</th>
							<td><input style="text-align: center;" type="text" class="inputTxt p100" name="deli_name" id="deli_name" readonly="readonly"/></td>
							<th scope="row">총액</th>
							<td><input style="text-align: center;" type="text" class="inputTxt p100" name="total_price" id="total_price" readonly="readonly"/></td>
						</tr>
					</tbody>
				</table>
				<table class="row mt20" id="modalOrdDtlList">
					<colgroup>
						<col width="8%">
						<col width="5%">
						<col width="6%">
						<col width="8%">
						<col width="5%">
						<col width="10%">
						<col width="20%">
					</colgroup>
					<thead>
						<tr style="background-color: silver;">
							<th scope="row" style="font-weight: bold;">제품</th>
							<th scope="row" style="font-weight: bold;">수량</th>
							<th scope="row" style="font-weight: bold;">납품금액</th>
							<th scope="row" style="font-weight: bold;">합계금액</th>
							<th scope="row" style="font-weight: bold;">창고번호</th>
							<th scope="row" style="font-weight: bold;">창고이름</th>
							<th scope="row" style="font-weight: bold;">창고주소</th>
						</tr>
					</thead>
					<tbody id="listModalPurchaseDtl">					
					</tbody>	
				</table>
				<!-- 테이블 페이지 네비게이션 영역 -->
				<div class="pagingArea" id="ModalPurchaseDtlPagination"></div>	

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="javascript:sendPurchaseDirection()" class="btnType blue" id="btnSendConfirm" name="btn"><span>발주 지시서 전송</span></a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="javascript:gfCloseModal()"	class="btnType gray" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>	
							
						</div> <!--// content -->							
						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
							
					</li>
				</ul>
			</div>
			
		</div>
	
	</form>
</body>
</html>