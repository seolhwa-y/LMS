<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Chain Maker :: 반품 지시서</title>
<c:if test="${sessionScope.userType ne 'B'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<link rel="stylesheet" href="${CTX_PATH}/css/chosen/chosen.css">
<script src="${CTX_PATH}/js/chosen/chosen.jquery.js"></script>

	<style>
 		input[name=date].datetype{
 			padding:4px 2px 5px 25px; width:95px; border:1px solid #CACACA;
      font-size:11px; color:#666; 
      background:url('http://cfile23.uf.tistory.com/image/26100D4F5864C76827F535') no-repeat 2px 2px; background-size:15px
    } 
    
    .chosen-container.chosen-container-single {
    width: 180px !important; /* or any value that fits your needs */
}
	</style>
	
</head>
<script type="text/javascript">
	// 페이징 설정
	var pageSize = 5;
	var pagenumSize = 5;
	
	
	// on Load
	$(function(){
		init();
	});
	
	// 초기화 실행
	function init(){
		$('#refundBtn').hide();
		fBtnClick();
		
		$("#sname").keydown(function (key) {
	        if (key.keyCode == 13) {
	            $("#searchBtn").click();
	            e.preventDefault();
	        	
	        }
    	});
	}

	// 버튼클릭 이벤트
	function fBtnClick(){
			$('a[name=btn]').click(function(e) {
				e.preventDefault();

				var btnId = $(this).attr('id');
				
				switch (btnId) {
	 				case 'searchBtn' :
	 					e.preventDefault();
	 					fReturnList(); 
	 					
						break;
				}
				switch (btnId) {
 				case 'refundBtn' :
 					refundUpdate()
					break;
			}
				
			});
		
	}
	
	// 반품지시서 목록조회
	function fReturnList(clickpagenum){
		$('#refundBtn').hide();
		$('#refundDtlList').hide();
		clickpagenum = clickpagenum || 1;
		
		/* 	// 날짜 유효성 체크 
	 	if($('#stDate').val().length != 10 || $('#edDate').val() is null){
			alert('올바른 날짜를 입력해 주세요.');
			return false;
		}
		if($('#edDate').val().length != 10 || ($('#stDate').val() is null){
			alert('올바른 날짜를 입력해 주세요.');
			return false;
		}  */
		
		// 넘겨줄 파라미터
		var param = {
				sname : $('#sname').val()
				,pageSize : pageSize
				,stDate : $('#stDate').val().replaceAll('-', '')
				,edDate : $('#edDate').val().replaceAll('-', '')
				,loginID : $('#loginID').val()
				,clickpagenum : clickpagenum
		}
		
		//콜백함수
		var searchcallback = function(returndata) {
			console.log("returndata : " + returndata);
			
			searchcallbackprocess(returndata,clickpagenum);
			
		}
		
		callAjax("/ship/refundList.do", "post", "text", true, param, searchcallback);
		
		// 페이징처리
		function searchcallbackprocess(returndata,clickpagenum) {
			
			$("#refundList").empty().append(returndata);
			
			var totalcnt = $("#refundListCnt").val();
			
			var paginationHtml = getPaginationHtml(clickpagenum, totalcnt, pageSize, pagenumSize, 'fReturnList');
			console.log("paginationHtml : " + paginationHtml);
			//swal(paginationHtml);
			$("#comnfileuploadPagination").empty().append( paginationHtml );
			
			$("#hclickpagenum").val(clickpagenum);
		}
		
	}
	
	
	// 	상세내역 조회
	function fdtlList(re_code, clickpagenum){
		
		$('#refundDtlList').show();
		// 재고처리 버튼 표시
		$('#refundBtn').show();
		
		
		$('#re_code').val(re_code);
		
		// 넘겨줄 파라미터
		var param = {
				re_code : re_code
				,pageSize : pageSize
				,clickpagenum : clickpagenum
		}
		// 콜백함수
		var searchcallback2 = function(returndata) {
			console.log("returndata : " + returndata);
			
			searchcallbackprocess2(returndata,clickpagenum);
			
		}
		
		callAjax("/ship/refundDtlList.do", "post", "text", true, param, searchcallback2);
		
		function searchcallbackprocess2(returndata,clickpagenum) {
			
			$("#refundDtlList").empty().append(returndata);
			
			var totalcnt = $("#refundDtlListCnt").val();
			
			var paginationHtml = getPaginationHtml(clickpagenum, totalcnt, pageSize, pagenumSize, 'fReturnDtlList');
			console.log("paginationHtml : " + paginationHtml);
			//swal(paginationHtml);
			$("#comnfileuploadPagination2").empty().append( paginationHtml );
			
			$("#hclickpagenum").val(clickpagenum);
		}
		
	}
	
	// 재고처리
	function refundUpdate(){
		// 발주일자 초기화
		$('#re_date').val();
		// 유효성 검사
		if(confirm('재고처리를 하시겠습니까?')){
			if($('#re_date').val() == ''){
				var param = {
						dtl_re_code : $('#dtl_re_code').val()
						,model_code : $('#model_code').val()
						,wh_code : $('#wh_code').val()
						,re_amt : $('#re_amt').val()
						,loginID : $('#loginID').val()
					}
					
					var callback = function(returndata) {
						
							alert("처리완료")
							fReturnList();
					} 
					
					 callAjax("/ship/refundUpdate.do", "post", "json", true, param, callback);
					
				}
			else{
				alert('이미 재고처리된 건입니다.');
			}
		}
		else{
			
			return false;
			
		}
		
	}
	
	
