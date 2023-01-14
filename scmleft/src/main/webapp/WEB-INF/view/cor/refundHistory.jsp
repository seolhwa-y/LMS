<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 반품현황</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://unpkg.com/axios@0.12.0/dist/axios.min.js"></script>
<script src="https://unpkg.com/lodash@4.13.1/lodash.min.js"></script>
<script type="text/javascript">
	/* 초기 공지 사항 뷰 선언문 */
	var listCount = 10;
	var pageCount = 10;
	var vueReturn;	// 기본 반품현황
	var vueReturnDetail; // 상세 반품
	
	function init(){
		
		vueReturn = new Vue({
			el: "#divReturnList",
			data: {
				returnList : ${result}.returnList,
				pagenavi : getPaginationHtml(1, ${result}.returnCount, listCount, pageCount, 'paging'),
				pageNum : 1,
			},
			methods : {
				/* 반품 현황 검색 및 페이징 */
				searchReturn : function(pageNum){
					var currentPage = (pageNum != undefined ? pageNum : vueReturn.pageNum) || 1;
					var param = { pageNum : currentPage, listCount : listCount, type : "N", }
					
					var listCallBack = function(data) {
						console.log(data);
						
						vueReturn.returnlist = data.returnList;
						vueReturn.pagenavi = getPaginationHtml(currentPage, data.returnCount, listCount, pageCount, 'paging');
						vueReturn.pageNum = currentPage;
					};
					
					callAjax("/cor/searchReturnList", "post", "json", true, param, listCallBack);
				 },
				 
				/* 반품현황 상세보기 */
				showReturnDetail : function(reCode){
					var param = { pageNum : vueReturn.pageNum, listCount : listCount, reCode : reCode, type : "Y", }
						
					var listCallBack = function(data) {
						console.log(data);
							
						returnDetailModalFeel(data.returnList[0]);
						gfModalPop("#returnModal");
					}
						
					callAjax("/cor/getReturnDetail", "post", "json", true, param, listCallBack);
				},
			}
		});
		
		
		vueReturnDetail = new Vue({
			el: "#returnModal",
			data: {
				reCode : "",
				jordCode : "",
				pdName : "",
				pdCode : "",
				reAmt : "",
				reDate : "",
				reType : "",
				total : "",
			},
			methods: {
				/* 모달 닫기 */
				modalClose : function(){
					gfCloseModal();
					vueReturn.searchReturn();
				},
			}
		});
	}
	
	// 페이징 처리를 위한 해당 function 연결
	function paging(pageNum) {
		vueReturn.searchReturn(pageNum);
	}
	
	// 모달 내용 넣기
	function returnDetailModalFeel(data){
		vueReturnDetail.reCode = data.reCode,
		vueReturnDetail.jordCode = data.jordCode,
		vueReturnDetail.pdName = data.pdName,
		vueReturnDetail.pdCode = data.pdCode,
		vueReturnDetail.reAmt = data.reAmt,
		vueReturnDetail.reDate = data.reDate,
		vueReturnDetail.reType = data.reType,
		vueReturnDetail.total = data.total.toLocaleString();
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
									<span>반품현황</span> <span class="fr"> 관련 자료 </span>
								</p>
							</div>
							<br>
							
							<!-- 반품현황 영역 -->
							<div id = "divReturnList">
								 <table class="col">
		                              <colgroup>
		                                 <col width="10%">
		                                 <col width="10%">
		                                 <col width="40%">
		                                 <col width="20%">
		                                 <col width="10%">
		                              </colgroup>
		                              <thead>
		                                 <tr>
		                                    <th scope="col">반품번호</th>
		                                    <th scope="col">주문번호</th>
		                                    <th scope="col">제품명</th>
		                                    <th scope="col">반품완료일자</th>
		                                    <th scope="col">반품상태</th>
		                                 </tr>
		                              </thead>
		                              <tbody>
		                                    <tr v-for = " (item, index) in returnList" v-on:click = "showReturnDetail(item.reCode)" v-if = "returnList.length != 0">
			                                      <td> {{ item.reCode }} </td>
			                                      <td> {{ item.jordCode }} </td>
			                                      <td> {{ item.pdName }} </td>
			                                      <td> {{ item.reDate }} </td>         
			                                      <td> {{ item.reType }} </td>
		                                    </tr>  
		                                    <tr v-else>
		                                    	<td colspan="5">검색된 데이터가 없습니다.</td>
		                                    </tr>                           
		                              </tbody>
		                           </table>
                           		<div class = "paging_area"  id = "divReturnPaging" v-html = "pagenavi"></div>
								<input type="hidden" v-model="pageNum" />
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
		
		
	<!-- 반품현황 상세보기 모달팝업 -->
	<div id="returnModal" class="layerPop layerType2" style="width: 60rem;">
		<dl>
			<dt>
				<strong>반품현황 상세보기</strong>
			</dt>
			<dd class="content">
				<table class="col">
					<colgroup>
		        		<col width="10%">
		            	<col width="10%">
		           		<col width="20%">
		            	<col width="10%">
		           		<col width="10%">
		           		<col width="10%">
		            	<col width="10%">
		            	<col width="10%">
		            </colgroup>
					<thead>
		            	<tr>
		               		<th scope="col">반품번호</th>
		              		<th scope="col">주문번호</th>
		               		<th scope="col">제품명</th>
		               		<th scope="col">제품CODE</th>
		               		<th scope="col">제품수량</th>
		               		<th scope="col">반품일자</th>
		               		<th scope="col">반품상태</th>
		               		<th scope="col">가격</th>
		                </tr>
		           </thead>
		           <tbody>
		           		<tr v-on:click = "showReturnDetail(reCode)" >
		              		<td v-model = "reCode"> {{ reCode }} </td>
		              		<td v-model = "jordCode"> {{ jordCode }} </td>
			                <td v-model = "pdName"> {{ pdName }} </td>
			                <td v-model = "pdCode"> {{ pdCode }} </td>
			                <td v-model = "reAmt"> {{ reAmt }} </td>
			                <td v-model = "reDate"> {{ reDate }} </td>   
			                <td v-model = "reType"> {{ reType }} </td>
			                <td v-model = "total"> {{ total }} </td>
		                </tr>                           
		          </tbody>
				</table>

				<div class="btn_areaC mt30">
					<a class="btnType gray"  id="btnClose" name="btn" v-on:click = "modalClose()"><span>닫기</span></a>
				</div>
			</dd>

		</dl>
	</div>
</form>
</body>
</html>