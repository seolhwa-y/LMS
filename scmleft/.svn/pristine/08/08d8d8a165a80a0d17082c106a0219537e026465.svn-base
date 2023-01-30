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
	var vuevar;
	var vuebind;
	var vuecheck;
	var vueradio;
	var vueprop1;
	var vueprop2;
	var vueoption;
	var vuecompute;
	var watchExampleVM;
	var divComGrpCodList;
	var divComGrpCoddetail;

	/* onload 이벤트  */
	$(document).ready(function() {
		init();

		// 공지사항 조회
		fListInf();

		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	function init() {
		noticeareavar = new Vue({
			el : '#divWhList',
			components : {
				'bootstrap-table' : BootstrapTable
			},
			data : {
				listitem : [],
				action : "",
				pagenavi : ""
			},
			methods : {
				detailview : function(WH_CODE) {
					alert(WH_CODE);
					fNoticeModal(WH_CODE);
				}
			}

		});

		noticeeditvue = new Vue({
			el : '#Wh',
			data : {
				loginID : "",
				WH_NAME : "",
				WH_ZIP : "",
				WH_ADDR : "",
				WH_ADDR_DTL: "",
				loginIdread : "",
				WH_NAMEread : "",
				WH_ZIPread : "",
				WH_ADDRread : "",
				WH_ADDR_DTLread: "",
				WH_CODE: "",
				delflag : true
			}
		});
	}

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
			switch (btnId) {
			case 'btnClose':
				gfCloseModal();
				break;
			case 'btnsave':
				fn_noticesave();
				break;
			case 'btndelete':
				fn_noticedelete();
				break;
			case 'btnCloseGrpCod':
				gfCloseModal();
				break;
			case 'btnSaveGrpCod':
				fSaveGrpCod();
				break;
			case 'btnSearch':
				fListInf();
				break;
			}
		});
	}

	/** 공지사항 조회 */
	function fListInf(currentPage) {

		currentPage = currentPage || 1;

		//console.log("currentPage : " + currentPage);

		var param = {
			currentPage : currentPage,
			pageSize : pageSizeinf,
			selectS : $("#selectS").val(),
			search : $("#search").val()
		}

		var resultCallback = function(data) {

			console.log("resultCallback : " + JSON.stringify(data));

			fListInfResult(data, currentPage);
		};

		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		//html로 받을거라 text
		callAjax("/scm/listWhvue.do", "post", "json", true, param,
				resultCallback);

	}

	/** 공지사항 조회 콜백 함수 */
	function fListInfResult(data, currentPage) {

		//console.log(data);		
		noticeareavar.listitem = data.WhList;

		// 총 개수 추출
		var totalCntlistInf = data.WhCnt;
		
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCntlistInf,
				pageSizeinf, pageBlockSizeinquiry, 'fListInf');
		console.log("paginationHtml : " + paginationHtml);
		
		noticeareavar.pagenavi = paginationHtml;
		//$("#listInfPagination").empty().append(paginationHtml);

	}

	function fn_noticereg() {
		noticeareavar.action = "I";

		frealPopModal();

		gfModalPop("#Wh");
	}

	/*공지사항 상세 조회*/
	function fNoticeModal(WH_CODE) {

		var param = {
			WH_CODE : WH_CODE
		};
		var resultCallback2 = function(data) {

			console.log("resultCallback : " + JSON.stringify(data));

			fdetailResult(data);
		};

		callAjax("/scm/detailWh.do", "post", "json", true, param,
				resultCallback2);
	}

	/*  공지사항 상세 조회 -> 콜백함수   */
	function fdetailResult(data) {

		if (data.resultMsg == "SUCCESS") {
			noticeareavar.action = "U"

			//모달 띄우기 
			gfModalPop("#Wh");

			// 모달에 정보 넣기 
			frealPopModal(data.result);

		} else {
			alert(data.resultMsg);
		}
	}

	/* 팝업 _ 초기화 페이지(신규) 혹은 내용뿌리기  */
	function frealPopModal(object) {

		if (noticeareavar.action == "I") {
			console.log("☆☆☆ I ☆☆☆");
			noticeeditvue.WH_NAME = "";
			noticeeditvue.WH_ZIP = "";
			noticeeditvue.WH_ADDR = "";
			noticeeditvue.WH_ADDR_DTL = "";
			noticeeditvue.loginID = "";
			noticeeditvue.WH_CODE = "";

			noticeeditvue.delflag = false;

		} else {
			console.log("☆☆☆ else : I☆☆☆");
			noticeeditvue.WH_NAME = object.wh_NAME;
			noticeeditvue.WH_ZIP= object.wh_ZIP;
			noticeeditvue.WH_ADDR = object.wh_ADDR;
			noticeeditvue.WH_ADDR_DTL = object.wh_ADDR_DTL;
			noticeeditvue.loginID = object.loginID;

			noticeeditvue.WH_CODE = object.wh_CODE;

			noticeeditvue.delflag = true;
		}

	}

	function fn_noticesave() {

		var param = {
			action : noticeareavar.action,
			WH_NAME : noticeeditvue.WH_NAME,
			WH_ZIP : noticeeditvue.WH_ZIP,
			WH_ADDR : noticeeditvue.WH_ADDR,
			WH_ADDR_DTL : noticeeditvue.WH_ADDR_DTL,
			WH_CODE : noticeeditvue.WH_CODE,
			loginID : noticeeditvue.loginID
		}

		var savecallback = function(savereturn) {
			console.log("savecallback : " + JSON.stringify(savereturn));

			if (savereturn.resultMsg == "SUCCESS"
					|| savereturn.resultMsg == "UPDATED") {
				alert("저장 되었습니다.");
				gfCloseModal();

				fListInf();
			} else {
				alert("실패 되었습니다.");
			}

		}

		callAjax("/scm/WhSave.do", "post", "json", true, param,
				savecallback);

	}

	function fn_noticedelete() {
		var param = {
			WH_CODE : noticeeditvue.WH_CODE
		}

		var savecallback = function(savereturn) {
			console.log("savecallback : " + JSON.stringify(savereturn));

			if (savereturn.result == "SUCCESS") {
				alert("삭제 되었습니다.");
				gfCloseModal();

				fListInf();
			} else {
				alert("실패 되었습니다.");
			}

		}

		callAjax("/scm/WhDelete.do", "post", "json", true, param, savecallback);

	};
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	    function zipcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    //document.getElementById("sample6_extraAddress").value = extraAddr;
	                	addr += extraAddr;
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('WH_ZIP').value = data.zonecode;
	                document.getElementById('WH_ADDR').value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById('WH_ADDR_DTL').focus();
	            }
	        }).open();
	    }
	</script>
