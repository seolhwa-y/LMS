<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Chain Maker :: SupplierInfo</title>
<c:if test="${sessionScope.userType ne 'A'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">
	/*납품업체 페이징 처리*/
	var pageSizeDelivery = 5;
	var pageBlockSizeDelivery = 5;

	//제품정보 페이징 처리
	var pageSizeProduct = 5;
	var pageBlockSizeProduct = 5;

	/*OnLoad event*/
	$(function() {
		//납품업체 목록 조회
		fListDelivery();
		//삭제된 목록 표시 체크 클릭 이벤트
		//checkClickEvent();
		//버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			//alert("btnId : " + btnId);

			switch (btnId) {
			case 'searchBtn':
				board_search(); // 검색하기
				break;
			case 'btnSaveDelivery'://저장하기
				fSaveDelivery();
				break;
			/* case 'btnDeleteDelivery'://삭제하기
				fDeleteDelivery();
			 	break;
			case 'btnRecoveryDelivery': //복원하기
				fRecoveryDelivery();
				break; */
			case 'btnCloseDelivery': //닫기
				gfCloseModal();
				break;
			}
		});

	}

	/** 납품업체 폼 초기화 */
	function fInitFormDelivery(object) {
		$("#deli_company").focus();
		
		console.log("object :" + JSON.stringify(object));
		if (object == "" || object == null || object == undefined) {
			$("#deli_no").val("");
			$("#deli_no").attr("readonly", true);
			$("#deli_company").val("");
			$("#deli_id").val("");
			$("#deli_password").val("");
			$("#deli_name").val("");
			$("#deli_phone").val("");
			$("#deli_email").val("");
			$("#btnDeleteDelivery").hide();
			$("#btnRecoveryDelivery").hide();

		} else{
			$("#deli_no").val(object.deli_no);
			$("#deli_no").attr("readonly", true);
			$("#deli_company").val(object.deli_company);
			$("#deli_id").val(object.deli_id);
			$("#deli_password").val(object.deli_password);
			$("#deli_name").val(object.deli_name);
			$("#deli_phone").val(object.deli_phone);
			$("#deli_email").val(object.deli_email);
			/* if(object.del_cd == "0"){ 
				$("#btnDeleteDelivery").show();
				$("#btnRecoveryDelivery").hide();
			} else {
				$("#btnDeleteDelivery").hide();
				$("#btnRecoveryDelivery").show();
			} */
		} 
	}
	/** 납품업체 저장 validation */
	function fValidateDelivery() {
		var chk = checkNotEmpty([ 
		        [ "deli_company", "납품 업체명을 입력하세요." ],
				[ "deli_id", "Login ID를 입력하세요." ],
				[ "deli_password", "비밀번호룰 입력하세요." ],
				[ "deli_name", "담당자명을 입력하세요." ],
				[ "deli_phone", "담당자 연락처를 입력하세요." ], 
				[ "deli_email", "담당자 이메일을 입력하세요." ] 
		       ]);
		if (!chk) {
			return;
		}
		return true;
	}
	/** 납품업체 모달 실행 */
	function fPopModalDelivery(deli_no) {

		//신규 저장
		if (deli_no == null || deli_no == "") {

			$("#action").val("I");
			fInitFormDelivery();

			gfModalPop("#layer1");
		} else {
			$("#action").val("U");

			fSelectDelivery(deli_no);
		}
	}
	//납품 업체 단건 조회
	function fSelectDelivery(deli_no) {
		var param = {
			deli_no : deli_no
		};

		var resultCallback = function(data) {
			fSelectDeliveryResult(data);
		};

		callAjax("/scm/selectDelivery.do", "post", "json", true, param,
				resultCallback);
	}

	//납품 업체 단건 조회 콜백 함수
	function fSelectDeliveryResult(data) {
		if (data.result == "SUCCESS") {

			gfModalPop("#layer1")

			fInitFormDelivery(data.supplierInfoModel);
		} else {
			alert(data.resultMsg);
		}
	}

	//납품업체 저장
	function fSaveDelivery() {

		//validation 체크
		if (!fValidateDelivery()) {
			return;
		}

		var resultCallback = function(data) {
			console.log(data);
			fSaveDeliveryResult(data);
		};
		callAjax("/scm/saveDelivery.do", "post", "json", true, $("#myForm")
				.serialize(), resultCallback);
	}

	//납품 업체 저장 콜백 함수
	function fSaveDeliveryResult(data) {

		var currentPage = "1";
		if ($("#action").val() != "I") {
			currentPage = $("#currentPageDelvery").val();
		}

		if (data.result == "SUCCESS") {
			alert(data.resultMsg);
			gfCloseModal();

			fListDelivery(currentPage);
		} else {
			alert(data.resultMsg);
		}
		fInitFormDelivery();

	}
	
	//납품 업체 삭제
	/* function fDeleteDelivery(deli_no){
		var con = confirm("삭제하시겠습니까 ?");
		var currentPage = "1";
		if (con){
			var resultCallback = function(data) {
			fSaveDeliveryResult(data);
		}
		$("#action").val("D");
		callAjax("/scm/saveDelivery.do", "post", "json", true, $("#myForm").serialize(), resultCallback );
		} else {
			gfCloseModal();
			fListDelivery(currentPage);
			fInitFormDelivery();
		}
	} */
	
	//납품 업체 복구
	/* function fRecoveryDelivery(deli_no){
		var con = confirm("복원하시겠습니까 ?");
		var currentPage = "1";
		if (con){
			var resultCallback = function(data) {
			fSaveDeliveryResult(data);
	}
	$("#action").val("R");
	callAjax("/scm/saveDelivery.do", "post", "json", true, $("#myForm").serialize(), resultCallback );
	} else {
		gfCloseModal();
		fListDelivery(currentPage);
		fInitFormDelivery();
		}
	} */

	//검색 기능
	function board_search(currentPage) {

		$('#listProduct').empty();

		currentPage = currentPage || 1;

		var sname = $('#sname');
		var searchKey = document.getElementById("searchKey");
		var oname = searchKey.options[searchKey.selectedIndex].value;
		
		/*  if ($("input:checkbox[name=delcheck]").is(":checked") == true) {
             //체크가 되어있을때.
             console.log('체크되었씁니당.');
             var del_cd = 1;
     } else {
             //체크가 안되어있을때.
	        	 console.log('체크 해지용.');
	        	 var del_cd = 0;
     } */

		var param = {
			sname : sname.val(),
			oname : oname,
			currentPage : currentPage,
			pageSize : pageSizeDelivery,
			//del_cd : del_cd
		}
		
		

		var resultCallback = function(data) {
			flistDeliveryResult(data, currentPage);

		};

		callAjax("/scm/listDelivery.do", "post", "text", true, param,
				resultCallback);
	}

	/*납품 업체  조회*/
	function fListDelivery(currentPage) {

		currentPage = currentPage || 1;
		var sname = $('#sname');
		var searchKey = document.getElementById("searchKey");
		var oname = searchKey.options[searchKey.selectedIndex].value;
		

		console.log("currentPage : " + currentPage);
		
		 /* if ($("input:checkbox[name=delcheck]").is(":checked") == true) {
            //체크가 되어있을때.
            var del_cd = 1;
  			  } else {
            //체크가 안되어있을때.
        	 var del_cd = 0;
    		}  */

		var param = {
			sname : sname.val(),
			oname : oname,
			currentPage : currentPage,
			pageSize : pageSizeDelivery,
			//del_cd : del_cd
		}

		var resultCallback = function(data) {
			flistDeliveryResult(data, currentPage);
		}

		callAjax("/scm/listDelivery.do", "post", "text", true, param,
				resultCallback);
	}

	/*납품업체 조회 콜백 함수*/
	function flistDeliveryResult(data, currentPage) {

		//alert(data);
		console.log(data);
		//기존 목록 삭제
		$('#listDelivery').empty();

		$("#listDelivery").append(data);

		// 총 개수 추출
		var totalDelivery = $("#totalDelivery").val();

		//페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalDelivery,
				pageSizeDelivery, pageBlockSizeDelivery, 'fListDelivery');

		$("#deliveryPagination").empty().append(paginationHtml);
		//현재 페이지 설정

		console.log("totalDelivery: " + totalDelivery);
		$("#currentPageDelivery").val(currentPage);
	}

	/*제품 목록 조회*/
	function fListProduct(currentPage, deli_company, deli_no) {
		//납품업체명 매개변수 설정
		currentPage = currentPage || 1;

		$("#tmpdeli_company").val(deli_company);
		$("#tmpdeli_no").val(deli_no);

		var param = {
				deli_company : deli_company //납품업체명 변수설정
			,	deli_no : deli_no
			,	currentPage : currentPage
			,	pageSize : pageSizeProduct

		}
		//console.log("param:" + JSON.stringify(param));
		
		
		console.log("deli_company : " + deli_company);
		console.log("deli_no : " + deli_no);

		var resultCallback = function(data) {
			flistProductResult(data, currentPage);
		};

		callAjax("/scm/listProduct.do", "post", "text", true, param,
				resultCallback);
	}

	/*제품목록 조회 콜백 함수*/
	function flistProductResult(data, currentPage) {

		//기존 목록 삭제
		$('#listProduct').empty();

		// 신규 목록 생성

		$("#listProduct").append(data);
		//$("#listProduct").append($listProduct.children());	

		// 총 개수 추출
		var totalProduct = $("#totalProduct").val();

		//페이지 네비게이션 생성
		var deli_company = $("#tmpdeli_company").val();
		var deli_no = $("#tmpdeli_no").val();

		var paginationHtml = getPaginationHtml(currentPage, totalProduct,
				pageSizeProduct, pageBlockSizeProduct, 'fListProduct', [
						deli_company, deli_no ]);
		console.log("paginationHtml : " + paginationHtml);
		$("#productPagination").empty().append(paginationHtml);

		console.log("totalProduct: " + totalProduct);
		// 현재 페이지 설정
		$("#currentPageProduct").val(currentPage);

	}
	
	//삭제된 정보 표시 체크
	/* function checkClickEvent(currentPage) {
		currentPage = currentPage || 1;
		
		$("#delcheck").change(
				function() {
					
					if ($("#delcheck").is(":checked")) {
						$("#sname").val("");
						var del_cd = 1;

						var param = {
							currentPage : currentPage,
							pageSize : pageSizeDelivery,
							del_cd : del_cd
						}

						var resultCallback = function(data) {
							flistDeliveryResult(data, currentPage);
						};

						callAjax("/scm/listDelivery.do", "post", "text", true,
								param, resultCallback);

					} else {
						$("#sname").val("");
						var del_cd = 0;

						var param = {
							currentPage : currentPage,
							pageSize : pageSizeDelivery,
							del_cd : del_cd
						}

						var resultCallback = function(data) {
							flistDeliveryResult(data, currentPage);
						};

						callAjax("/scm/listDelivery.do", "post", "text", true,
								param, resultCallback);
					}
				});
	} */
