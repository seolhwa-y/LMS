<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 공지사항</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://unpkg.com/axios@0.12.0/dist/axios.min.js"></script>
<script src="https://unpkg.com/lodash@4.13.1/lodash.min.js"></script>
<script type="text/javascript">
	/* 초기 공지 사항 뷰 선언문 */
	var listCount = 10;
	var pageCount = 10;
	var search; // 검색
	var vueNotice;	// 기본 공지사항
	var vueNoticeDetail; // 상세 공지사함
	
	function init(){
		/* 서치바 */
		search = new Vue({
			el: "#divSarchBar",
			data: {
				search : "",
				options : [{value : "", text : "검색요건", disabled : "disabled", selected : "selected"},
				           {value : "TC", text : "제목 + 내용"},
				           {value : "T", text : "제목"},
				           {value : "W", text : "작성자"}],		
				keyword : "",
				startDate : "",
				endDate : "",
			},
			methods: {
				/* 공지사항 검색 및 페이징 */
				searchNotice : function(pageNum){
					if(search.endDate.replaceAll("-", "") - search.startDate.replaceAll("-", "") < 0) return swal("날짜를 다시 선택하세요.");
					if(search.search == "" && search.keyword != "") return swal("검색구분을 선택하세요.");
					
					var currentPage = (pageNum != undefined ? pageNum : vueNotice.pageNum) || 1;
					var param = {
							pageNum : currentPage, 
							listCount : listCount,
							type : search.search, // 검색 타입
							keyword : search.keyword, // 검색어
							startDate : search.startDate.replaceAll("-", ""),
							endDate : search.endDate.replaceAll("-", ""),
					}
					
					var listCallBack = function(data) {
						vueNotice.noticelist = data.noticeList;
						vueNotice.pagenavi = getPaginationHtml(currentPage, data.noticeCount, listCount, pageCount, 'paging');
						vueNotice.pageNum = currentPage;
						search.keyword = "";
					}
					
					callAjax("/scm/searchNoticeList", "post", "json", true, param, listCallBack);
				 },
				 
				 /* 글작성 버튼 클릭 후 모달 활성화 */
				 regNotice : function(){ 
					noticeModalFeel(true);
					gfModalPop("#noticeModal");
				 },
			}
		})
		
		/* 공지사항 */
		vueNotice = new Vue({
			el: "#divNoticeList",
			data: {
				loginId : "${loginId}", 
				loginName : "${name}",
				pageNum : 1,
				noticelist : ${result}.noticeList,
				pagenavi : getPaginationHtml(1, ${result}.noticeCount, listCount, pageCount, 'paging'),
			},
			methods: {
				/* 공지사항 상세보기 */
				showNoticeDetail : function(notCode){ 
					var param = { view : "Y", notCode : notCode }
					
					var detailCallBack = function(data) {
						noticeModalFeel(false, data.result);
						gfModalPop("#noticeModal");
						swal(data.result.message);
					}
					
					callAjax("/scm/checkNoticeList", "post", "json", true, param, detailCallBack);
				},
			}
		});
		
		/* 공지사항 보기 모달 */
		vueNoticeDetail = new Vue({
			el: "#noticeModal",
			data: {
				notCode : "",
				writeId : "",
				notTitle : "",
				name : "",
				notDate : "",
				notCon : "",
				notTitleRead : "",
				nameRead : "",
				notDateRead : "",
				notConRead : "",
				noticeSave : false,
				noticeUpdate : false, 
				noticeDelete : false,
			},
			methods: { 
				/* 모달 닫기 */
				modalClose : function(){
					gfCloseModal();
					search.searchNotice();
				},
				
				/* 공지사항 등록 및 수정 */
				regNotice : function(num, pageNum){ 
					var currentPage = pageNum || 1;
				
					var param = {
							pageNum : currentPage, 
							listCount : listCount,
							notCode : vueNoticeDetail.notCode,
							notTitle : vueNoticeDetail.notTitle,
							notCon : vueNoticeDetail.notCon,
					}
					var detailCallBack = function(data) {
						vueNotice.noticelist = data.result.noticeList;
						vueNotice.pagenavi = getPaginationHtml(currentPage, data.result.noticeCount, listCount, pageCount, 'paging');
					
						gfCloseModal();
						swal(data.result.message);
					}
					
					num == 1 ? callAjax("/scm/insertNotice", "post", "json", true, param, detailCallBack) 
						 	 : callAjax("/scm/updateNotice", "post", "json", true, param, detailCallBack);
				},
				
				/* 공지사항 삭제 */
				delNotice : function(pageNum){ 
					var currentPage = pageNum || 1;
					
					var param = {
							pageNum : currentPage, 
							listCount : listCount,
							notCode : vueNoticeDetail.notCode,
					}
					var detailCallBack = function(data) {
						vueNotice.noticelist = data.result.noticeList;
						vueNotice.pagenavi = getPaginationHtml(currentPage, data.result.noticeCount, listCount, pageCount, 'paging');
					
						gfCloseModal();
						swal(data.result.message);
					}
					
					callAjax("/scm/deleteNotice", "post", "json", true, param, detailCallBack);
				}
			}
		});
	}
	
	// 페이징 처리를 위해 해당 function 연결
	function paging(pageNum){
		search.searchNotice(pageNum);
	}
	
	// 모달 내용 경우의 수
	function noticeModalFeel(action, data){
		var date = new Date();

		switch(action){
		case true : 
			vueNoticeDetail.notCode = "";
			vueNoticeDetail.notTitle = "";
			vueNoticeDetail.name = vueNotice.loginName;
			vueNoticeDetail.notDate = date.toLocaleDateString();
			vueNoticeDetail.notCon = "";
			vueNoticeDetail.nameRead = "";
			vueNoticeDetail.notDateRead = "";
			vueNoticeDetail.noticeSave = true;
			vueNoticeDetail.noticeUpdate = false;
			vueNoticeDetail.noticeDelete = false;
			break;
			
		case false : 
			vueNoticeDetail.notTitle = data.noticeList[0].notTitle;
			vueNoticeDetail.name = data.noticeList[0].name;
			vueNoticeDetail.notDate = data.noticeList[0].notDate;
			vueNoticeDetail.notCon = data.noticeList[0].notCon;
			vueNoticeDetail.notCode = data.noticeList[0].notCode;
			vueNoticeDetail.writeId = data.noticeList[0].loginId;
			vueNoticeDetail.noticeSave = false;
			
			/* 글작성자가 아니라면 수정 삭제버튼 no show */
			if(vueNotice.loginId == vueNoticeDetail.writeId) {
				vueNoticeDetail.noticeUpdate = true;
				vueNoticeDetail.noticeDelete = true;
			} 
			
			break;
			
		default : break;
		
		}
	}