</script>
<body>
	
	<input type="hidden" id="selectedRefundNo" value="-1">
	<input type="hidden" id="hclickpagenum" name="hclickpagenum"  value="" />
	<input type="hidden" id="re_code" value="">

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
							<a href="/dashboard/dashboard.do" class="btn_set home">메인으로</a> <a href="#"
								class="btn_nav">기업고객</a> <span class="btn_nav bold">반품 지시서</span> <a href="../dlm/refundBuyer.do" class="btn_set refresh">새로고침</a>
						</p>
						
						<p class="conTitle">
							<span>반품 지시서</span> <span class="fr"> 
							</span>
							
								<label style="margin-left: 3%">업체명      </label> 
								<input type="text" style=" height:35%;  width:25%; margin-left: 1%" id="sname">
								
								
								<label style="margin-left: 5%">반품일자      </label> 
								<input class="datetype" style="margin-left: 1%" type="date" name = "date" id="stDate" >
								<input class="datetype" type="date" name = "date" id="edDate" >
								
								<a href="" class="btnType blue" id="searchBtn" name="btn" style="margin-left: 2%"><span>검색</span></a>
						</p>
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="5%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
								</colgroup>

								<thead>
									<tr>
										<th scope="col">No.</th>
										<th scope="col">업체명</th>
										<th scope="col">총액</th>
										<th scope="col">반품처리일</th>
									</tr>
								</thead>
								<tbody id="refundList"></tbody>
							</table>
						</div>
						<div class="pagingArea" id="comnfileuploadPagination"></div>


						<p class="conTitle">
							<span>상세 내역</span> <span class="fr"> 
							</span>
						</p>
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="3%">
									<col width="8%">
									<col width="8%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">

								</colgroup>

								<thead>
									<tr>
										<th scope="col">반품번호</th>
										<th scope="col">장비번호</th>
										<th scope="col">장비구분</th>
										<th scope="col">모델번호</th>
										<th scope="col">모델명</th>
										<th scope="col">제조사</th>
										<th scope="col">수량</th>
										<th scope="col">판매가격</th>

									</tr>
								</thead>
								<tbody id="refundDtlList"></tbody>
							</table>
							<div class="pagingArea" id="comnfileuploadPagination2"></div>
							<div style = "float : right">
							<a id="refundBtn" name = "btn" class="btnType blue" ><span>재고 처리</span></a>
							</div>
						</div>
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3> <jsp:include
						page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

</body>
</html>