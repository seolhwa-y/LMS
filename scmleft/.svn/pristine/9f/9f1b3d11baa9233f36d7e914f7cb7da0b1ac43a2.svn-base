<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Scm Left :: 반품신청 목록</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<jsp:include page="/WEB-INF/resource/js/common.js"></jsp:include>

<script type="text/javascript">
		
		var refundPageSize = 5;
		var refundPageBlock = 3;
		
		var refundarea;
		var refundeditvue;
		
		
		$(function() {
			
		init();
		
		refundInfoList();
		
		fButtonClickEvent();
	});
		
		function init(){
			
			refundarea = new Vue({
				el : '#refundlist',
				data : {
					refunditem : []
				},
				methods : {
					detailview : function(re_code) {
						rDtModal(re_code);
					}
				}
			});
			
			refundeditvue = new Vue({
				el : '#refundDirection',
				data : {
					re_code : "",
					model_NAME : "",
					re_DATE : "",
					re_AMT : "",
					re_PRICE : "",
					dir_CODE : "",
					model_NAMEread : "",
					re_DATEread : "",
					re_AMTread : "",
					re_PRICEread : "",
					dir_CODEread : "",
					re_TYPE : "",
					re_TYPEread : ""
				}
			})
		}
		
		
		
		function fButtonClickEvent(){
			$('a[name=btn]').click(function(e){
				e.preventDefault();   // ?? 
						
				var btnId = $(this).attr('id');			
				//alert("btnId : " + btnId);
				
				switch(btnId){
					case 'searchBtn' : refundInfoList(); 
						break;
					
					case 'btnGoToCEO' : btnGoToCEO();	// 모달 창 내에 _임원승인누르는 버튼 sweetalert 창 떠짐
						break;
					
					case 'btnClose' : gfCloseModal();  // 모달닫기 ->하면 refresh 되어야~~~ 
						//refundInfoList(); // 첫페이지 다시 로딩 
						break;

				}
			});
		}
		//리스트 출력 + 검색
		function refundInfoList(currentPage) {

		currentPage = currentPage || 1;
		
		var searchKey = document.getElementById('searchKey');
		
		var pdname = $('#pdname').val();		
		var sdate = $('#sdate').val();
		var edate = $('#edate').val();
		
		console.log("pdname : " + pdname);
		console.log("sdate : " + sdate);
		console.log("edate : " + edate);
		// console.log("searchKey : " + searchKey);
		
		var param = {
			searchKey : searchKey,
			pdname : pdname,			
			sdate : sdate.replaceAll("-",""),
			edate : edate.replaceAll("-",""),
			currentPage : currentPage,
			pageSize : refundPageSize

		}
		var resultCallBack = function(data){
			
			console.log("resultCallBack : " + JSON.stringify(data));
			refundInfoListResult(data, currentPage);
		}
		callAjax("/scm/refundInfoListVue.do", "post", "json", true, param, resultCallBack );
	} 
	
		
		
		//페이징
		 function refundInfoListResult(data, currentPage) {
				
		    	refundarea.refunditem = data.refundInfoList
		    	
		    	console.log(data.refundInfoList);
		    	
		    	var totalCnt = data.totalCnt;
		    	var list = $("#tmpList").val();
		    	
			    var pagingnavi = getPaginationHtml(currentPage, totalCnt, refundPageSize, refundPageBlock, 'refundInfoList', [list]);
				 
			   // console.log("pagingnavi : " + pagingnavi);
				
				$("#pagingnavi").empty().append(pagingnavi);
				//$("#currentPage").val(currentPage);
		    	
		    }		
			

			//모달창 띄우는것(가져와서씀)
			function gfModalPop(id) {

				//var id = $(this).attr('href');
				
				var maskHeight = $(document).height();
				var maskWidth = $(document).width();

				$('#mask').css({'width':maskWidth,'height':maskHeight});

				$('#mask').fadeIn(200);
				$('#mask').fadeTo("fast", 0.5);

				var winH = $(window).height();
				var winW = $(window).width();
				var scrollTop = $(window).scrollTop();

				$(id).css('top', winH/2-$(id).height()/2+scrollTop);
				$(id).css('left', winW/2-$(id).width()/2);

				$(".layerPop").hide();
				$(id).fadeIn(100); //페이드인 속도..숫자가 작으면 작을수록 빨라집니다.
			}
		 	 

		    //반품 지시서 모달 오픈 , 
		    function rDtModal(re_code) {
		       
		    	console.log("re_code : " + re_code);
		    	
		       var param = {
		    		   re_code : re_code
		          };
		          var searchcallback = function(data){
		        	console.log("searchcallback !!!! " +  JSON.stringify(data));
		             resultRDtModal(data);
		          }
		          callAjax("/scm/refundDtModal.do", "post", "json", true, param, searchcallback);
		    }
		    
		     //모달 콜백
		    function resultRDtModal(data) {		
		    	 
		    	 console.log("a : " + JSON.stringify(data) );
		    	
		    	 gfModalPop("#refundDirection");
		    	 refundmodal(data.result);
		    	 
		    	 console.log("aa" + data.result);
		    	 
		    }
		    
		     function refundmodal(object) { 
		    	 
		    	 console.log(object);
		    	 refundeditvue.model_NAME = object.model_NAME;
			     refundeditvue.re_DATE = object.re_DATE;
			     refundeditvue.re_AMT = object.re_AMT;
			     refundeditvue.re_PRICE = object.re_PRICE;
			     refundeditvue.re_TYPE = object.re_TYPE;
		     }
		     
		function  btnGoToCEO(re_code, status){
			
			/* sweetalert 창에 대한 버튼 */
				swal("반품 승인 요청하시겠습니까?", {
					  buttons:{
						  yes : "예",
						  no : "아니오"
					  }
					}).then((value) => {  /* 이건 이클립스가 게을러서 뜨는 에러!  */
						
						switch(value){
						case "yes": 
							var param =  {			 	
								 re_code : $("#re_code").val(),
								 status : "1",
								 dir_code : $("#dir_code").val(),
								 RE_AMT : $("#RE_AMT").val()
						}
					
						console.log( param);

						var resultCallbackbtn = function(data){
							swal("승인완료!");
							
							//처음화면으로 돌아가게끔
							refundInfoList(); 
							
							gfCloseModal(); // 모달 닫기	
						}			
							
							callAjax("/scm/updateRefund.do","post","json", true, param, resultCallbackbtn);	
							break;
						case "no": 
							break;
						
						}
					});
			
					
			}
		
		     
