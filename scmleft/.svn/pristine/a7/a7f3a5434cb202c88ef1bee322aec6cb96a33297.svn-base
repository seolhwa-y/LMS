<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>배송 지시서</title>
<c:if test="${sessionScope.userType ne 'A'}">
	<c:redirect url="/dashboard/dashboard.do" />
</c:if>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<!-- duDatePicker import css-->
<link rel="stylesheet" type="text/css"
	href="${CTX_PATH}/css/duDatePicker/duDatepicker.css">
<!-- duDatePicker import js -->
<script type="text/javascript"
	src="${CTX_PATH}/js/duDatePicker/duDatepicker.js"></script>

<script type="text/javascript">	
</script>
</head>
<script type="text/javascript">
	
	//페이징처리
	var pageSize = 5;
	var pagenumSize = 5;

	// OnLoad event
	$(function() {
		
		$("#shippingDoneCheck").on('change', function() {
			  if ($(this).is(':checked')) {
			    $(this).attr('value', 'refund');
			  } else {
			    $(this).attr('value', '');
			  }
			  
			   fselectshippingDirList();
			  
			});
		
		fselectshippingDirList();
	});
	
	function fselectshippingDirList(pagenum) {
		
		pagenum = pagenum || 1;
		
		var param = {
				shippingDoneCheck : $("#shippingDoneCheck").val()
			,	currentPage : pagenum
			,   pageSize : pageSize
		}
		
		var resultCallBack = function(returndata) {
			shippingDirListResult(returndata,pagenum);
		}
			
		callAjax("/scm/shippingDirectionList.do", "post", "text", true, param, resultCallBack );
		
	}
	
	//리스트 콜백함수 뿌리기, 페이징
    function shippingDirListResult(data, currentPage) {
    	console.log(data);
    	
    	$("#shippingDirectionList").empty().append(data);
    	
    	var totalCnt = $("#totalCnt").val();
    	   	
		var pagingnavi = getPaginationHtml(currentPage, totalCnt, pageSize, pagenumSize, 'fselectshippingDirList');
		console.log("pagingnavi : " + pagingnavi);
		//(paginationHtml);
		$("#orderListPagination").empty().append(pagingnavi );
		$("#currentPage").val(currentPage);
		
		// 현재 페이지 설정
		//$("#returnDirList").val(currentPage);
	    	
    }	
    	
    
    //배송 지시서 모달 오픈
    function shippingModalOpen(dir_code) {
       
    shippingModalClosed();
       
    var param = {
    		   dir_code : dir_code
          };         
    
    var searchcallback = function(returndata){            
             
    	console.log("returndata : " + JSON.stringify(returndata) );
          
        var list = returndata.result;          
       var value = [list.jord_date, list.jord_code, list.pd_corp, list.pd_name, list.jord_amt, list.wh_name, list.name, list.jord_in];
        var name = ['#JORD_DATE', '#JORD_CODE', '#PD_CORP', '#PD_NAME', '#JORD_AMT', '#WH_NAME', '#name', '#JORD_IN'];   
        
             for(i=0; i < name.length; i++){
    			
            	console.log(name[i] + " :: " + value[i]);              	
    			$(name[i]).append(value[i]);
    		}   		 
             gfModalPop("#deliDirection");          
          }          
          callAjax("shippingDirOne.do", "post", "json", true, param, searchcallback);          
    }
    
     //shippingModalClosed
     function shippingModalClosed() {
       $("#JORD_DATE").empty();
       $("#JORD_CODE").empty();
       $("#PD_CORP").empty();
       $("#PD_NAME").empty();
       $("#JORD_AMT").empty();
       $("#WH_NAME").empty();
       $("#JORD_AMT").empty();
       $("#name").empty();
       $("#JORD_IN").empty();    
    }  
   
</script>



<body>
	<input type="hidden" id="currentPageDailyOrder" value="1">
	<input type="hidden" id="currentPageComnDtlCod" value="1">
	<input type="hidden" id="tmpGrpCod" value="">
	<input type="hidden" id="tmpGrpCodNm" value="">
	<input type="hidden" name="action" id="action" value="">

	<div id="refundDetails"></div>

	<!-- 모달 배경 -->
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
							<a href="/dashboard/dashboard.do" class="btn_set home">메인으로</a> <a
								href="#" class="btn_nav">작업지시서</a> <span class="btn_nav bold">배송
								지시서</span> <a href="../scm/shippingDirection.do"
								class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>배송 지시서</span> <span class="fr"> </span> <label
								style="margin-left: 67%">
								<input type="checkbox"	id="shippingDoneCheck" value="" > 배송 미완료 목록 조회</label> 
								
						</p>
						<div class="divComGrpCodList">
							<table class="col" id="shippingDirectionTable">
								<caption>caption</caption>
								<colgroup>
									<col width="5%">
									<col width="8%">
									<col width="10%">
									<col width="8%">
									<col width="5%">
									<col width="8%">
									<col width="5%">
								</colgroup>

								<thead>
									<tr>
										<th scope="col">주문 번호</th>
										<th scope="col">주문 제품</th>
										<th scope="col">주문 일자</th>
										<th scope="col">고객 기업</th>
										<th scope="col">주문 개수</th>
										<th scope="col">배송 희망 일자</th>
										<th scope="col">배송 상태</th>
									</tr>
								</thead>
								<tbody id="shippingDirectionList"></tbody>
							</table>
						</div>
						<div class="paging_area" id="orderListPagination"></div>


					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3> <jsp:include
						page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 모달팝업 -->
	<div id="deliDirection" class="layerPop layerType2"
		style="width: 900px;">
		<dl>
			<dt>
				<strong>배송 지시서</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->

				<table class="col" id="refundDiretionTable">
					<caption>caption</caption>
					<colgroup>

						<col width="8%">
						<col width="6%">
						<col width="8%">
						<col width="8%">
						<col width="6%">
						<col width="10%">
						<col width="7%">
						<col width="6%">
					</colgroup>

					<thead>
						<tr>
							<th scope="col">주문 일자</th>
							<th scope="col">주문 번호</th>
							<th scope="col">주문 기업</th>
							<th scope="col">주문 제품</th>
							<th scope="col">주문 수량</th>
							<th scope="col">배정 창고</th>
							<th scope="col">배송 담당자</th>
							<th scope="col">입금 여부</th>
						</tr>
					</thead>
					<tbody id="shipping_tbody">
					<tr>
							<td><a type="text" class="inputTxt p100" name="DIR_CODE"
								id="JORD_DATE" readonly="readonly" /></a></td>
							<td id="JORD_CODE"></td>
							<td id="PD_CORP"></td>
							<td id="PD_NAME"></td>
							<td id="JORD_AMT"></td>
							<td id="WH_NAME"></td>
							<td id="name"></td>
							<td id="JORD_IN"></td>
						</tr>
 							
 					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop" id="btnX"><span class="hidden">닫기</span></a>
	</div>

</body>
</html>