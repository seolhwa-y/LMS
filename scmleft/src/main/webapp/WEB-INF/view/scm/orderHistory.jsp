<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 일별 수주 내역</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://unpkg.com/axios@0.12.0/dist/axios.min.js"></script>
<script src="https://unpkg.com/lodash@4.13.1/lodash.min.js"></script>
<!-- D3 -->
<style>
tbody > tr:hover {
  background-color: lightgray;
  cursor:pointer;
}

//
click-able rows
	.clickable-rows {tbody tr td { 
	cursor:pointer;
}

.el-table__expanded-cell {
	cursor: default;
}
}
</style>
<script type="text/javascript">
        var pageSizeinf  = 3;
        var pageBlockSizeinquiry  = 10;
		
		/** 버튼 이벤트 등록 */
		function fRegisterButtonClickEvent() {
			$('a[name=btn]').click(function(e) {
				e.preventDefault();

				var btnId = $(this).attr('id');
				switch (btnId) {
					case 'btnClose' :
					gfCloseModal();
					break;
					case 'btnCloseGrpCod' :
						gfCloseModal();
						break;					
					case 'btnSaveGrpCod' :
						fSaveGrpCod();
						break;							
						
			}
		});
	}
				  
				
	/** 공지사항 조회 */
	function fListInf(currentPage) {
		
		currentPage = currentPage || 1;
		
		//console.log("currentPage : " + currentPage);
						    
		var param = {
					currentPage : currentPage
				,	pageSize : pageSizeinf
		}
		
		var resultCallback = function(data) {
			fListInfResult(data, currentPage);
		};
		
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		//html로 받을거라 text
		callAjax("/inf/listinfvue.do", "post", "json", true, param, resultCallback);
	}
	
	
	/** 공지사항 조회 콜백 함수 */
	function fListInfResult(data, currentPage) {

		//console.log(data);		
		noticeareavar.listitem = data.notice;
		
		// 총 개수 추출
		var totalCntlistInf = data.noticeCnt;
		var list = $("#selectedInfNo").val();
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCntlistInf, pageSizeinf, pageBlockSizeinquiry, 'fListInf',[list]);
		//console.log("paginationHtml : " + paginationHtml);
	
		$("#listInfPagination").empty().append( paginationHtml );
	 
	}
		
	 /*공지사항 상세 조회*/
	 function fNoticeModal(noticeNo) {
	
		 var param = {noticeNo : noticeNo};
		 var resultCallback2 = function(data){
			 fdetailResult(data);
		 };
		 
		 callAjax("/system/detailNotice.do", "post", "json", true, param, resultCallback2);
	 }
	
	 /*  공지사항 상세 조회 -> 콜백함수   */
	 function fdetailResult(data){

		 if(data.resultMsg == "SUCCESS"){
			 //모달 띄우기 
			 gfModalPop("#notice");
			 
			// 모달에 정보 넣기 
			frealPopModal(data.result);
		 
		 }else{
			 alert(data.resultMsg);
		 }
	 }
	
	 /* 팝업 _ 초기화 페이지(신규) 혹은 내용뿌리기  */
	 function frealPopModal(object){
		 
		 noticeeditvue.loginId = object.loginId;
		 noticeeditvue.noticeTitle = object.noticeTitle;
		 noticeeditvue.noticeContent = object.noticeContent;
		 
		 noticeeditvue.loginIdread = "readonly";
		 noticeeditvue.noticeTitleread = "readonly";
		 noticeeditvue.noticeContentread = "readonly";
		 
		 $("#noticeNo").val(object.noticeNo); // 중요한 num 값도 숨겨서 받아온다. 
		 
	 }
	 
	 function init() {
		let ohList = ${orderHistoryList};
		let tbody = document.getElementById("orderHistoryTBody");
		let content = "";
		
		console.log(ohList);


		for(i = 0; i < ohList.length; i++) {
			content += "<tr>"
					+ "<td>" + ohList[i].jordCode + "</td>"
					+ "<td>" + cngDateType(ohList[i].jordDate) + "</td>"
					+ "<td>" + ohList[i].companyName + "</td>"
					+ "<td>" + ohList[i].pdName + "</td>"
					+ "<td>" + ohList[i].whStock.toLocaleString('ko-KR') + "</td>"
					+ "<td>" + ohList[i].pdPrice.toLocaleString('ko-KR') + "</td>"
					+ "<td>" + ohList[i].jordAmt.toLocaleString('ko-KR') + "</td>"
					+ "<td>" + ohList[i].totalAmt.toLocaleString('ko-KR') + "</td>";
			
			ohList[i].reDate != null ? content += "<td>Y</td><td>" + ohList[i].reDate + "</td>" : content += "<td>N</td><td></td>";
			ohList[i].jordIn == "0" ? content += "<td>미입금</td>" : content += "<td>입금</td>";
			ohList[i].bordCode != null ? content += "<td>작성완료</td>" : content += "<td><input type = 'button' id = 'btnBordDirec' value = '작성' onClick = 'showDirection(\"Border\")' /></td>";
			ohList[i].shCode != null ? content += "<td>작성완료</td>" : content += "<td><input type = 'button' id = 'btnShipDirec' value = '작성' onClick = 'showDirection(\"Sorder\")' /></td>";
		}
		
		tbody.innerHTML = content;	
	 }
	 
	// 타입 변환 :: 스트링 -> 날짜
	function cngDateType(strDate) {
		return strDate.substr(0, 4) + "-" + strDate.substr(4, 2) + "-" + strDate.substr(6, 2);
	}

	
	// 날짜인풋 :: 수주리스트 조회기간 설정
	function getOrderList() {
		let stDate = document.getElementById("inpStartDate").value.replaceAll("-", ""); // 조회 시작
		let edDate = document.getElementById("inpEndDate").value.replaceAll("-", ""); // 조회 끝
		const dateType = document.getElementById("selClass").value;
		
		console.log(dateType + " : " + stDate + "~" + edDate + "기간 확인 ok");
	}
	
	// 라디오버튼 :: 전체 or 반품
	function getReturnList(checkBox) {
		console.log(checkBox.checked);
		console.log(checkBox.getAttribute("value"));

		if(checkBox.checked == true) {
			// 체크완료			
			if(checkBox.getAttribute("value") == "all") {
				console.log(checkBox.getAttribute("value") + " 전체 조회");
			} else if(checkBox.getAttribute("value") == "true") {
				console.log(checkBox.getAttribute("value") + " 반품 요청 조회");
			} else if(checkBox.getAttribute("value") == "false") {
				console.log(checkBox.getAttribute("value") + " 반품 미요청 조회");
			}
		} 
		
	}
	
	function showDirection(type) {
		console.log(type);
	}
	