<body>
	<form id="myForm" action="" method="">

		<input type="hidden" id="currentPage" value=""> <input
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
							<div>

								<p class="conTitle">
									<span>창고 정보 등록</span> <span class="fr"> <a
										class="btnType blue" href="javascript:fn_noticereg();"
										name="modal"><span>창고등록</span></a>
									</span>
								</p>

								<!--검색창   -->
								<table width="100%" cellpadding="5" cellspacing="0" border="1"
									align="left"
									style="border-collapse: collapse; border: 1px #50bcdf;">
									<tbody>
										<tr style="border: 0px; border-color: blue">
											<td width="100" height="25" style="font-size: 120%">&nbsp;&nbsp;</td>
											<td width="50" height="25" style="font-size: 100%; text-align: right; padding-right: 25px;">
												<select id="selectS" name="selectS" style="width: 130px; height: 27px">
													<option value="all">전체</option>
													<option value="wh_name">창고명</option>
													<option value="wh_addr">창고위치</option>
											</select> <input type="text" style="width: 150px; height: 25px;"id="search" name="search"> 
											<a href="" class="btnType blue" id="btnSearch" name="btn"><span>검색</span></a>
											</td>

										</tr>
									</tbody>
								</table>
								&nbsp;&nbsp;
								<!-- 리스트 화면 -->
								<div id="divWhList">
									<div class="bootstrap-table">
										<div class="fixed-table-toolbar">
											<div class="bs-bars pull-left"></div>
											<div class="columns columns-right btn-group pull-right">
											</div>
										</div>
										<div class="fixed-table-container"
											style="padding-bottom: 0px;">
											<div class="fixed-table-body">
									

												<table class="col">
													<caption>caption</caption>
													<colgroup>
														<col width="15%">
														<col width="15%">
														<col width="15%">
														<col width="20%">
														<col width="20%">
														<col width="15%">
													</colgroup>
													<thead>
														<tr>
															<th scope="col">창고코드</th>
															<th scope="col">창고명</th>
															<th scope="col">우편번호</th>
															<th scope="col">창고위치</th>
															<th scope="col">상세주소</th>
															<th scope="col">아이디</th>
														</tr>
													</thead>

													<tbody id="listInf" v-for="(item,index) in listitem"
														v-if="listitem.length">
														<tr @click="detailview(item.wh_CODE)">
															<td>{{ item.wh_CODE }}</td>
															<td>{{ item.wh_NAME }}</td>
															<td>{{ item.wh_ZIP }}</td>
															<td>{{ item.wh_ADDR }}</td>
															<td>{{ item.wh_ADDR_DTL }}</td>
															<td>{{ item.loginID }}</td>
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
									<div class="paging_area" id="listInfPagination" v-html="pagenavi"></div>
								</div>

								

							</div>
							<br>
						</div>
					</li>
				</ul>
			</div>
		</div>

		<!-- 모달팝업 -->
		<div id="Wh" class="layerPop layerType2" style="width: 600px;">
			<input type="hidden" id="WH_CODE" name="WH_CODE"
				value = "${WH_CODE }">
			<!-- 수정시 필요한 num 값을 넘김  -->

			<dl>
				<dt>
					<strong>창고등록</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>

						<tbody>
							<tr>
								<th scope="row"><span class="font_red">창고코드</span></th>
								<td><input type="text"  class="inputTxt p100"
								 v-model="WH_CODE" /></td> 
							</tr>
							<tr>
								<th scope="row"><span class="font_red"> 창고명 </span></th>
								<td><input type="text"  class="inputTxt p100"
									name="WH_NAME" id="WH_NAME"  v-model="WH_NAME" /></td>
							</tr>
							<tr>
								<th scope="row"><span class="font_red"> 우편번호 </span></th>
								<td><input type="text" 
										name="WH_ZIP" id="WH_ZIP" value = "${WH_ZIP }" v-model="WH_ZIP" style="height:25px; width: 360px;" />
										<a href="javascript:zipcode();"  style="font-size:16px; float:right; color:blue;"> 우편번호 </a>
								</td>
							</tr>
							<tr>
								<th scope="row"><span class="font_red"> 창고주소 </span></th>
								<td><input type="text" class="inputTxt p100"
										name="WH_ADDR" id="WH_ADDR"  value = "${WH_ADDR}"  v-model="WH_ADDR">
								</td>
							</tr>
							<tr>
								<th scope="row"><span class="font_red"> 상세주소 </span></th>
								<td><input type="text" class="inputTxt p100"
										name="WH_ADDR_DTL" id="WH_ADDR_DTL"  value = "${WH_ADDR_DTL}" v-model="WH_ADDR_DTL">
								</td>
							</tr>
							<tr>
								<th scope="row"><span class="font_red"> 아이디 </span></th>
								<td><input type="text" class="inputTxt p100"
										name=" loginID" id="loginID" v-model="loginID">
								</td>
							</tr>
						</tbody>
					</table>
					<!-- class="inputTxt p100" -->
					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnsave" name="btn"><span>저장</span></a>
						<a href="" class="btnType red" id="btndelete" name="btn"
							v-show="delflag"><span>삭제</span></a> <a href=""
							class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
					</div>
				</dd>

			</dl>
		</div>


		<div id="layer2" class="layerPop layerType2" style="width: 600px;">
			<input type="hidden" id="action" name="action" value="U">
			<dl>
				<dd class="content">
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