<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 제품 목록</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://unpkg.com/axios@0.12.0/dist/axios.min.js"></script>
<script src="https://unpkg.com/lodash@4.13.1/lodash.min.js"></script>
<script src="${CTX_PATH}/js/view/cor/shoppingCart/shoppingCart.js"></script>
<style>
img {
width: 50px; height: 50px; margin : 10px;
}
</style>

<script type="text/javascript">
	
	//페이징
	var pageSize = 10;    	
	var pageBlock = 5;	
	
	var productlist;
	var productvue;
	
	//onload
	$(document).ready(function(){
		
		comcombo("proCD", "prolargeall", "all", ""); // 제품 구분  prolargeall : selectbox ID   value :  detail_code
		
		$("#prolargeall").change(function() {
			productCombo($("#prolargeall").val(), "prodall", "all",  "");   // 제품정보   prodall : selectbox ID   value : MODEL_CODE
		});
		
		init();
		//목록조회
		pListInfo();
		//버튼
		pRegisterButtonClickEvent();
		
	});
	
	
	// vue.js
	function init() {
		
		//제품 리스트
		productlist = new Vue({
			el:'#divProductList',
			components: {
				'bootstrap-table': BootstrapTable
			},
			data: {
				listItem:[],
				action:""
		    },
		    methods:{
		    	detailview:function(no){
		    		alert(no);
		    		pDetailModal(no);
		    	}
		    }
			
		});
		
		productlistvue = new Vue({
			el: '#productInfo',
			data: {
					model_code:"",
					model_name:"",
					pd_code:"",
					pd_name:"",
					pd_corp:"",
				    pd_price:"",
					//pd_nadd:"",
					delflag:true
				}
		});
		
	}
	
	
	//버튼 이벤트
	
	function pRegisterButtonClickEvent(){
		$('a[name=btm]').click(function(e){
			e.preventDefault();
			
			var btnId = $(this).attr('id');
			switch (btnId) {
				case 'btnBModalClose' :
					gfCloseModal();
					break;			
		}
	});
	}
	
	//제품리스트
	function pListInfo(currentPage){
		currentPage = currentPage || 1;
		
		var param = {
				currentPage : currentPage,
				pageSize : pageSize
				
		}
		
		var resultCallback = function(data){
			console.log("제품리스트 resultCallback: "  + JSON.stringify(data));
			pListInfoResult(data, currentPage);
		}
		
		callAjax("/cor/productList.do", "post", "json", true, param, resultCallback);
	}
	
	//리스트 데이터를 콜백함수를 통해 뿌리기
	function pListInfoResult(data, currentPage){
		console.log("제품목록  data :" + data);
		productlist.listItem = data.product;
		
		var totalCntList = data.totalCnt;
		var list = $("#selectedInfNo").val();
		
		var paginationHtml = getPaginationHtml(currentPage, totalCntList, pageSize, pageBlock,'pListInfo', [list]);
		console.log("제품목록 paginationHtml : " + paginationHtml);
		
		$("#productPaging").empty().append(paginationHtml);
		
	}
	
	function p_action(){
		productlist.ation = "I";
		
		frealPopModal();
		gfModalPop("#productInfo");
		
	}
	
	// 제품 상세조회 
	function pDetailModal(result){
		var param = {result : result};
		var resultCallback2 = function(data){
			 console.log("resultCallback2 : " + JSON.stringify(data));
			
			 pDetailResult(data);
		};
		
		callAjax("/cor/detailproduct.do", "post", "json", true, param, resultCallback2);
	}
	
	
	function pDetailResult(data){
		if(data.resultMsg == "SUCCESS"){
			
			productlist.action = "U"
			
			gfModalPop("#productInfo");
			
			frealPopModal(data.result);	
		}else{
			alert(data.resultMsg);
		}
	}
	
	function frealPopModal(object){
		
		if(productlist.action == "I") {
			productlistvue.model_code = "";
			productlistvue.model_name = "";
			productlistvue.pd_code = "";
			productlistvue.pd_name = "";
			productlistvue.pd_corp = "";
			productlistvue.pd_price = "";
			//productlistvue.pd_nadd = "";
			 
			productlistvue.delflag = false;
			 
		 } else {
			 productlistvue.model_code = object.model_code;
			 productlistvue.model_name = object.model_name;
			 productlistvue.pd_code = object.pd_code;
			 productlistvue.pd_name = object.pd_name;
			 productlistvue.pd_corp = object.pd_corp;
			 productlistvue.pd_price = object.pd_price;
			 //productlistvue.pd_nadd = object.pd_nadd;
			 
			 productlistvue.delflag = true;
		 }
		 
	 }
	