</script>

</head>
<body onload="init()">
	<form id="myForm" action="" method="">

		<input type="hidden" id="currentPage" value="1"> <input
			type="hidden" id="selectedInfNo" value="">
		<!-- 모달 배경 -->
		<div id="mask"></div>
		<div id="wrap_area">
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
						
						<!-- 타이틀 영영 -->
						<div class="content" style="margin-bottom: 20px;">
							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
								<span class="btn_nav bold">메인</span> <a href="../dashboard/dashboard.do" class="btn_set refresh">새로고침</a>
							</p>
							<div>
								<p class="conTitle" style="margin-bottom: 1%;">
									<span>일별 수주 내역</span> <span class="fr"> 관련 자료 </span>
								</p>
							</div>
							
								<div id = "divSearchBar">
									<select id = "selClass">
										<option>주문일자</option>
										<option>반품처리일</option>
									</select>
									<input type = "date" id = "inpStartDate" />
									<span> ~ </span>
									<input type = "date" id = "inpEndDate" onchange="getOrderList()"/>
									<input type = "radio" name = "returnType" value = "all" onchange = "getReturnList(this)" /> <span>전체</span>
									<input type = "radio" name = "returnType" value = "true" onchange = "getReturnList(this)" /> <span>반품요청</span>
									<input type = "radio" name = "returnType" value = "false" onchange = "getReturnList(this)" /> <span>반품미요청</span>
								</div>

							<!-- 일별 수주 내역 -->
							<div id="divDailyOrderList">
								<table class="col">
									<caption>caption</caption>
									<thead>
										<tr>
											<th scope="col">주문번호</th>
											<th scope="col">주문일자</th>
											<th scope="col">고객기업명</th>
											<th scope="col">주문제품명</th>
											<th scope="col">총재고갯수</th>
											<th scope="col">단가</th>
											<th scope="col">주문갯수</th>
											<th scope="col">금액합계</th>
											<th scope="col">반품요청여부</th>
											<th scope="col">반품처리일자</th>
											<th scope="col">입금여부</th>
											<th scope="col">발주지시서</th>
											<th scope="col">배송지시서</th>
										</tr>
									</thead>
									<tbody id = "orderHistoryTBody">

									</tbody>
								</table>
								<br>
								<!-- 페이징라인 -->
								<div class="paging_area" id="comnGrpCodPagination" ></div>
							</div>
							<br>
						</div>
						
						
		
					</li>
				</ul>
			</div>
		</div>
		
		<!-- 모달팝업 -->
		<div id="notice" class="layerPop layerType2" style="width: 600px;">
			<input type="hidden" id="noticeNo" name="noticeNo" value="${noticeNo}">
			<!-- 수정시 필요한 num 값을 넘김  -->

			<dl>
				<dt>
					<strong><!-- 제목 --></strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>

						<tbody>
							<tr>
								<th scope="row">작성자 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="loginId" id="loginId"/></td>
								<!-- <th scope="row">작성일<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="write_date" id="write_date" /></td> -->
							</tr>
							<tr>
								<th scope="row">제목 <span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100" name="noticeTitle" id="noticeTitle"/></td>
							</tr>
							<tr>
								<th scope="row">내용</th>
								<td colspan="3"><textarea class="inputTxt p100" name="noticeContent" id="noticeContent">
								</textarea></td>
							</tr>

						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
					</div>
				</dd>

			</dl>
		</div>


		<div id="layer2" class="layerPop layerType2" style="width: 600px;">
			<input type="hidden" id="action" name="action" value="U">
			<dl>
				<dt>
					<strong>그룹코드 관리</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
						</colgroup>

						<tbody>
							<tr>
								<th scope="row">그룹 코드 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="grp_cod"
									id="grp_cod" v-model="grp_cod" /></td>
								<th scope="row">그룹 코드 명 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100"
									name="grp_cod_nm" id="grp_cod_nm" v-model="grp_cod_nm" /></td>
							</tr>
							<tr>
								<th scope="row">코드 설명 <span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="grp_cod_eplti" id="grp_cod_eplti" v-model="grp_cod_eplti" /></td>
							</tr>

							<tr>
								<th scope="row">사용 유무 <span class="font_red">*</span></th>
								<td colspan="3"><input type="radio" id="radio1-1"
									name="grp_use_poa" id="grp_use_poa_1" value='Y'
									v-model="use_poa" /> <label for="radio1-1">사용</label>
									&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" id="radio1-2"
									name="grp_use_poa" id="grp_use_poa_2" value="N"
									v-model="use_poa" /> <label for="radio1-2">미사용</label></td>
							</tr>
						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSaveGrpCod" name="btn"><span>저장</span></a>
						<a href="" class="btnType blue" id="btnDeleteGrpCod" name="btn"
							v-show="delshow"><span>삭제</span></a> <a href=""
							class="btnType gray" id="btnCloseGrpCod" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>

	</form>
</body>
</html>