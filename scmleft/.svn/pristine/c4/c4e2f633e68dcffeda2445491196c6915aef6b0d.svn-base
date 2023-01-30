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
	var returnPageSize = 5;
	var returnPageBlock = 5;

	/*OnLoad event */
	$(function() {
		//반품지시서 목록 조회
		//fSelectReturnDirList();
		
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

	
	
	//리스트 콜백함수 뿌리기, 페이징
    function returnDirListResult(data, currentPage) {
    	console.log(data);
    	
    	$("#returnDirList").empty().append(data);
    	
    	var totalCnt = $("#totalCnt").val();
    	
    	var list = $("#tmpList").val();

    	
		var pagingnavi = getPaginationHtml(currentPage, totalCnt, returnPageSize, returnPageBlock, 'board_search', [list]);
		console.log("pagingnavi : " + pagingnavi);
		//(paginationHtml);
		$("#pagingnavi").empty().append(pagingnavi );
		$("#currentPage").val(currentPage);
		
		// 현재 페이지 설정
		//$("#returnDirList").val(currentPage);
	
    	
    }		

 
	/** 검색기능 */
	 function board_search(currentPage) {

		currentPage = currentPage || 1;
		
		var searchKey = document.getElementById('searchKey');
		var cpname = $('#cpname').val();		
		var sdate = $('#sdate').val();
		var edate = $('#edate').val();
		
		
		
		console.log("searchKey : " + searchKey);
		console.log("cpname : " + cpname);
		console.log("sdate : " + sdate);
		console.log("edate : " + edate);
		
		var param = {
			searchKey : searchKey,
			cpname : cpname,			
			sdate : sdate.replaceAll("-",""),
			edate : edate.replaceAll("-",""),
			currentPage : currentPage,
			pageSize : returnPageSize

		}
		var resultCallBack = function(data){
			returnDirListResult(data, currentPage);
		}
		callAjax("/scm/returnDirList.do", "post", "text", true, param, resultCallBack );
	} 
	


	
</script>
</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="currentPage" value="1"> 
		<input type="hidden" id="tmpList" value=""> 
		<input type="hidden" name="action" id="action" value="">
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
								<a class="btn_nav">작업지시서</a>
								 <span class="btn_nav bold">반품지시서</span> 
								<a href="" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>반품 지시서</span>
								<span class="fr"> 									
								</span>
							</p>

							<div class="ReturnDirList">
							<div class="conTitle" style="margin: 0 25px 10px 0; " align=center>
								<!-- <label>
									<input type="checkbox" id="delcheck" name="delcheck" value="del">
									삭제된 정보 표시
								</label>  -->
							
						    <!-- enter입력하면 검색실행   -->
						    <span>기업 고객명</span>
							<input type="text" style="width: 160px; height: 30px;" id="cpname" name="cpname" onkeypress="if( event.keyCode == 13 ){board_search();}">  
							<input type="date" style="width: 160px; height: 30px;" id="sdate" name="sdate" onkeypress="if( event.keyCode == 13 ){board_search();}">  
							<input type="date" style="width: 160px; height: 30px;" id="edate" name="edate" onkeypress="if( event.keyCode == 13 ){board_search();}">  
							<a href="javascript:board_search()" class="btnType blue" id="searchBtn" name="btn" ><span>검  색</span></a>
									
									</div>
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="15%">
										<col width="15%">
										<col width="20%">
										<col width="10%">
										<col width="15%">
										<col width="10%">
										<col width="10%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">주문일자</th>
											<th scope="col">기업고객명</th>
											<th scope="col">제품명</th>
											<th scope="col">반품 개수</th>
											<th scope="col">금액</th>
											<th scope="col">임원</th>
											<th scope="col">승인여부</th>											
										</tr>
									</thead>
									<tbody id="returnDirList"></tbody>
								</table>
								
								<!-- 페이징 처리 -->
								
								<div class="paging_area" id="pagingnavi">
									<div class="paging">									
										<a class="first" href="javascrip:board_search(1)">
											<span class="hidden">맨앞</span>
										</a>
										<a class="pre" href="javascrip:board_search(1)">
											<span class="hidden">이전</span>
										</a>
										<strong>1</strong>
										<a  href="javascrip:board_search(2)">2</a>
										<a  href="javascrip:board_search(3)">3</a>
										<a  href="javascrip:board_search(4)">4</a>
										<a class="next" href="javascrip:board_search(5)">5</a>
										<a class="last" href="javascrip:board_search(5)">
											<span class="hidden">맨뒤</span>
										</a>
									</div>									
								</div>
								 
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