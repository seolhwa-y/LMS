<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Scm Left :: 주문내역 관리</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<!-- duDatePicker import css-->
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/duDatePicker/duDatepicker.css">
<!-- duDatePicker import js -->
<script type="text/javascript" src="${CTX_PATH}/js/duDatePicker/duDatepicker.js"></script>
<style>
	h2 { text-align: center; }
</style>
<script type="text/javascript">

	//제품정보 페이징 처리
	var ordPageSize = 10;
	var ordPageBlock = 10;
	
	var modalPageSize = 5;
	var modalPageBlock = 5;
	
	var checkBoxStatus;
	var areaVar;
	var editVue;
	$(document).ready(function() {
		
		init();
		
		// 목록 조회
		ordDtManagementList();
		
		//체크박스 작동 메소드
		checkBoxStatus();
		
		fRegisterButtonClickEvent();
		
		//엔터 검색
		$("#searchWord").keypress(function (e){
			if(e.which == 13){
				searchOrdDtManagementList();
			}
			
		
		});
	});
	
	function init() {
		
		areaVar = new Vue({
			  el: '#orderList',
			  
			  data: {
				  	listitem:[],
                    action:"",
                    pagenavi:""
			  }, 
			  methods:{					
				  detailview:function(no){
					  alert(no);
					  ordDtManagementSelect(no);
				  }
			  }  
			  
			});	

		editVue = new Vue({
			  el: '#layer1',
			  data: {
				  bord_CODE:"",
				  loginID:"",
				  model_NAME:"",
				  bord_AMT:"",
				  bord_DATE:"",
				  bord_TYPE:"",
				  jord_IN:"",
				  flag:true
			  }
			});	
		
	}
	
	/** 버튼 이벤트 등록 */
    function fRegisterButtonClickEvent() {
       $('a[name=btn]').click(function(e) {
          e.preventDefault();

          var btnId = $(this).attr('id');
          switch (btnId) {
             case 'btnClose' :
             gfCloseModal();
             break;
             case 'btnSave' :
            updateModal();
             break;                   
                
       }
    });
	}
	
	//주문내역 전체 조회
	function ordDtManagementList(currentPage) {
			
		currentPage = currentPage || 1;
				
		var param = {
				
				currentPage : currentPage,
				pageSize : ordPageSize
	
			}
		
		var resultCallBack = function(data){
			
			console.log("resultCallback : " + JSON.stringify(data));
			
			ordDtManagementListResult(data, currentPage);
			
		}

		callAjax("/pur/ordDtManagementList.do", "post", "json", true, param, resultCallBack );
	} 
	
	//전체 주문내역 페이징 처리
    function ordDtManagementListResult(data, currentPage) {
    	//console.log(data);		
		areaVar.listitem = data.listOrdDtManagement;
		
    	//$("#listOrdDtManagement").empty().append(data);
    	
    	var totalCnt = data.totalCnt;
    	
    	//var list = $("#tmpList").val();

    	
		areaVar.pagenavi = getPaginationHtml(currentPage, totalCnt, ordPageSize, ordPageBlock, 'ordDtManagementList');
		
		
		//(paginationHtml);
		//$("#pagingnavi").empty().append(pagingnavi);
		$("#currentPage").val(currentPage);
		  	
    }
	
	
	//주문내역 검색
	function searchOrdDtManagementList(currentPage) {
		
		currentPage = currentPage || 1;
		
		var searchKey = document.getElementById("searchKey").value;
		var searchWord = document.getElementById("searchWord").value;
		
		var sdate = $("#sdate").val();
		var edate = $("#edate").val();
		
		if ($("#depositCheck").is(":checked")) {
			checkBoxStatus="checked";
		}		
		else{
			//alert("unChecked");
			checkBoxStatus="unChecked";			
		}				
		var param = {
				
				searchKey : searchKey,
				searchWord : searchWord,	
				currentPage : currentPage,
				pageSize : ordPageSize,
				sdate : sdate,
				edate : edate,
				checkBoxStatus : checkBoxStatus
				
			}
		console.log("sDate : " + sdate + ", edate : " + edate);
	
		var resultCallBackSearch = function(data){
			checkBoxListResult(data, currentPage);
			
		}

		callAjax("/pur/ordDtManagementList.do", "post", "json", true, param, resultCallBackSearch );
	} 
	
	
	//체크박스에 따른 변동 입금, 미입금
	function checkBoxStatus(currentPage){
		
		currentPage = currentPage || 1;
		
		$("#depositCheck").change(function(){
			if ($("#depositCheck").is(":checked")) {
				//alert("checked");
				checkBoxStatus="checked";
			
			}			
			else{
				//alert("unChecked");
				checkBoxStatus="unChecked";			
			}	
			var param = {
					currentPage : currentPage,
					pageSize : ordPageSize,				
					checkBoxStatus : checkBoxStatus
			}
			console.log(param);
			var resultCallBack = function(data){
				checkBoxListResult(data, currentPage);
			}
			callAjax("/pur/ordDtManagementList.do", "post", "json", true, param, resultCallBack);
		});
	}
	
	//체크박스 페이지네이션
	function checkBoxList(currentPage){
		currentPage = currentPage || 1;
		
		var searchKey = document.getElementById("searchKey").value;
		var searchWord = document.getElementById("searchWord").value;
		
		var sdate = $("sdate").val();
		var edate = $("edate").val();
		
		if($("depositCheck").is(":ckecked")){
			ckeckBoxStatus = "checked";	
		}else{
			ckeckBoxStatus = "unchecked";	
		}	
			var param = {
					
					searchKey : searchKey,
					searchWord : searchWord,	
					currentPage : currentPage,
					pageSize : ordPageSize,
					sdate : sdate,
					edate : edate,
					checkBoxStatus : checkBoxStatus
					
				}
			
			var resultCallBack = function(data){
				checkBoxListResult(data, currentPage);
				
			}
			
			callAjax("/pur/ordDtManagementList.do", "post", "json", true, param, resultCallBack );
		} 
	
	//체크박스 상태에 따른 화면
	function checkBoxListResult(data, currentPage){
		//$("#listOrdDtManagement").empty().append(data);
		areaVar.listitem = data.listOrdDtManagement;
		var totalCnt = data.totalCnt;
    
    	
		areaVar.pagenavi = getPaginationHtml(currentPage, totalCnt, ordPageSize, ordPageBlock, 'checkBoxList');
		
		//(paginationHtml);
		//$("#pagingnavi").empty().append(pagingnavi);
		$("#currentPage").val(currentPage);
		  	
    }
	
	//단건 조회
	function ordDtManagementSelect(bordCode){
		
		var param = {
				bordCode : bordCode
		};
		var resultCallBack = function(data){
			
			console.log("resultCallback : " + JSON.stringify(data));
			
			ordDtManagementSelectResult(data);			
		};	
		callAjax("/pur/ordDtManagementSelect.do", "post", "json", true, param, resultCallBack);
	} 
	
	//단건조회 콜백
	function ordDtManagementSelectResult(data){
		
		console.log(data);
		
		
		if(data.resultMsg == "SUCCESS"){
			areaVar.action = "U"
			 //모달 띄우기 
			 gfModalPop("#layer1");
			
			 frealPopModal(data.result);

		 }else{
			 alert(data.resultMsg);
		 }
		
	}

	function frealPopModal(object){

	          editVue.bord_CODE = object.bord_CODE;
		      editVue.jord_IN = object.jord_IN;
		      
		      console.log("aa : " +editVue.bord_CODE );
			  console.log("bb : " +editVue.jord_IN );
		      if(editVue.jord_IN == 1){
	          	editVue.flag = false;		    	  
		      }else{
	          	editVue.flag = true;		    	  
		      }
	       
	}
	//주문고객의 반품내역 리스트 메일 전송
	function updateModal(){	
		
		var param={
				action : areaVar.action,
				bordCode : editVue.bord_CODE,
				jordIn : editVue.jord_IN
		}
		console.log(param);
		var saveCallback = function(saveReturn){
    		
    		console.log("saveCallback : " + JSON.stringify(saveReturn));
    		
    		if(saveReturn.result == "UPDATED"){
    			alert("저장 되었습니다.");
    			gfCloseModal();
    			ordDtManagementList();
    		}else{
    			alert("실패 되었습니다.");

    		}
    	}
		
		callAjax("/pur/updateList.do", "post", "json", true, param, saveCallback);
	}