</script>

</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="currentPage" value=""> 
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
						
						<!-- 타이틀 영영 -->
						<div class="content" style="margin-bottom: 20px;">
							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
								<span class="btn_nav bold">메인</span> <a
									href="../dashboard/dashboard.do" class="btn_set refresh">새로고침</a>
							</p>
							<div>
								<p class="conTitle" style="margin-bottom: 1%;">
									<span>제품 목록</span> <span class="fr"> 관련 자료 </span>
								</p>
							</div>
							
							<!-- 서치바 -->
							<div>
								<table style="margin: auto;">
									<!-- 장비구분 선택  -->
									<tr>
										<td>
										<select id = "prolargeall" name = "prolargeall"  style="margin-right:10px;"></select>
										</td>
									<!-- 제조사 선택 -->	
										<td>
										<select id = "prodall" name = "prodall"  style="margin-right:10px;"></select>
										</td>
									<!-- 검색 -->		
										<td colspan = 5 >
										<input type = "text" id = "inpSerName" style="height: 28px;"/>
										<a class="btnType blue" id="btnSearch" name="btn" onClick = "productSearch()"><span>검색</span></a>
										</td>
									<tr>
								</table>
							</div>
							<br>
							
							<!-- 제품 목록 -->
							<div id="divProductList" style="height: 34.81rem; overflow: auto;">
								<div class="bootstrap-table">
								<table class="col">
									<thead>
										<tr>
											<th scope="col">모델번호</th>
											<th scope="col">모델구분</th>
											<th scope="col">제품번호</th>
											<th scope="col">제품명</th>
											<th scope="col">제조사</th>
											<th scope="col">판매가격</th>
										</tr>
									</thead>
									<tbody id = "productTBody" v-for="(item,index) in listItem" v-if="listItem.length">
										<tr @click="  detailview(item.model_code)">
											<td>{{ item.model_code }}</td>
											<td>{{ item.model_name }}</td>
											<td>{{ item.pd_code }}</td>
											<td>{{ item.pd_name }}</td>
											<td>{{ item.pd_corp }}</td>
											<td>{{ item.pd_price }}</td>
										</tr>
										
									</tbody>
								</table>
								
						</div>
					</div>
					<div class="paging_area" id="productPaging" ></div>
							<br>
						<!-- 모달 :: 제품상세보기 -->					
							<div id="productInfo" class="layerPop layerType2" style="width:60rem; height: 25rem;">
								<dl>
									<dt><strong>제품 상세보기</strong></dt>
									<dd class="content">
										<div style="margin-bottom: 1rem;">
										</div>
										<div style="height: 6rem;">
											<table class='col'>
												<tbody>
													<tr>
														<th scope="row">모델번호</th>
														<td>{{ model_code }}</td>
														<th scope="row">제품이미지</th>
														<td colspan="2" style="text-align:center;">
														<img id="tempImg" style="object-fit: cover;max-width:100%" src="" alt="제품사진미리보기">
														</td>
													</tr>
													<tr>
														<th scope="row">제조사</th>
														<td>{{ pd_corp }}</td>
														<th scope="row">주문수량</th>
														<td><input type="number" id="od_qty" name ="od_qty" value="1" min="1"/></td>
													</tr>
											
													<tr>
														<th scope="row">판매가격 </th>
														<td>{{ pd_price }}</td>
														
														<th scope="row">납품희망일</th>
														<td><input type="date"/></td>
							                           	
													</tr>
													<tr>
														<th scope="row">상세정보</th>
														<td colspan="3">
														<textarea id="pro_det" maxlength="500" name="pro_det" style="height:130px;outline:none;resize:none;" placeholder="여기에 상세정보를 적어주세요.(500자 이내)"></textarea>
														</td>
													</tr>
												</tbody>
											</table>
									</div>
									
									<!-- e : 여기에 내용입력 -->
									<div class="btn_areaC" style="margin-top: 14em;">
										<a class="btnType blue" id="btnBorderDirec" name="btn"><span>장바구니 담기</span></a>	
										<a class="btnType blue" id="btnBorderDirec" name="btn"><span>주문하기</span></a>
										<a href="javascript:gfCloseModal();"class="btnType gray" id="btnBModalClose" name="btn"><span>취소</span></a>
									</div>
								</dd>
							</dl>
							
						</div>
						
					</li>
				</ul>
			</div>
		</div>
	</form>
</body>
</html>