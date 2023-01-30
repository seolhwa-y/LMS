<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Job Korea :: 발주 / 반품 처리</title>


<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/duDatePicker/duDatepicker.css">
<script type="text/javascript" src="${CTX_PATH}/js/duDatePicker/duDatepicker.js"></script>


<script type="text/javascript">
	/* 초기 공지 사항 뷰 선언문 */
	var listCount = 5;
	var pageCount = 10;
	var vueSearch;	// 서치바
	var vueOrderReturn; // 발주지시서 리스트
	var vueOrderReturnDetail; // 발주지시서 상세내역

	function init() {

		/* 서치바 */
		vueSearch = new Vue({
			 el : '#divSearchBar',  
             data : {
            	 type : '', 
            	 keyword : '',
            	 startDate : '',
            	 endDate : '',
             },
             methods : {
            	 /* 발주지시서 조회 */
            	 searchOrderReturnList : function(pageNum){ console.log("searchOrderReturnList");
            		 var currentPage = (pageNum != undefined ? pageNum : vueOrderReturn.pageNum) || 1;           		 
            		 if(vueSearch.type == '') return swal("니 뭐하냐?");
            		 if(vueSearch.endDate.replaceAll("-", "") - vueSearch.startDate.replaceAll("-", "") < 0) return swal("날짜를 다시 선택하세요.");

  					 var param = {
 							 pageNum : currentPage, 
 							 listCount : listCount,
 							 type : vueSearch.type, // 검색 타입
 							 keyword : vueSearch.keyword, // 검색어
 							 startDate : vueSearch.startDate.replaceAll("-", ""),
 							 endDate : vueSearch.endDate.replaceAll("-", ""),
 					 } 
  					 
  					 
 					 var listCallBack = function(data) {
  						console.log(data);
  						vueOrderReturn.orderReturnList = [];
  						vueOrderReturn.orderReturnList = data.result.orderReturnList;
  						vueOrderReturn.pagenavi = getPaginationHtml(1, data.result.orderReturnCount, listCount, pageCount, 'paging', [true]);
  						vueOrderReturn.pageNum = vueOrderReturn.pageNum;
  						
	 					vueOrderReturnDetail.orderReturnDetailList = [];
	 					vueOrderReturnDetail.pagenavi = "";
	 					vueOrderReturnDetail.pageNum = "";
 					 }
 					
 					 callAjax("/ship/searchOrderReturn", "post", "json", true, param, listCallBack);
            	 }
             }
		});
		
	    /* 발주지시서 리스트 */
		vueOrderReturn = new Vue({
			  el : '#divOrderReturnList',
			  data : {
				  orderReturnList: ${result}.orderReturnList,
				  pagenavi: getPaginationHtml(1, ${result}.orderReturnCount, listCount, pageCount, 'paging', [true]),
			   	  pageNum : 1,
			  },
			  methods : {
				  /* 발주지시서 상세보기 */
				  orderReturnDetailList : function(id, pageNum){ 
					  var currentPage = (pageNum != undefined ? pageNum : vueOrderReturn.pageNum) || 1; 
				  	  var loginId = (id != undefined ? id : vueOrderReturnDetail.loginId);          
					  
					  var param = {
							  pageNum : currentPage, 
	 						  listCount : listCount,
							  loginId : loginId, 
	 				  } 
					  
					  console.log(param);
	  					 
	 				  var listCallBack = function(data) {
						  console.log(data);
						  
						  vueOrderReturnDetail.orderReturnDetailList = [];
	 					  vueOrderReturnDetail.orderReturnDetailList = data.result.orderReturnDetailList;
	 					  vueOrderReturnDetail.pageNum = data.result.pageNum;
	 					  vueOrderReturnDetail.loginId = data.result.loginId;
	 					  vueOrderReturnDetail.pagenavi = getPaginationHtml(data.result.pageNum, data.result.orderReturnDetailCount, listCount, pageCount, 'paging', [false]);
	 					  
	 					  console.log(data.result.orderReturnDetailList);
	 					 
	 					  data = data.result.orderReturnDetailList;
	 					  
	 					  for(i = 0; i < data.length; i++){
	 						  vueOrderReturnDetail.bordCode[i] = data[i].bordCode;
		 					  vueOrderReturnDetail.modelCode[i] = data[i].modelCode;
		 					  vueOrderReturnDetail.whCode[i] = data[i].whCode;
		 					  vueOrderReturnDetail.reCode[i] = data[i].reCode;
		 					  vueOrderReturnDetail.bordDate[i] = data[i].bordDate;
	 					  }
	 				  }
	 					
	 				  callAjax("/ship/searchOrderReturnDetail", "post", "json", true, param, listCallBack);
	            }
			},
		});	  
	    
	    /* 발주지시서 상세내역 */
		vueOrderReturnDetail = new Vue({
			el : "#divOrderReturnDetailList",
			data : {
				orderReturnDetailList : [],
				pagenavi : '',
				pageNum : '',
				loginId : '',
				bordCode : [],
				modelCode : [],
				whCode : [],
				reCode : [],
				bordDate : [],
			},
			methods : {
				/* 반품처리 */
				insertOrderReturn : function(){ console.log("insertOrderReturn");
					var ormList = {};
					var checkBox = document.querySelectorAll("input[name='isCheck']:checked");
					var message = "";

					for(i = 0; i < checkBox.length; i++){
						console.log(vueOrderReturnDetail.bordDate[i]);
						console.log(vueOrderReturnDetail.reCode[i]);
						
				 		if(vueOrderReturnDetail.bordDate[i] != 'null'){
				 			if(vueOrderReturnDetail.reCode[i] === 0) {
								ormList[i] = {};
								ormList[i].bordCode = vueOrderReturnDetail.bordCode[i];
								ormList[i].modelCode = vueOrderReturnDetail.modelCode[i];
								ormList[i].whCode = vueOrderReturnDetail.whCode[i];
								ormList[i].reCode = vueOrderReturnDetail.reCode[i];
								ormList[i].bordAmt = parseInt(checkBox[i].parentElement.parentElement.children[7].innerText.replaceAll(",", ""));
								ormList[i].type = '0'; 
								
								message += "주문번호 " + vueOrderReturnDetail.bordCode[i]; 
				 			}
						}
					}
					console.log(ormList);

					if(message !== '') {
						message += " 반품신청이 들어갑니다.";
						swal(message);
					} else return swal("반품신청 들어갈 수 있는 제품이 없습니다. \n재고처리를 진행하세요.");

					var param = { 
							ormList : JSON.stringify(ormList),
					};
					
					console.log(ormList);
					console.log(param);
					
	 				var listCallBack = function(data) {
	 					 console.log(data);
	 					 vueOrderReturn.orderReturnDetailList();

	 				}
	 					
	 				callAjax("/ship/insertOrderReturn", "post", "json", true, param, listCallBack);
				},
				/* 재고처리 */
           		updateOrderReturn : function(){ console.log("updateOrderReturn");
	           		var ormList = {};
					var checkBox = document.querySelectorAll("input[name='isCheck']:checked");
					var message = "";

					for(i = 0; i < checkBox.length; i++){
						console.log(vueOrderReturnDetail.bordDate[i]);
						console.log(vueOrderReturnDetail.reCode[i]);
				 		if(vueOrderReturnDetail.bordDate[i] == null && vueOrderReturnDetail.reCode[i] === 0){
				 			/* 입고 */
							ormList[i] = {};
							ormList[i].bordCode = vueOrderReturnDetail.bordCode[i];
							ormList[i].modelCode = vueOrderReturnDetail.modelCode[i];
							ormList[i].whCode = vueOrderReturnDetail.whCode[i];
							ormList[i].reCode = vueOrderReturnDetail.reCode[i];
							ormList[i].bordAmt = parseInt(checkBox[i].parentElement.parentElement.children[7].innerText.replaceAll(",", ""));
							ormList[i].loginId = vueOrderReturnDetail.loginId;
							ormList[i].type = 'in'; 
							
							message += "주문번호 " + vueOrderReturnDetail.bordCode[i]; 
						} else if(vueOrderReturnDetail.bordDate[i] != null && vueOrderReturnDetail.reCode[i] > 0){
				 			/* 출고 */
							ormList[i] = {};
							ormList[i].bordCode = vueOrderReturnDetail.bordCode[i];
							ormList[i].modelCode = vueOrderReturnDetail.modelCode[i];
							ormList[i].whCode = vueOrderReturnDetail.whCode[i];
							ormList[i].reCode = vueOrderReturnDetail.reCode[i];
							ormList[i].bordAmt = parseInt(checkBox[i].parentElement.parentElement.children[7].innerText.replaceAll(",", ""));
							ormList[i].loginId = vueOrderReturnDetail.loginId;
							ormList[i].type = 'out'; 
							
							message += "주문번호 " + vueOrderReturnDetail.bordCode[i]; 
						}
					}
					
					console.log(ormList);
	
					if(message !== '') {
						message += " 재고처리 들어갑니다.";
						swal(message);
					} else return swal("재고처리 할 수 있는 제품이 없습니다.");
	
					var param = { 
							ormList : JSON.stringify(ormList),
					};
					
					console.log(ormList);
					console.log(param);
					
	 				var listCallBack = function(data) {
	 					 console.log(data);
	 					 vueOrderReturn.orderReturnDetailList();
	 				}
 					
 					callAjax("/ship/updateOrderReturn", "post", "json", true, param, listCallBack);
           		} 
			}
		});
	}
	
	// 페이징 처리를 위해 해당 function 연결
	function paging(pageNum, isCheck){
		console.log(isCheck);
		switch (isCheck) {
		case "true" : vueSearch.searchBordReturnList(pageNum); break;
		case "false" : vueOrderReturn.orderReturnDetailList(vueOrderReturnDetail.loginId, pageNum); console.log("false"); break;
		default:
			break;
		}
	}
	
