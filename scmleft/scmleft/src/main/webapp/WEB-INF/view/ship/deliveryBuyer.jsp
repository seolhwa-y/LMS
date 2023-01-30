<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<title> 배송 지시서 목록_배송 담당자 </title>

<!-- common Include -->
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script>
//페이징 설정
var pageSize = 5;
var pagenumSize = 5;

//OnLoad event
$(function() {
	
	$("#deliveryDoneCheck").on('change', function() {
		  if ($(this).is(':checked')) {
		    $(this).attr('value', 'refund');
		  } else {
		    $(this).attr('value', '');
		  }		  
		  fselectdeliveryList();
		});	
	fselectdeliveryList();
});

// 목록 불러오기 
function fselectdeliveryList(pagenum) {
	
	pagenum = pagenum || 1;
	
	var param = {
			deliveryDoneCheck : $("#deliveryDoneCheck").val()
		,	currentPage : pagenum
		,   pageSize : pageSize
	}
	
	var resultCallBack = function(returndata) {
		deliveryBuyerListResult(returndata,pagenum);
	}
		
	callAjax("/ship/deliveryBuyerList.do", "post", "text", true, param, resultCallBack );
	
}

//리스트 콜백함수 뿌리기, 페이징
function deliveryBuyerListResult(data, currentPage) {
	console.log(data);
	
	$("#deliveryBuyerList").empty().append(data);
	
	var totalCnt = $("#totalCnt").val();
	   	
	var pagingnavi = getPaginationHtml(currentPage, totalCnt, pageSize, pagenumSize, 'fselectdeliveryList');
	console.log("pagingnavi : " + pagingnavi);
	//(paginationHtml);
	$("#orderListPagination").empty().append(pagingnavi );
	$("#currentPage").val(currentPage);
	
	// 현재 페이지 설정
	$("#returnDelList").val(currentPage);    	
}	

// 모달창(팝업)실행  여기부터 
 function deliveryModalOpen(dir_code) {
	 
	//alert("dir_code : " + dir_code);  	
	var param = {
			dir_code : dir_code
	}
	
	var resultCallBack = function(returndata) {
		//console.log(returndata);
		console.log(JSON.stringify(returndata));
		//returndata
		frealPopModal(returndata.result);
	}
	
	callAjax("/ship/deliveryListOne.do", "post", "json", true, param, resultCallBack );
	
	//frealPopModal(model_code); //번호로 -> 상품 상세 조회 팝업 띄우기
}

 function frealPopModal(object){
	 
	 //alert(object.jord_code);
	 	 
	 $("#jord_code").val(object.jord_code); //value 값으로 받아 올때는 .val 
	 $("#company").val(object.company);
	 $("#addr").val(object.addr);
	 $("#pd_name").text(object.pd_name); //.text
	 $("#jord_amt").text(object.jord_amt);
	 $("#wh_code").text(object.wh_code);
	 $("#wh_name").text(object.wh_name);
	 $("#wh_addr").text(object.wh_addr);
	 $("#ModelCode").val(object.model_code);
	 $("#loginID").val(object.loginID);
	 $("#shCode").val(object.sh_code);
	
	 // gfCloseModal(); // 닫기  
	 
	 console.log(object.sh_type);
	 
	 if(object.sh_type == "배송대기") {
		 $("#btnSendWord").show(); //버튼 보여주기
	 } else {
		 $("#btnSendWord").hide(); //버튼 숨기기
	 }
	 								
	// 모달 팝업
	gfModalPop("#layer1");	 
}
 
 // insert 시작
 function finsertDel(){
		 
	 //alert("저장 함수 타는지!!!!!?? ");
	 // validation 체크 
	 var param = {
			 jord_code: $("#jord_code").val()
			,wh_amt: $("#jord_amt").text()
			,wh_code :$("#wh_code").text()
			,ModelCode:$("#ModelCode").val()
			,loginID:$("#loginID").val()
			,sh_code : $("#shCode").val()
	}
	 console.log(param);
	 
	  var resultCallback = function(data){
		 console.log(data);
		 gfCloseModal();
		 alert(data.resultMsg);		 
		 
		 fselectdeliveryList($("#returnDelList").val());
	 };

	 callAjax("/ship/insertDelHousing.do", "post", "json", true, param, resultCallback);
 	// $("#myNotice").serialize() => 직렬화해서 name 값들을 그냥 넘김.
 }
	