</script>
</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="currentPageDelivery" value="1"> 
		<input type="hidden" id="currentPageProduct" value="1"> 
		<input type="hidden" id="tmpdeli_company" value=""> 
		<input type="hidden" id="tmpdeli_no" value=""> 
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
								<a class="btn_nav">기준 정보</a>
								 <span class="btn_nav bold">납품 업체 정보</span> 
								<a href="" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>납품 업체 정보</span>
								<span class="fr"> 
									
									
									<a href="javascript:fPopModalDelivery()" class="btnType blue" name="modal">
									<span>신규등록</span>
									</a>
								</span>
							</p>


							<div class="DeliveryList">
							<div class="conTitle" style="margin: 0 25px 10px 0; float: right;">
								<!-- <label>
									<input type="checkbox" id="delcheck" name="delcheck" value="del">
									삭제된 정보 표시
								</label>  -->
							<select id="searchKey" name="searchKey" style="width: 100px;" v-model="searchKey">
										<option value="del_nm" selected="selected">납품 업체</option>
										<option value="pro_nm">제품명</option>
									</select> 
									<input type="text" style="width: 160px; height: 30px;" id="sname" name="sname">
									<a href="" class="btnType blue" id="searchBtn" name="btn"> 
										<span>검 색</span>
									</a> 
									</div>
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="5%">
										<col width="9%">
										<col width="9%">
										<col width="6%">
										<col width="5%">
										<col width="10%">
										<col width="9%">
										<col width="6%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">번호</th>
											<th scope="col">납품업체명</th>
											<th scope="col">LOGINID</th>
											<th scope="col">패스워드</th>
											<th scope="col">담당자명</th>
											<th scope="col">담당자 연락처</th>
											<th scopt="col">담당자 이메일</th>
											<th scope="col">비고</th>
										</tr>
									</thead>
									<tbody id="listDelivery"></tbody>
								</table>
							</div>

							<div class="paging_area" id="deliveryPagination"></div>

							<p class="conTitle mt50">
								<span>제품 정보</span>
							</p>


							<div class="ProductList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="36%">
										<col width="32%">
										<col width="32%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">제품번호</th>
											<th scope="col">제품명</th>
											<th scope="col">납품단가</th>
										</tr>
									</thead>
									<tbody id="listProduct">
										<tr>
											<td colspan="12">납품 업체를 선택해 주세요.</td>
										</tr>
									</tbody>
								</table>
							</div>

							<div class="paging_area" id="productPagination"></div>


						</div> <!--// content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>
		<!-- 모달! -->
		<div id="layer1" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>납품 업체 관리</strong>
				</dt>
				<dd class="content">
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
								<th scope="row">납품 업체 번호 <span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="deli_no" id="deli_no" /></td>
							</tr>
							<tr>
								<th scope="row">납품업체명 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100"
									name="deli_company" id="deli_company" /></td>
								<th scope="row">LoginID<span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="deli_id"
									id="deli_id" /></td>
							</tr>
							<tr>
								<th scope="row">패스워드 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100"
									name="deli_password" id="deli_password" /></td>
								<th scope="row">담당자명 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100"
									name="deli_name" id="deli_name" /></td>
							</tr>
							<tr>
								<th scope="row">담당자 연락처 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100"
									name="deli_phone" id="deli_phone" /></td>
									<th scope="row">담당자 이메일 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100"
									name="deli_email" id="deli_email" /></td>
							</tr>
							<!-- <tr class="hidden">
								<th scope="row">삭제여부 <span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="del_cd" id="del_cd" /></td>
							</tr> -->

						</tbody>
					</table>


					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSaveDelivery" name="btn"><span>저장</span></a>
						<!-- <a href="" class="btnType blue" id="btnDeleteDelivery" name="btn"><span>삭제</span></a>
						<a href="" class="btnType blue" id="btnRecoveryDelivery"
							name="btn"><span>복원</span></a> <a href="" class="btnType gray"
							id="btnCloseDelivery" name="btn"><span>취소</span></a> -->
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>

	</form>
</body>
</html>