</script>

</head>
<body onload="init()">
<form id="myForm" action=""  method="">
	<div id="wrap_area">
		<div id="container">
			<ul>
				<li class="lnb">
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> 
				</li>
				<li class="contents">
					<div class="content">
						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a> 
							<a href="#" class="btn_nav">납품업체</a> 
							<span class="btn_nav bold">발주/반품 처리</span> 
							<a onClick="top.location='javascript:location.reload()'" class="btn_set refresh">새로고침</a>
						</p>
						
						<!-- 검색 영역 -->
						<div id="divSearchBar">
							<p class="conTitle" id="searcharea">
								<span>발주지시서 목록</span> 
							 	<span id = "search"  class="fr"> 
									<select id="searchKey" name="searchKey"  v-model="type">
									    <option value="" selected="selected" disabled="disabled">검색조건</option>
										<option value="companyName" >업체명</option>
									</select>
									<input type="text" id="searchWord"  v-model="keyword" placeholder="" style="height:27px"> 
									<input class="datetype" type="date" v-model = "startDate">
									<input class="datetype" type="date" v-model = "endDate">
									<a class="btnType blue" name="search" v-on:click = "searchOrderReturnList()">
										<span>검색</span>
									</a>							 
								</span>
							</p>	
						</div>
						
						<!-- 발주 지시서 리스트 영역 -->
						<div id="divOrderReturnList">
							<table class="col">
								<colgroup>
		                        	<col width="10%">
		                        	<col width="30%">
		                        	<col width="30%">
		                        </colgroup>
								<thead>
									<tr>
									    <th scope="col">NO</th>
										<th scope="col">납품업체명</th>
										<th scope="col">총액</th>
									</tr>
								</thead>
								<tbody>
									<tr v-for = " (item, index) in orderReturnList" v-if = "orderReturnList.length > 0" v-on:click = "orderReturnDetailList(item.loginId)">
										<td>{{ index + 1 }}</td>
										<td>{{ item.companyName }}</td>
										<td>{{ item.total }}</td>	
									</tr>
									<tr v-else-if = "orderReturnList.length == 0">
		                            	<td colspan="3">검색된 데이터가 없습니다.</td>
		                            </tr>   
								</tbody>
							</table>
							<div class = "paging_area"  id = "divPurDirectionPaging" v-html = "pagenavi"></div>
                           	<input type="hidden" v-model="pageNum" />
						</div>
						
						
						<!-- 발주지시서 상세내역 영역 -->
						<p class="conTitle" id="searcharea">
							<span>발주지시서 상세내역 목록</span> 
						 </p>

						<!-- 발주지시서 상세내역 영역 -->
						<div id="divOrderReturnDetailList">
							<table class="col">
								<colgroup>
		                        	<col width="5%">
		                        	<col width="5%">
		                        	<col width="5%">		                        	
		                        	<col width="15%">
		                        	<col width="10%">
		                        	<col width="10%">		                        	
		                        	<col width="10%">
		                        	<col width="5%">
		                        	<col width="10%">
		                        	<col width="15%">
		                        </colgroup>
								<thead>
									<tr>
										<th scope="col">체크</th>
									    <th scope="col">구분</th>
									    <th scope="col">제품코드</th>
										<th scope="col">제품명</th>
										<th scope="col">제품CODE</th>
										<th scope="col">제조사</th>
										<th scope="col">날짜</th>
										<th scope="col">수량</th>
										<th scope="col">판매가격</th>
										<th scope="col">창고이름</th>
									</tr>
								</thead>
								<tbody>
									<tr v-for = " (item, index) in orderReturnDetailList" v-if = "orderReturnDetailList.length > 0" >
										<td>
											<input type="checkBox" name = "isCheck" /> <!-- 반품처리 및 재고처리에 필요한 체크박스 -->
										</td>
										<td>{{ item.modelName }}</td>
										<td>{{ item.modelCode }}</td>
										<td>{{ item.pdName }}</td>	
										<td>{{ item.pdCode }}</td>
										<td>{{ item.pdCorp }}</td>
										<td >{{ item.dirDate }}</td>	
										<td>{{ item.bordAmt }}</td>
										<td>{{ item.pdPrice }}</td>
										<td>{{ item.whName }}</td>	
									</tr>
									<tr v-else-if = "orderReturnDetailList.length == 0">
		                            	<td colspan="10">검색된 데이터가 없습니다.</td>
		                            </tr>   
								</tbody>
							</table>
							<div class = "paging_area"  id = "divPurDirectionPaging" v-html = "pagenavi"></div>
                           	<input type="hidden" v-model="pageNum" />
                           	<input type="hidden" v-model="loginId" />
                     <!--       	<input type="hidden" v-model="action" /> -->
                           	<br/>
                           	<div style="margin-left: 40%;">
<!--                            	 	<a class="btnType gray" v-on:click = "checkAction('re')" v-show = "rePle"><span>반품요청</span></a>
                           		<a class="btnType blue" v-on:click = "checkAction('st')" v-show = "stPle"><span>입출고</span></a> -->
                             	<a class="btnType gray" v-on:click = "insertOrderReturn()" ><span>반품처리</span></a>
                           		<a class="btnType blue" v-on:click = "updateOrderReturn()" ><span>재고처리</span></a> 
                           	</div>
						</div>
						
					</div>
				</li>
			</ul>
		</div>
</form>
</body>
</html>