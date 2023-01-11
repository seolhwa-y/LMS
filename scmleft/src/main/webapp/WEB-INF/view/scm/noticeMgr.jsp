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
		/** 공지사항 검색
			1. 셀렉트 박스 :: 제목+내용, 제목, 내용
			2. 내용
			3. 작성일 :: 시작과 종료
			4. 글쓰기
		*/

		search = new Vue({
			el: "#divSarchBar",
			data: {
				search : "",	// 나중에 value 가져오기 위하여
				options : [{value : "", text : "검색요건", disabled : "disabled", selected : "selected"},
				           {value : "TC", text : "제목 + 내용"},
				           {value : "T", text : "제목"},
				           {value : "W", text : "작성자"}],		// 동적으로 셀렉트 만들기 위하여
				keyword : "",
				startDate : "",
				endDate : "",
			},
			methods: { // 검색, 글작성
				 searchNotice : function(){
					 console.log(search.search);
					 console.log("search.searchNotice");
				 },
				 regNotice : function(){
					 console.log("search.regNotice");
				 }
			}
		})
		
		/** 공지사항 메인
			1. 리스트
			2. 페이징라인
		*/
		vueNotice = new Vue({
			el: "#divNoticeList",
			data: {
				noticelist : [],
				pagenavi : "",
			},
			methods: {
				showNoticeDetail : function(){
					console.log("vueNotice.showNoticeDetail");
				},
				paging : function(){
					console.log("vueNotice.paging");
				}
			}
		});
		
		/** 공지사항 메인
			1. 리스트
			2. 페이징라인
		*/
		vueNoticeDetail = new Vue({
			el: "#noticeModal",
			data: {
				notTitle : "",
				name : "",
				notDate : "",
				notCon : "",
				notTitleRead : "",
				loginIdRead : "",
				notDateRead : "",
				notConRead : "",
				noticeSave : true, // TRUE는 안보인다.
				noticeUpdate : true, 
				noticeDelete : true,
			},
			methods: { // 저장, 수정, 삭제
				modalClose : function(){
					console.log("vueNoticeDetail.modalClose");
					gfCloseModal();
				},
				regNotice : function(){
					console.log("vueNoticeDetail.regNotice");
				},
				updNotice : function(){
					console.log("vueNoticeDetail.updNotice");
				},
				delNotice : function(){
					console.log("vueNoticeDetail.delNotice");
				}
			}
		});
		
		vueNotice.noticelist = ${noticeList};
	}
</script>

</head>
<body onload="init()">
<form id="myForm" action=""  method="">

<input type="hidden" id="currentPage" value="1">
<input type="hidden" id="selectedInfNo" value="">
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
								<input type = "date" v-model = "startDate" v-on:click = "searchNotice()" />
								<input type = "date" v-model = "endDate" v-on:click = "searchNotice()" />
								<a class="btnType gray"  id="btnSave" name="btn" v-on:click = "searchNotice()" ><span>조회</span></a>	
								<a class="btnType blue"  id="btnSave" name="btn" v-on:click = "regNotice()" ><span>검색</span></a>
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
		                              <tbody v-for = " (item,index) in noticelist" v-if = "noticelist.length">
		                                    <tr v-on:click = "showNoticeDetail(item.notCode)">
			                                      <td> {{ item.notcode }} </td>
			                                      <td> {{ item.nottitle }} </td>
			                                      <td> {{ item.name }} </td>
			                                      <td> {{ item.notdate }} </td>         
			                                      <td> {{ item.notView }} </td>
		                                    </tr>                             
		                              </tbody>
		                           </table>
                           		<br>
                           		<div class = "paging_area"  id = "comnGrpCodPagination" v-html = "pagenavi"> </div>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
		
		
	<!-- 모달팝업 -->
	<div id="noticeModal" class="layerPop layerType2" style="width: 600px;">
		<input type="hidden" id="notCode" name="notCode" value="${notCode}"> <!-- 수정시 필요한 num 값을 넘김  -->

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
							<th scope="row">제목 <span class="font_red">*</span></th>
							<td colspan="3">
							        <input type="text" class="inputTxt p100"	name="notTitle" id="notTitle" v-model="notTitle" v-bind:readonly="notTitleRead" />
							 </td>
						</tr>
						<tr>
							<th scope="row">작성자 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="loginId" id="loginId" v-model="loginId" v-bind:readonly="loginIdRead" /></td>
						</tr>
						<tr>
							<th scope="row">작성일<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="notDate" id="notDate" v-model="notDate" v-bind:readonly="notDateRead"/></td>
						</tr>
						<tr>
							<th scope="row">내용</th>
							<td colspan="3">
								<textarea class="inputTxt p100" name="notCon" id="notCon" v-model="notCon" v-bind:readonly="notConRead">
								</textarea>
							</td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a class="btnType gray"  id="btnSave" name="btn" v-on:click = "regNotice()" v-show = "noticeSave"><span>저장</span></a>	<!-- 등록, 수정 -->
					<a class="btnType gray"  id="btnUpdate" name="btn" v-on:click = "updNotice()" v-show = "noticeUpdate"><span>수정</span></a>	<!-- 수정 버튼을 누르면 입력 활성화 -->
					<a class="btnType gray"  id="btnDelete" name="btn" v-on:click = "delNotice()" v-show = "noticeDelete"><span>삭제</span></a>
					<a class="btnType gray"  id="btnClose" name="btn" v-on:click = "modalClose()"><span>닫기</span></a>
				</div>
			</dd>

		</dl>
	</div>

      
</form>
</body>
</html>