</script>

</head>
<body onload="init()">
<form id="myForm" action=""  method="">
		<div id="mask"></div>
		<div id="wrap_area">
			<div id="container">
				<ul>
					<li class="lnb">
						<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> 
					</li>
					<li class="contents">
						<div class="content" style="margin-bottom: 20px;">
							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
								<span class="btn_nav bold">메인</span> <a
									href="../dashboard/dashboard.do" class="btn_set refresh">새로고침</a>
							</p>
							<div>
								<p class="conTitle" style="margin-bottom: 1%;">
									<span>공지사항</span> <span class="fr"> 관련 자료 </span>
								</p>
							</div>
							<br>
							
							<!-- 검색 영역 -->
							<div id = "divSarchBar">
									<select v-model = "search">
										<template v-for = "sear in options">
											<option :value = "sear.value" :disabled = "sear.disabled" :selected = "sear.selected" >{{sear.text}}</option>
										</template>
									</select>
								<input type = "text" v-model = "keyword" />
								
								<span>작성일자</span>
								<input type = "date" v-model = "startDate" />
								<input type = "date" v-model = "endDate" />
								<a class="btnType gray"  id="btnSave" name="btn" v-on:click = "searchNotice()" ><span>조회</span></a>	
								<a class="btnType blue"  id="btnSave" name="btn" v-on:click = "regNotice()" ><span>글작성</span></a>
							</div>
							
							<!-- 게시글 목록 영역 -->
							<div id = "divNoticeList">
								 <table class="col">
		                              <caption>caption</caption>
		                              <colgroup>
		                                 <col width="5%">
		                                 <col width="30%">
		                                 <col width="20%">
		                                 <col width="15%">
		                                 <col width="15%">
		                              </colgroup>
		                              <thead>
		                                 <tr>
		                                    <th scope="col">글번호</th>
		                                    <th scope="col">제목</th>
		                                    <th scope="col">작성자</th>
		                                    <th scope="col">작성일</th>
		                                    <th scope="col">조회수</th>
		                                 </tr>
		                              </thead>
		                              <tbody>
		                                    <tr v-for = " (item, index) in noticelist" v-on:click = "showNoticeDetail(item.notCode)" v-if = "noticelist.length > 0">
			                                      <td> {{ item.notCode }} </td>
			                                      <td> {{ item.notTitle }} </td>
			                                      <td> {{ item.name }} </td>
			                                      <td> {{ item.notDate }} </td>         
			                                      <td> {{ item.notView }} </td>
		                                    </tr>  
		                                    <tr v-if = "noticelist.length == 0">
		                                    	<td colspan="5">검색된 데이터가 없습니다.</td>
		                                    </tr>                           
		                              </tbody>
		                           </table>
                           		<div class = "paging_area"  id = "divNoticePaging" v-html = "pagenavi"></div>
                           		<input type="hidden" v-model="loginId" />
								<input type="hidden" v-model="loginName" />
								<input type="hidden" v-model="pageNum" />
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
		
		
	<!-- 모달팝업 -->
	<div id="noticeModal" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>공지사항</strong>
			</dt>
			<dd class="content">
				<table class="row">
					<tbody>
						<tr>
							<th scope="row">제목 <span class="font_red">*</span></th>
							<td colspan="3">
							        <input type="text" class="inputTxt p100" v-model="notTitle" />
							 </td>
						</tr>
						<tr>
							<th scope="row">작성자 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" v-model="name" v-bind:readonly="nameRead" /></td>
						</tr>
						<tr>
							<th scope="row">작성일<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100"  v-model="notDate" v-bind:readonly="notDateRead"/></td>
						</tr>
						<tr>
							<th scope="row">내용</th>
							<td colspan="3">
								<textarea class="inputTxt p100" v-model="notCon" >
								</textarea>
							</td>
						</tr>
					</tbody>
				</table>

				<div class="btn_areaC mt30">
					<input type="hidden" v-model="notCode" />
					<input type="hidden" v-model="writeId" />
					<a class="btnType blue"  id="btnSave" name="btn" v-on:click = "regNotice('1')" v-show = "noticeSave"><span>등록</span></a>	<!-- 등록, 수정 -->
					<a class="btnType blue"  id="btnUpdate" name="btn" v-on:click = "regNotice('2')" v-show = "noticeUpdate"><span>수정</span></a>	<!-- 수정 버튼을 누르면 입력 활성화 -->
					<a class="btnType gray"  id="btnDelete" name="btn" v-on:click = "delNotice()" v-show = "noticeDelete"><span>삭제</span></a>
					<a class="btnType gray"  id="btnClose" name="btn" v-on:click = "modalClose()"><span>닫기</span></a>
				</div>
			</dd>

		</dl>
	</div>
</form>
</body>
</html>