</script>
</head>
<body>
	<form id="myForm" action=""  method="">
		<input type="hidden" name="currentPageDeliveryBuyer" id="currentPageDeliveryBuyer" value="">
		<input type="hidden" name="currentPageDeliveryBuyerDtlList" id="currentPageDeliveryBuyerDtlList" value="">
		<input type="hidden" id="userEmail" name="userEmail" value=""/>
		<input type="hidden" id="currentOrderNum" name="currentOrderNum" value=""/>
		<input type="hidden" id="returnDelList" name="returnDelList" value=""/>
		
		<div id="wrap_area">
			
			<!-- header Include -->
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
			
			<div id="container">
				<ul>
					<li class="lnb">
					
						<!-- lnb Include -->
						<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
						
					</li>
					<li class="contents">
						<div class="content">
							<!-- 메뉴 경로 영역 -->
							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <a href="#"
									class="btn_nav">기업고객</a> <span class="btn_nav bold">배송 지시서 목록</span> <a href="/dlm/deliveryBuyer.do" class="btn_set refresh">새로고침</a>
							</p>
							
							<!-- 검색 영역 -->
							<p class="search">
							
							</p>							
							<p class="conTitle" id="searchArea">
							<span>배송 지시서 목록_배송담당자</span>
								 <span class="fr"> 
									<select id="searchKey" name="searchKey" style="width: 80px;">
									    <option value="all" id="option1" selected="selected">전체</option>
										<option value="user_company" id="option2">구매회사</option>										
										<option value="pro_name" id="option3">제품명</option>
									</select> 
									<input type="text" id="searchWord" name="searchWord" placeholder="검색어를 입력하세요." style="height: 28px;"> 
										<input type="text" id="startDate" name="startDate" placeholder="시작일 선택" style="height: 28px;width: 80px" readonly="readonly"></input>
										<input type="text" id="endDate" name="endDate" placeholder="종료일 선택" style="height: 28px;width: 80px" readonly="readonly"></input>
										<a class="btnType blue" href="javascript:searchDeliveryBuyerList()" onkeydown="enterKey()" name="search">
										<span id="searchEnter">검색</span></a>			
								</span>
							</p>
							<span class="fr">								
								<input type="checkbox" id="deliveryDoneCheck" value="" > 미완료 배송 목록 조회
							</span>	
							
							<!-- 테이블 영역 -->
							<div class="divDeliveryBuyer" id="divDeliveryBuyer">
								<table class="col">
									<colgroup>
										<col width="5%">
										<col width="8%">
										<col width="8%">
										<col width="5%">
										<col width="6%">
										<col width="6%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">주문번호</th>
											<th scope="col">주문고객</th>
											<th scope="col">배송희망일</th>
											<th scope="col">배송 담당자</th>
											<th scope="col">출발 창고지</th>
											<th scope="col">배송상태</th>
										</tr>
									</thead>
									
									<!--  -->
									<tbody id="deliveryBuyerList">
									</tbody>									
								</table>
							</div>	<!-- .divDeliveryBuyerList 종료 -->
							
							<!-- 테이블 페이지 네비게이션 영역 -->
							<div class="pagingArea" id="orderListPagination"></div>							
						</div>
					</li>
				</ul>
			</div>
		</div>	
		
		<!-- Modal 시작 -->
		<div id="layer1" class="layerPop layerType2" style="width: 900px;">
		<dl>
			<dt>
				<strong>배송 지시서</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row mt20">
					<caption>caption</caption>
					<colgroup>
						<col width="40px">
						<col width="40px">
						<col width="40px">
						<col width="60px">
						<col width="60px">
						<col width="150px">
					</colgroup>					
						<tr>
							<th scope="row">주문번호</th>
							<td><input style="text-align: center;" type="text" class="inputTxt p100" name="jord_code" id="jord_code" readonly="readonly"/></td>
							<th scope="row">주문고객</th>
							<td><input style="text-align: center;" type="text" class="inputTxt p100" name="company" id="company" readonly="readonly"/></td>
							<th scope="row">주문고객주소</th>
							<td><input style="text-align: center;" type="text" class="inputTxt p100" name="addr" id="addr" readonly="readonly"/></td>
						</tr>				
				</table>
				<br>
				<table class="col">	
					<colgroup>
						<col width="6%">
						<col width="4%">
						<col width="4%">
						<col width="8%">
						<col width="15%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">제품</th>
							<th scope="col">수량</th>
							<th scope="col">창고번호</th>
							<th scope="col">창고이름</th>
							<th scope="col">창고주소</th>
						</tr>
					</thead>
					<tbody>						
							<td id="pd_name"></td>
							<td id="jord_amt"></td>
							<td id="wh_code"></td>
							<td id="wh_name"></td>
							<td id="wh_addr"></td>										
						</tbody>
				</table>
							<!-- <th scope="row">테스트</th>
							<td><input type="text" class="inputTxt p100" name="test" id="test" readonly="readonly" value="test"/></td> -->				
			
			<%-- 	<table class="row mt20" id="modalDeliveryBuyerDtlList">
					<colgroup>
						<col width="6%">
						<col width="4%">
						<col width="4%">
						<col width="8%">
						<col width="15%">
					</colgroup>
					<thead>
						<tr style="background-color: silver;">
							<th scope="row" style="font-weight: bold;" name="PD_NAME" id="PD_NAME" readonly="readonly">제품</th>
							<th scope="row" style="font-weight: bold;">수량</th>
							<th scope="row" style="font-weight: bold;">창고번호</th>
							<th scope="row" style="font-weight: bold;">창고이름</th>
							<th scope="row" style="font-weight: bold;">창고주소</th>
						</tr>
					</thead>
					<tbody id="deliveryModalOpen">	
									
					</tbody>	
				</table>
				<!-- 테이블 페이지 네비게이션 영역 -->
				<div class="pagingArea" id="modalDeliveryBuyerDtlPagination"></div>	 --%>

				<!-- e : 여기에 내용입력 -->
				<input type="hidden" id="ModelCode">  	
			    <input type="hidden" id="loginID">  
			    <input type="hidden" id="shCode">  
			    
				<div class="btn_areaC mt30"> 
					<a href="javascript:finsertDel()" class="btnType blue" id="btnSendConfirm" name="btn"><span id="btnSendWord">배송완료</span></a>			
					<a href="javascript:gfCloseModal()"	class="btnType gray" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>	
	<!-- Modal 종료 -->		
			
	</form>	
</body>
</html>