</script>
</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="currentPage" value="1"> <input
			type="hidden" id="tmpList" value=""> <input type="hidden"
			name="action" id="action" value=""> <input type="hidden"
			name="re_code" id="re_code" value=""> <input type="hidden"
			name="loginID" id="loginID" value="">

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
								<a class="btn_nav">거래내역</a> <span class="btn_nav bold">반품
									신청 목록</span> <a href="" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>반품 신청 목록</span> <span class="fr"> </span>
							</p>

							<div class="conTitle" style="margin: 0 25px 10px 0;" align=center>

								<!-- enter입력하면 검색실행   -->
								<span>제품명</span> <input type="text"
									style="width: 160px; height: 30px;" id="pdname" name="pdname"
									onkeypress="if( event.keyCode == 13 ){refundInfoList();}">
								<input type="date" style="width: 160px; height: 30px;"
									id="sdate" name="sdate"
									onkeypress="if( event.keyCode == 13 ){refundInfoList();}">
								<input type="date" style="width: 160px; height: 30px;"
									id="edate" name="edate"
									onkeypress="if( event.keyCode == 13 ){refundInfoList();}">
								<a href="javascript:refundInfoList()" class="btnType blue"
									id="searchBtn" name="btn"><span>검 색</span></a>
							</div>

							<div id="refundlist">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="25%">
										<col width="25%">
										<col width="20%">
										<col width="20%">

									</colgroup>

									<thead>
										<tr>
											<th scope="col">반품 제품명</th>
											<th scope="col">반품 완료날짜</th>
											<th scope="col">반품수량</th>
											<th scope="col">반품 금액</th>

										</tr>
									</thead>
									
									<tbody v-for="(item,index) in refunditem" v-if="refunditem.length != 0">
									<tr @click="detailview(item.re_code)">
										<td>{{ item.model_NAME }}</td>
										<td>{{ item.re_DATE }}</td>
										<td>{{ item.re_AMT }}</td>
										<td>{{ item.re_PRICE }}</td>
									</tr>
									</tbody>
								</table>

								<!-- 페이징 처리 -->
								 <div class="paging_area" id="pagingnavi"></div> 

							</div>

						</div> <!--// content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>

		<!-- 반품 지시서 모달 -->

		<div id="refundDirection" class="layerPop layerType2"
			style="width: 1000px; height: auto;">
			<input type="hidden" id="refund" name="modal">
			<dl>
				<dt>
					<strong>반품지시서</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->

					<table class="col" id="refundModalTable">
						<caption>caption</caption>
						<colgroup>

							<col width="8%">
							<col width="6%">
							<col width="8%">
							<col width="8%">

						</colgroup>

						<thead>
							<tr>
								<th scope="col">반품 제품명</th>
								<th scope="col">반품 완료날짜</th>
								<th scope="col">반품수량</th>
								<th scope="col">반품 금액</th>
							</tr>
						</thead>
						</tbody>
						<tr>
							<td id=""><input type="text" name="model_NAME" readonly
								id="model_NAME" v-model="model_NAME" /></td>
							<td id=""><input type="text" name="re_DATE" readonly
								id="re_DATE" v-model="re_DATE" /></td>
							<td id=""><input type="text" name="re_AMT" id="re_AMT"
								readonly v-model="re_AMT" /></td>
							<td id=""><input type="text" name="re_PRICE" id="re_PRICE"
								readonly v-model="re_PRICE" /></td>
						</tr>
					</table>

					<div class="btn_areaC mt30">
					<templete v-if='re_TYPE == "0"'>
						<a href="javascript:btnGoToCEO()" class="btnType blue"><span>승인요청</span></a>
					</templete>
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop" id="btnX"><span class="hidden">닫기</span></a>
		</div>

	</form>
</body>
</html>