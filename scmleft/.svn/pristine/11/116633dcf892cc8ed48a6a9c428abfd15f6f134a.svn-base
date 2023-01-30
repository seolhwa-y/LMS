<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Chain Maker :: SupplierInfo</title>
<c:if test="${sessionScope.userType ne 'A'}">
	<c:redirect url="/dashboard/dashboard.do" />
</c:if>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">
	/*납품업체 페이징 처리*/
	var pageSizeSupplier = 5;
	var pageBlockSizeSupplier = 5;

	//제품정보 페이징 처리
	var pageSizeProduct = 5;
	var pageBlockSizeProduct = 5;

	var supplierarea;
	var productarea;

	var suppliereditvue;

	var searcharea;

	/*OnLoad event*/
	$(document).ready(function() {

		init();

		// 납품 업체 목록 조회
		fsupplierlist();

		// 제품 정보 목록 조회
		fProductList();

		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});

	function init() {

		supplierarea = new Vue({
			el : '#supplier',
			data : {
				SupplierListItem : [],
				action : "",
				loginID : ""
			},
			methods : {
				ListProduct : function(loginID) {
					this.loginID = loginID;
					productarea.a = false;

					fProductList();
				},
				DetailSupplier : function(loginID) {
					fDetailSupplier(loginID);
				}

			}
		});

		productarea = new Vue({
			el : '#product',
			data : {
				ProductListItem : [],
				a : true,
			}
		});

		suppliereditvue = new Vue({
			el : '#suppliersave',
			data : {
				napcode : "",
				company : "",
				loginID : "",
				password : "",
				name : "",
				hp : "",
				email : "",
				napcoderead : true,
				companyread : "",
				loginIDread : true,
				passwordread : "",
				nameread : "",
				hpread : "",
				emailread : ""
			}
		});

		searcharea = new Vue({
			el : '#searcharea',
			data : {
				select : "supplier",
				search : ""
			}
		})

	}

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			//alert("btnId : " + btnId);

			switch (btnId) {
			case 'searchBtn':
				fsupplierlist(); // 검색하기
				fProductList();
				break;
			case 'btnSaveSupplier'://저장하기
				fSupplierSave();
				break;
			case 'btnUpdateSupplier':
				fSupplierModal();
				break;
			case 'btnCloseDelivery': //닫기
				gfCloseModal();
				break;
			}
		});

	}

	//납품 업체 목록 조회
	function fsupplierlist(currentPage) {

		currentPage = currentPage || 1;

		var param = {
			select : searcharea.select,
			search : searcharea.search,
			currentPage : currentPage,
			pageSize : pageSizeSupplier,
		}

		console.log(searcharea.search);

		var resultCallback = function(data) {

			console.log("resultCallback : " + JSON.stringify(data));

			fsupplierlistresult(data, currentPage);

		}
		callAjax("/scm/SupplierListVue.do", "post", "json", true, param,
				resultCallback);

	}

	// 납품 업체 목록 조회 콜백
	function fsupplierlistresult(data, currentPage) {

		supplierarea.SupplierListItem = data.SupplierList;

		console.log(searcharea.search);
		console.log(searcharea.select);

		// 총 개수 추출
		var totalSupplierCnt = data.SupplierCnt;
		var list = $("#currentPageSupplier").val();

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalSupplierCnt,
				pageSizeSupplier, pageBlockSizeSupplier, 'fsupplierlist',
				[ list ]);

		$("#SupplierPagination").empty().append(paginationHtml);
	}

	// 납품 업체 단건 조회
	function fDetailSupplier(loginID) {

		console.log(loginID);

		var param = {
			loginID : loginID
		};

		var resultCallBack3 = function(data) {
			console.log("resultCallBack3 : " + JSON.stringify(data));
			fDetailSupplierResult(data);
		}

		callAjax("/scm/DetailSupplier.do", "post", "json", true, param,
				resultCallBack3);
	}

	function fDetailSupplierResult(data) {

		console.log("Aa : " + JSON.stringify(data));

		if (data.resultMsg == "SUCCESS") {
			supplierarea.action = "U";

			gfModalPop("#suppliersave");

			fSupplierModal(data.result);
		} else {
			alert(data.resultMsg);
		}
	}

	// 납품 업체 신규 등록
	function fSupplierNew() {

		supplierarea.action = "I";

		console.log("action : " + supplierarea.action);

		gfModalPop('#suppliersave');

		fSupplierModal();

	}

	// 팝업(신규등록 및 수정)
	function fSupplierModal(object) {

		console.log(object);

		console.log("fSupplierModal action : " + supplierarea.action);

		if (supplierarea.action == "I") {
			suppliereditvue.napcode = "";
			suppliereditvue.company = "";
			suppliereditvue.loginID = "";
			suppliereditvue.password = "";
			suppliereditvue.name = "";
			suppliereditvue.hp = "";
			suppliereditvue.email = "";

			suppliereditvue.loginIDread = false;
			suppliereditvue.napcoderead = false;
		} else {
			console.log(object.company);
			suppliereditvue.napcode = object.napcode;
			suppliereditvue.company = object.company;
			suppliereditvue.loginID = object.loginID;
			suppliereditvue.password = object.password;
			suppliereditvue.name = object.name;
			suppliereditvue.hp = object.hp;
			suppliereditvue.email = object.email;

			suppliereditvue.loginIDread = true;
			suppliereditvue.napcoderead = true;

		}

	}

	// 납품 업체 저장 및 수정
	function fSupplierSave() {

		console.log("action : " + supplierarea.action);

		var param = {
			action : supplierarea.action,
			napcode : suppliereditvue.napcode,
			company : suppliereditvue.company,
			loginID : suppliereditvue.loginID,
			password : suppliereditvue.password,
			name : suppliereditvue.name,
			hp : suppliereditvue.hp,
			email : suppliereditvue.email
		}

		console.log(param);

		var saveCallBack = function(saveReturn) {

			console.log("saveCallBack : " + JSON.stringify(saveReturn));

			if (saveReturn.resultMsg == "SUCCESS"
					|| saveReturn.resultMsg == "UPDATE") {
				alert("저장");
				gfCloseModal();

				fsupplierlist();
			} else {
				alert("실패");
			}
		}
		callAjax("/scm/SupplierSave.do", "post", "json", true, param,
				saveCallBack);
	}

	// 제품 정보 목록 조회
	function fProductList(currentPage) {

		console.log(currentPage);
		var currentPage = currentPage || 1;

		var param = {
			loginID : supplierarea.loginID,
			select : searcharea.select,
			search : searcharea.search,
			currentPage : currentPage,
			pageSize : pageSizeProduct,
		}

		console.log(param);
		console.log("loginID : " + loginID);

		var ProductListVueCallBack = function(data) {

			console.log("ProductListVueCallBack : " + JSON.stringify(data));

			fProductLsitResult(data, currentPage);
		}

		callAjax("/scm/ProductListVue.do", "post", "json", true, param,
				ProductListVueCallBack);
	}

	// 제품 정보 콜백 
	function fProductLsitResult(data, currentPage) {

		productarea.ProductListItem = data.ProductList;

		var totalProductCnt = data.ProductCnt;
		var list = $("#currentPageProduct").val();

		console.log(data);
		//$("loginID").val(data.loginID);

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalProductCnt,
				pageSizeProduct, pageBlockSizeProduct, 'fProductList',
				[ data.loginId ]);

		$("#ProductPagination").empty().append(paginationHtml);

		console.log(paginationHtml);

	}
