<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: SCM</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://unpkg.com/axios@0.12.0/dist/axios.min.js"></script>
<script src="https://unpkg.com/lodash@4.13.1/lodash.min.js"></script>
<!-- D3 -->
<style>
//
click-able rows
	.clickable-rows {tbody tr td { cursor:pointer;
	
}

.el-table__expanded-cell {
	cursor: default;
}
}
</style>
<script type="text/javascript">
	var pageSizeinf = 10;
	var pageBlockSizeinquiry = 10;

	var noticeareavar;
	var noticeeditvue;
	
	var searcharea;

	$(document).ready(function() {

		init();

		// 공지사항 조회
		fListInf();

		// 버튼 이벤트
		fRegisterButtonClickEvent();
		
		
	});

	function init() {

		Vue.component('my-component', {
			template : '<div>전역 컴포넌트</div>'
		});

		noticeareavar = new Vue({
			el : '#divNoticeList',
			components : {
				'bootstrap-table' : BootstrapTable
			},
			data : {
				listitem : [],
				action : ""
			},
			methods : {
				detailview : function(no) {
					alert(no);
					fNoticeMgrModal(no);
				}
			}
		});

		noticeeditvue = new Vue({
			el : '#notice',
			data : {
				loginId : "",
				noticeNo : "",
				noticeView : "",
				noticeTitle : "",
				noticeContent : "",
				loginIdread : "",
				noticeTitleread : "",
				noticeContentread : "",
				delflag : true
			}
		});
		
		searcharea = new Vue({
			el : '#searcharea',
			data : {
				select : "",
				search : ""
			}
		});

	}

	// 버튼 이벤트 등록
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
			switch (btnId) {
				case 'btnClose':
					gfCloseModal();
					fListInf()
					break;
				case 'btnSave' :
					fn_noticeMgrSave();
					break;
				case 'btnDelete' :
					fn_noticeMgrDelete();
					break;

			}
		});
	}

	// 공지사항 조회
	function fListInf(currentPage) {
		
		currentPage = currentPage || 1;
		
		var sdate = $('#sdate').val();
		var edate = $('#edate').val();
		

		var param = {
			currentPage : currentPage,
			pageSize : pageSizeinf,
			select : searcharea.select,
			search : searcharea.search,
			sdate : sdate.replaceAll("-",""),
			edate : edate.replaceAll("-","")
		}

		var resultCallback = function(data) {

			console.log("resultCallback : " + JSON.stringify(data));

			fListInfResult(data, currentPage);
			

		}
		
		//console.log(edate.replaceAll);

		callAjax("/scm/noticeMgrListvue.do", "post", "json", true, param, resultCallback);
	}

	/** 공지사항 조회 콜백 함수 */
	function fListInfResult(data, currentPage) {

		//console.log("asd"+data);		
		noticeareavar.listitem = data.noticeMgr;

		// 총 개수 추출
		var totalCntlistInf = data.noticeCnt;
		var list = $("#selectedInfNo").val();
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCntlistInf,
				pageSizeinf, pageBlockSizeinquiry, 'fListInf', [ list ]);
		//console.log("paginationHtml : " + paginationHtml);

		$("#listInfPagination").empty().append(paginationHtml);
		

	}

	// 공지사항 신규
	function fn_noticereg() {
		//console.log("신규버튼")
		
		noticeareavar.action = "I";

		frealPopModal();

		gfModalPop("#notice");
	}

	// 팝업(초기화 페이지 or 내용 뿌리기)
	function frealPopModal(object) {

		if (noticeareavar.action == "I") {
			noticeeditvue.loginId = "";
			noticeeditvue.noticeNo = "";
			noticeeditvue.noticeTitle = "";
			noticeeditvue.noticeContent = "";
			
			noticeeditvue.delflag = false;

		} else {
			noticeeditvue.loginId = object.name;
			noticeeditvue.noticeNo = object.notcode;
			noticeeditvue.noticeTitle = object.nottitle;
			noticeeditvue.noticeContent = object.noticeContent;

			noticeeditvue.delflag = true;
		}
	}

	// 공지사항 상세 조회
	function fNoticeMgrModal(noticeNo) {

		var param = {noticeNo : noticeNo};
		var resultCallBack2 = function(data) {

			console.log("resultCallBack2 : " + JSON.stringify(data));
			fdetailMgrResult(data);
		}

		callAjax("/scm/detailNoticeMgr.do", "post", "json", true, param,
				resultCallBack2);
	}

	// 공지사항 상세조회 콜백함수
	function fdetailMgrResult(data) {

		if (data.resultMsg == "SUCCESS") {
			noticeareavar.action = "U";

			gfModalPop("#notice");

			frealPopModal(data.result);

		} else {
			alert(data.resultMsg);
		}
	}

	// 공지사항 저장 및 수정
	function fn_noticeMgrSave() {
		
		//console.log("저장")

		var param = {
			action : noticeareavar.action,
			noticeTitle : noticeeditvue.noticeTitle,
			noticeContent : noticeeditvue.noticeContent,
			noticeNo : noticeeditvue.noticeNo
		}

		var savecallback = function(savereturn) {
			console.log("savecallback : " + JSON.stringify(savereturn));

			if (savereturn.resultMsg == "SUCCESS" || savereturn.resultMsg == "UPDATE") {
				alert("저장");
				gfCloseModal();

				fListInf();
			}else {
				alert("실패");
			}
		}
		callAjax("/scm/noticeMgrSave.do", "post", "json", true, param, savecallback);
	}
	
	// 공지사항 삭제
	function fn_noticeMgrDelete(){
		var param = {noticeNo : noticeeditvue.noticeNo}
		var deletecallback = function(deletereturn) {
			console.log("deletecallback : " + JSON.stringify(deletereturn));
			
			if(deletereturn.result == "SUCCESS") {
				alert("삭제");
				gfCloseModal();
				
				fListInf();
			}else {
				alert("삭제 실패");
			}
		}
		callAjax("/scm/noticeMgrDelete.do", "post", "json", true, param, deletecallback);
	}