</script>

</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="currentPage" value=""> 
		<input type="hidden" id="currentPageModal" value=""> 

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
								<a class="btn_nav">기업고객</a>
								 <span class="btn_nav bold">주문내역 관리</span> 
								<a href="" class="btn_set refresh">새로고침</a>
							</p>
						
							<p class="conTitle">
								<span>주문내역 관리</span>
								
							</p>
						
							<div id="orderList">
							<div class="conTitle" style="margin: 0 25px 10px 0; " align=center>
							
							<select name="searchKey" id="searchKey">
								<option value="cpname" id="option1">업체명</option>
								<option value="pdname" id="option2">제품명</option>													
							</select>
							<input type="text" style="width: 160px; height: 30px;" id="searchWord" name="searchWord" onkeypress="if( event.keyCode == 13 ){searchOrdDtManagementList();}"> 
							<input type="date" style="width: 160px; height: 30px;" id="sdate" name="sdate" onkeypress="if( event.keyCode == 13 ){searchOrdDtManagementList();}"> 
							<input type="date" style="width: 160px; height: 30px;" id="edate" name="edate"  onkeypress="if( event.keyCode == 13 ){searchOrdDtManagementList();}"> 
							<a href="javascript:searchOrdDtManagementList()" class="btnType blue" onkeydown="enterKey()" name="search" ><span>검  색</span></a>
						    <!-- enter입력하면 검색실행   -->
						  
						   <span style="margin: 10px; ">
						   	<input type="checkbox" id="depositCheck" > 승인
						   </span>
						   
							</div>
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="15%">
										<col width="15%">
										<col width="15%">
										<col width="10%">
										<col width="20%">
										<col width="10%">
										<col width="10%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">발주번호</th>
											<th scope="col">발주회사</th>
											<th scope="col">발주제품</th>
											<th scope="col">발주수량</th>
											<th scope="col">날짜</th>
											<th scope="col">임원승인여부</th>
											<th scope="col">입금확인</th>											
										</tr>
									</thead>
									<tbody id="listOrdDtManagement" v-for="(item,index) in listitem"
													v-if="listitem.length">
													<tr @click="detailview(item.bord_CODE)">
														<td>{{ item.bord_CODE }}</td>
														<td>{{ item.loginID }}</td>
														<td>{{ item.model_NAME }}</td>
														<td>{{ item.bord_AMT }}</td>
														<td>{{ item.bord_DATE }}</td>
														<td>
                                                               <templete v-if="item.bord_TYPE == '1'">
                                                                   Y
                                                               </templete>
                                                               <templete v-else-if="item.bord_TYPE == '0'">
                                                                   N
                                                               </templete>
                                                               <templete v-else>
                                                                   미승인
                                                               </templete>														
														</td>
														<td>
                                                               <templete v-if="item.jord_IN == '1'">
                                                                   <!--  <a class="btnType3 color1" id="depositConfirm" href="javascript:confirmBtnClickEvent('${list.BORD_TYPE}', '${list.BORD_CODE}');"><span>확인</span></a> -->
                                                               		<div style="color: skyblue;font-weight: bold;">입금</div>
                                                               </templete>
                                                               <templete v-else>
                                                                   <div style="color: red;font-weight: bold;">미입금</div>
                                                               </templete>	
														</td>
													</tr>
									</tbody>
								</table>
								
								<!-- 페이징 처리 -->								
								<div class="paging_area" id="pagenavi" v-html="pagenavi">														
								</div> 																				
							</div>
									<!-- Modal 시작 -->
		<div id="layer1" class="layerPop layerType2" style="width: 300px; height: 200px;">
		<input type="hidden" id="bord_CODE" name="bord_CODE" value="${BORD_CODE}">
		<dl>
			<dt>
				<strong>발주 지시서</strong>
			</dt>
			<dd class="content">
				<!-- 테이블 페이지 네비게이션 영역 -->
				<div>
				<h2>입금완료 하시겠습니까?</h2>
				</div>	

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType gray" id="btnSave" name="btn" v-show="flag"><span>입금 완료</span></a>
					<a href=""	class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
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