</script>
</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="currentPage" value="1"> <input
			type="hidden" id="currentPageSupplier" value="1"> <input
			type="hidden" id="currentPageProduct" value="1">
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
								<a class="btn_nav">기준 정보</a> <span class="btn_nav bold">납품
									업체 정보</span> <a href="" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>납품 업체 정보</span> <span class="fr"> <a
									href="javascript:fSupplierNew()" class="btnType blue"
									name="modal"> <span>신규등록</span>
								</a>
								</span>
							</p>

							<div id="searcharea" style="margin: 0 25px 10px 0; float: right;">
								<select id="select" name="select" style="width: 100px;"
									v-model="select">
									<option value="supplier" selected="selected">납품 업체</option>
									<option value="product">제품명</option>
								</select> <input type="text" style="width: 160px; height: 30px;"
									id="search" name="search" v-model="search"> <a href=""
									class="btnType blue" id="searchBtn" name="btn"> <span>검색</span>
								</a>
							</div>

							<div id="supplier">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="5%">
										<col width="9%">
										<col width="9%">
										<col width="6%">
										<col width="10%">
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
											<th scope="col">담당자 이메일</th>
											<th scope="col">비고</th>
										</tr>
									</thead>

									<tbody v-for="(item, index) in SupplierListItem"
										v-if="SupplierListItem.length">
										<tr @click="ListProduct(item.loginID)">
											<td>{{ item.napcode }}</td>
											<td>{{ item.company }}</td>
											<td>{{ item.loginID }}</td>
											<td>{{ item.password }}</td>
											<td>{{ item.name }}</td>
											<td>{{ item.hp }}</td>
											<td>{{ item.email }}</td>
											<td><a @click="DetailSupplier(item.loginID)"
												class="btnType blue" id="btnUpdateSupplier" name="btn"><span>수정</span></a></td>
										</tr>
									</tbody>
								</table>
							</div>

							<div class="paging_area" id="SupplierPagination"></div>

							<p class="conTitle mt50">
								<span>제품 정보</span>
							</p>


							<div id="product">
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
											<th scope="col">제조사</th>
										</tr>
									</thead>
									<tbody id="productlist">
										<tempete v-if="ProductListItem.length">
										<tr v-for="(item, index) in ProductListItem">
											<td>{{ item.pd_CODE }}</td>
											<td>{{ item.pd_NAME }}</td>
											<td>{{ item.pd_CORP }}</td>
										</tr>
										</tempete>
										<tr v-show="a">
											<td colspan="12">납품 업체를 선택해 주세요.</td>
										</tr>
									</tbody>
								</table>
							</div>

							<div class="paging_area" id="ProductPagination"></div>


						</div> <!--// content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>
		<!-- 모달! -->
		<div id="suppliersave" class="layerPop layerType2"
			style="width: 600px;">
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
								<td colspan="3">
								<templete v-if="napcoderead"> 
								<input type="text" class="inputTxt p100" name="napcode" id="napcode"
										v-model="napcode" readonly /> 
								</templete> 
								<templete v-else> 
								<input type="text" class="inputTxt p100" name="napcode" id="napcode"
										v-model="napcode" /> 
								</templete>
								</td>
							</tr>
							<tr>
								<th scope="row">납품업체명 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="company"
									id="company" v-model="company" /></td>
								<th scope="row">LoginID<span class="font_red">*</span></th>
								<td><templete v-if="loginIDread"> <input
										type="text" class="inputTxt p100" name="loginID" id="loginID"
										v-model="loginID" readonly /> </templete> <templete v-else> <input
										type="text" class="inputTxt p100" name="loginID" id="loginID"
										v-model="loginID" /> </templete></td>
							</tr>
							<tr>
								<th scope="row">패스워드 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100"
									name="password" id="password" v-model="password" /></td>
								<th scope="row">담당자명 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="name"
									id="name" v-model="name" /></td>
							</tr>
							<tr>
								<th scope="row">담당자 연락처 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="hp"
									id="hp" v-model="hp" /></td>
								<th scope="row">담당자 이메일 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="email"
									id="email" v-model="email" /></td>
							</tr>
							<!-- <tr class="hidden">
								<th scope="row">삭제여부 <span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="del_cd" id="del_cd" /></td>
							</tr> -->

						</tbody>
					</table>


					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSaveSupplier" name="btn"><span>저장</span></a>
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