</script>

</head>
<body>
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

						<div class="content" style="margin-bottom: 20px;">

							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
								<span class="btn_nav bold">메인</span> <a
									href="../dashboard/dashboard.do" class="btn_set refresh">새로고침</a>
							</p>
							
							<p class="conTitle">
								<span>공지사항</span> <span class="fr">
								<a class="btnType blue" href="javascript:fn_noticereg();"
									name="modal"><span>신규등록</span></a>
								</span>
	
							<div id="searcharea">
								
								<input type="date" style="width: 160px; height: 30px;" id="sdate" name="sdate">  
								<input type="date" style="width: 160px; height: 30px;" id="edate" name="edate">
								
								
								<select id="select" name="select"  v-model="select">
								    <option value="">전체</option>
									<option value="noticeTitle">제목</option>
									<option value="noticeContent">내용</option>
									<option value="TitleContent">제목+내용</option>
									<option value="name">작성자</option>
								</select>
								<input type="text" id="search" name="search" v-model="search" style="height:27px"> 
									<a class="btnType blue" href="javascript:fListInf()" 
									name="search">
									<span>검색</span></a> 
							</p>
							</div>

							<div id="divNoticeList">
								<div class="bootstrap-table">
									<div class="fixed-table-toolbar">
										<div class="bs-bars pull-left"></div>
										<div class="columns columns-right btn-group pull-right">
										</div>
									</div>
									<div class="fixed-table-container" style="padding-bottom: 0px;">
										<div class="fixed-table-body">


											<table class="col">
												<caption>caption</caption>
												<colgroup>
													<col width="5%">
													<col width="40%">
													<col width="10%">
													<col width="20%">
													<col width="20%">
												</colgroup>

												<thead>
													<tr>
														<th scope="col">번호</th>
														<th scope="col">제목</th>
														<th scope="col">작성일</th>
														<th scope="col">작성자</th>
														<th scope="col">조회수</th>
													</tr>
												</thead>

												<tbody id="listInf" v-for="(item,index) in listitem"
													v-if="listitem.length">
													<tr @click="detailview(item.notcode)">
														<td>{{ item.notcode }}</td>
														<td>{{ item.nottitle }}</td>
														<td>{{ item.notdate }}</td>
														<td>{{ item.name }}</td>
														<td>{{ item.noticeview }}</td>
													</tr>
												</tbody>
											</table>
										</div>
										<div>
											<div>
												<div class="clearfix" />
											</div>
										</div>
									</div>
								</div>
							</div>

							<div class="paging_area" id="listInfPagination"></div>
							<br>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<!-- 모달팝업 -->
		<div id="notice" class="layerPop layerType2" style="width: 600px;">
			<input type="hidden" id="noticeNo" name="noticeNo"
				value="${noticeNo}">
			<!-- 수정시 필요한 num 값을 넘김  -->

			<dl>
				<dt>
					<strong>공지사항</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>

						<tbody>
							<tr>
								<th scope="row">작성자 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="loginId"
									id="loginId" v-model="loginId" v-bind:readonly="loginIdread" /></td>
								<!-- <th scope="row">작성일<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="write_date" id="write_date" /></td> -->
							</tr>
							<tr>
								<th scope="row">제목 <span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="noticeTitle" id="noticeTitle" v-model="noticeTitle" /></td>
							</tr>
							<tr>
								<th scope="row">내용</th>
								<td colspan="3"><textarea class="inputTxt p100"
										name="noticeContent" id="noticeContent"
										v-model="noticeContent">
								</textarea></td>
							</tr>

						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType gray" id="btnSave" name="btn"><span>저장</span></a>
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
						<a href="" class="btnType gray" id="btnDelete" name="btn" v-show="delflag"><span>삭제</span></a>
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