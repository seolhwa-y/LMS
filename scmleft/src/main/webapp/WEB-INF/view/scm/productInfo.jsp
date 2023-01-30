<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>제품정보 관리</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<!-- duDatePicker import css-->
<link rel="stylesheet" type="text/css"
	href="${CTX_PATH}/css/duDatePicker/duDatepicker.css">
<!-- duDatePicker import js -->
<script type="text/javascript"
	src="${CTX_PATH}/js/duDatePicker/duDatepicker.js"></script>

<script type="text/javascript">

	// 페이징 설정 
	var pageSize = 10;    	// 화면에 뿌릴 데이터 수 
	var pagenumSize = 5;		// 블럭으로 잡히는 페이징처리 수
	
	var productarea;
	var seacharea;
	
	/* onload 이벤트  */
	$(document).ready(function() {
		
		//userCombo("usr", "F", "usrall", "all", "");   // 사용자 정보 : F : usertype      usrall :selectbox ID   value : loginID          all : 전체     sel : 선택 
		
		init();
		
		//  제품정보관리 리스트 조회  
		fselectProductList();
		
		// 버튼 이벤트 등록
		fButtonClickEvent();
			
	});
	
	
	function init() {
		
		productarea = new Vue({
			el : '#productList', // #은 id값으로 넘겨준다 .은 class
			data : {
				listitem:[], // 변수선언 ex.<tbody v-for="(item, index) in SupplierListItem" v-if="SupplierListItem.length">
				action : "",
			},
			methods : {
				DetailProduct : function(mdCode) { //파라미터로 넘어오는 변수는 db 변수와 다르게 표기 
					fdetailModal(mdCode);
				}		
		     }
	   });
		
		productvue = new Vue({
			el : '#productsave',
			data : {
				modelCode : "",
				pdCode :"",
				pdName : "",
				modelName : "",
				pdCorp : "",
				pdPrice : "",
				company : "",
				pdfileCode : "",
				pdDetail : "",
			    pdfileName : "",
			    pdNadd : "/images/admin/comm/no_image.png",
			    pdMadd : "",
			    pdSize : "",
				loginId:"",
				
			},
		    methods:{    //파일업로드 미리보기           
                      selimg:function(event){                    	         
                                var image = event.target;
               
                                if(image.files[0]){
                                   //alert(window.URL.createObjectURL(image.files[0]));// 임시주소 생성됨
                                   
                                   this.pdNadd =  window.URL.createObjectURL(image.files[0]);
                                }
                            },
                            //사진 클릭하면 다운로드 
                            download: function() {
                            	filedown();
                            }       
                   }
		});
		//검색
		searcharea = new Vue({
			el : '#searchproduct',
			data : {
				search : "",
				select : "all"
			}
		});
	}
	
		
	/* 버튼 이벤트 등록 - 저장, 수정, 삭제  */
 	function fButtonClickEvent(){
		$('a[name=btn]').click(function(e){
			e.preventDefault();   
					
			var btnId = $(this).attr('id');
			
			switch(btnId){
			case 'btnSavePro' : fProductSave(); // save 안에 저장,수정
				alert("저장버튼 클릭!!!이벤트!!");
				break;
			case 'btnDeletePro' : fDeleteProduct();	// 만들자 
				alert("삭제버튼 클릭!!!이벤트!!");		
				break;
			case 'btnClose' : gfCloseModal();  // 모달닫기 			
				break;
			case 'serachbtn' : fselectProductList();  // 검색하기
			break; 
			
			}
		});
	} 
	
	
	/* 제품정보 목록 불러오기  */
	function fselectProductList(pagenum){
		
		pagenum = pagenum || 1;   // or		
		
		var param = {
				search : searcharea.search,
				select : searcharea.select,
				currentPage : pagenum ,
				pageSize : pageSize 
		}
		
		var resultCallback = function(returndata){  // 데이터를 이 함수로 넘깁시다. 
			productListResult(returndata, pagenum); 
		}
		
		callAjax("/scm/productInfoList.do","post","json", true, param, resultCallback);
		// js로 할때는 json말고 text로 넘겨줌 
		
	}
	

	 /* 제품정보 리스트 data를 콜백함수를 통해 뿌려봅시당   */
	 function productListResult(data, currentPage){
		
		 // 뷰로 바꾸기 
		productarea.listitem = data.productInfoList; // productInfoList : 컨트롤러에서 넘겨 온 값  
		
		console.log(data);
		console.log(data.productInfoList);
		console.log(searcharea.search);
		console.log(searcharea.select);
		
		
		// 총 개수 추출
		var totalCnt = data.totalCnt;
		var list = $("#currentPageProduct").val();

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCnt,
				pageSize, pagenumSize, 'fselectProductList',
				[ list ]);

		$("#pagingnavi").empty().append(paginationHtml);
		 
		 
		 
	/* 	 // 기존 자바스크립트 방법 
		 // 일단 기존 목록을 삭제합니다. (변경시 재부팅 용)
		 $("#productList").empty();
		 console.log("data !!!! " +  data);
		 
		 
		 $("#productList").append(data);
			 
		 // 리스트의 총 개수를 추출합니다. 
	     var totalCnt = $("#totalCnt").val();  // qnaRealList() 에서보낸값 
	     //alert("totalCnt 찍어봄!! " + totalCnt);
		 		 
	    // var list = $("#tmpList").val();
	     
		 //var listnum = $("#tmpListNum").val();
	     var pagingnavi = getPaginationHtml(currentPage, totalCnt, pageSize, pagenumSize, 'fselectProductList');
		 
	     
	     console.log("pagingnavi : " + pagingnavi);
		 // 비운다음에 다시 append 
	     $("#pagingnavi").empty().append(pagingnavi); // 위에꺼를 첨부합니다. 
		 
		 // 현재 페이지 설정 
	    $("#currentPage").val(currentPage); */
	    
		 
	 }
	 
			 
	 /*1건 상세 조회*/
 	 function fdetailModal(modelCode){ 
		 alert(" 상세 조회  ");
		 
		 productarea.action ="U";
		 		 
		 var param = {modelCode : modelCode};
		 //console.log(param);
		 
		 var resultCallback2 = function(data){
			 console.log("aa : " + JSON.stringify(data));
			 fdetailResult(data);
		 };
		 
		 callAjax("/scm/productOne.do", "post", "json", true, param, resultCallback2);
		 //alert(" 상세 조회  22");		 
	 } 
	 
	 /*  1건 상세 조회 -> 콜백함수   */
 	 function fdetailResult(data){

		 //alert("상세 조회  33");
		 //모달 띄우기 
		  gfModalPopTop("#productsave");
			 
		 //alert(data.result);
		// 모달에 정보 넣기 
		frealPopModal(data.result);		 
	 } 
	 
 	 /* ****게시글 신규 등록******** */
 	   function fProductNew(){
 		  
 		  productarea.action = "I"	   		   
 		  frealPopModal();	   
 		 gfModalPopTop("#productsave");
 		  
 	   }
 	   
 	   /* ********게시글 저장 ************/
/*  	   function  fProductSave(){	   
 		  productarea.action == "I" ? alert("I") : alert("U");
 	       
 		   var param = {
 	             action : productarea.action,
 	             modelCode : productvue.modelCode,
 	             pdCode : productvue.pdCode,
 	             pdName : productvue.pdName,
 	             modelName : productvue.modelName,
 	             pdCorp : productvue.pdCorp,
 	             pdPrice : productvue.pdPrice,
 	             name : productvue.name,
 	             pdCode : productvue.pdCode,
 	             pdDetail : productvue.pdDetail,
 	             loginId : productvue.loginId
 	           }
 	       console.log(param);
 	       
 	       var saveCallBack = function(saveReturn){
 	          console.log("data Check ::  " + JSON.stringify(saveReturn));
 	          
 	          if(!saveReturn.resultMsg.includes("FALSE")) {
 	             alert("저장"); 
 	          }
 	          else alert("실패");
 	          
 	          gfCloseModal();
 	          fselectProductList();
 	          
 	       }
 	       
 	       callAjax("/scm/productSave.do", "post", "json", true, param, saveCallBack);
 	    }
	 */
	 
	 /*제품정보 저장 수정 */
 	  function fProductSave() {
		 
		 productarea.action == "I" ? alert("I") : alert("U");
 			
		 	//액션 값 넘기기 
		    $("#action").val(productarea.action);
		 		 
 			var frm = document.getElementById("myProduct"); //form id="myProduct"
 			frm.enctype = 'multipart/form-data'; // 파일업로드 
 			var dataWithFile = new FormData(frm);
 			
 			var saveCallBack = function(saveReturn){
 	 	          console.log("data Check ::  " + JSON.stringify(saveReturn));
 	 	          
 	 	          if(saveReturn.resultMsg != "FALSE") {
 	 	        //if(!saveReturn.resultMsg.includes("FALSE")) {
 	 	             alert("저장"); 
 	 	          }
 	 	          else alert("실패");
 	 	          
 	 	          gfCloseModal();
 	 	          fselectProductList();
 	 	     }
    		
 			callAjaxFileUploadSetFormData("/scm/productSave.do", "post", "json", true, dataWithFile, saveCallBack);
 		}
 	   
 	   
 	// 팝업(신규등록 및 수정)
 	function frealPopModal(object){
 		
 		console.log(object);
 		
 		if (productarea.action == "I") {
 			productvue.modelCode = "";
 			productvue.pdCode = "";
 			productvue.pdName = "";
 			productvue.modelName = "";
 			productvue.pdCorp = "";
 			productvue.pdPrice = "";
 			productvue.company = "";
 			productvue.pdDetail = "";
 			productvue.loginId = "";
 			productvue.pdfileCode = "";
 			
 			productvue.pdfileName = "";
 			productvue.pdNadd = "/images/admin/comm/no_image.png";
 			productvue.pdMadd = "";
 			productvue.pdSize = "";
 			
 			$("#thumbnail").val("");
 			
 		} else {
 			//console.log(object.pdName);
 			productvue.modelCode = object.modelCode;
 			
 			//
 			$("#modelCode").val(object.modelCode);
 			
 			productvue.pdCode = object.pdCode;
 			productvue.pdName = object.pdName;
 			productvue.modelName = object.modelName;
 			productvue.pdCorp = object.pdCorp;
 			productvue.pdPrice = object.pdPrice;
 			productvue.company = object.company;
 			productvue.loginId = object.loginId;
 			productvue.pdDetail = object.pdDetail;
 			productvue.pdfileCode = object.pdfileCode; 
 			
 			productvue.pdfileName = object.pdfileName;
 			productvue.pdNadd = object.pdNadd;                                     
 			productvue.pdMadd = object.pdMadd;
 			productvue.pdSize = object.pdSize;
 		}
 	}

 
 // 첨부파일 다운로드 (사진 클릭하면 다운로드)
 //modelCode로 단건 조회 했기때문에 가져오기 
	function filedown(){
 	 	var params = "";
		params += "<input type='hidden' name='modelCode' value='"+ $("#modelCode").val() +"' />"; 	
		jQuery("<form action='/scm/fileDown.do' method='post'>"+params+"</form>").appendTo('body').submit().remove(); 			
	} 
	 
    /*//자바스크립트 jstl 방법으로 한것  
	/* 팝업 _ 초기화 페이지(신규) 혹은 내용뿌리기  
	 function frealPopModal(object){
		 
		
		if(object == null || object==""){
			$("#modelCode").val(""); //value 값으로 받아 올때는 .val 
			 $("#pdCode").val("");
			 $("#pdName").val("");
			 $("#modelName").val(""); //.text
			 $("#pdCorp").val("");
			 $("#pdPrice").val("");
			 $("#name").val("");
			 $("#pdfileCode").val("");
		} else {
			 $("#modelCode").val(object.modelCode); //value 값으로 받아 올때는 .val 
			 $("#pdCode").val(object.pdCode);
			 $("#pdName").val(object.pdName);
			 $("#modelName").val(object.modelName); //.text
			 $("#pdCorp").val(object.pdCorp);
			 $("#pdPrice").val(object.pdPrice);
			 $("#name").val(object.name);
			 $("#pdfileCode").val(object.pdfileCode);			
		}

		
		 //$("#shCode").text(object.sh_code);
		
		 //모달팝업 
		 gfModalPop("#layer2");	
			 
    }  */
	 
 	 /* 제품정보관리 모달창(팝업) 실행  여기부터 
  	  function pdModalOpen(modelCode) {
		 
		 // 신규저장 하기 버튼 클릭시 (값이 null)
		  if(modelCode == null || modelCode==""){
			
			$("#action").val("I"); // insert 
			frealPopModal(); //  초기화 
			
			//모달 팝업 모양 오픈! (빈거) _ 있는 함수 쓰는거임. 
			gfModalPop("#productsave");
			
		 }else{
			$("#action").val("U");  // update 
			fdetailModal(mdCode); //번호로 -> 상품 상세 조회 팝업 띄우기
		 }

	 };  */
	 
	 
 	 //검색  
/* 	 function board_search(currentPage) {
	      
	      currentPage = currentPage || 1;
	         
	         var sname = $('#sname');
	         var oname = $('#oname');
	         
	         var param = {
	        		 sname : sname.val()
	        	   , oname : oname.val()
	               ,   currentPage : currentPage
	               ,   pageSize : userPageSize
	         }
	         
	         var resultCallback = function(data) {
	        	 productListResult(data, currentPage); 
	         };
	         
	         callAjax("/scm/productList.do", "post", "text", true, param, resultCallback);
	   }  */
	 
	 
	 
	 /* 팝업내 수정, 저장 validation */
/* 	 function fValidatePopup(){
		 var chk = checkNotEmpty(
				 [
					 ["pro_no", "제품번호를 입력해주세요!"],
					 ["pro_name", "제품명을 입력해주세요!"],
					 ["ware_no", "저장창고를 선택해주세요!"],
					 ["pro_cd", "제품코드를 선택해주세요!"],
					 ["pro_model_name", "모델명을 입력해주세요!"],
					 ["pro_manu_name", "제조사를 입력해주세요!"],
					 ["pro_price", "제품 가격을 입력해주세요!"],
					 ["deli_no", "납품업체를 선택해주세요!"],
					 ["pro_deli_price", "납품단가를 입력해주세요!"],
					 ["thumbnail", "대표 이미지를 업로드해주세요!"]
				 ]
		 );
		 
	 
	 	if(!chk){return;}
	 	return true;
	 } */
	 
	 /* 제품 등록(저장) */
/* 	 function fSaveProduct(){
		 
		 //alert("저장 함수 타는지!!!!!?? ");
		 // validation 체크 
		 if(!(fValidatePopup())){ return; }
		 
		 var resultCallback3 = function(data){
			 fSaveProductResult(data);
			
		 };
		//form
		var frm = document.getElementById("myProduct");
		frm.enctype = 'multipart/form-data';
		var dataWithFile = new FormData(frm); */
		
		//다중 selected option값 가져오기
/* 		var selected=[];
		 $('#ware_no :selected').each(function(){
		     selected.push($(this).val());
		    });
		 //form에 추가
		 dataWithFile.append("ware_list", selected);
		 
		 $("#action").val("I");  // insert
		 
		 callAjaxFileUploadSetFormData("/scm/productSave.do", "post", "json", true, dataWithFile, resultCallback3);
		 
	 } */
	 
	 
	 /* 저장 ,수정, 삭제 콜백 함수 처리  */   
/* 	 function fSaveProductResult(data){
		 var currentPage = currentPage || 1; 
		
		 if($("#action").val() != "I"){
			 currentPage = $("#currentPage").val();
		 }
		 
		 if(data.resultMsg == "SUCCESS"){
			 //alert(data.resultMsg);	// 받은 메세지 출력 
			 alert("저장 되었습니다.");
		 }else if(data.resultMsg == "UPDATE") {
			 alert("수정 되었습니다.");
		 }else if(data.resultMsg == "DELETE") {
			 alert("삭제 되었습니다.");
		 }else{
			 alert(data.resultMsg); //실패시 이거 탄다. 
			 alert("실패 했습니다.");
		 }
		 
		 gfCloseModal();	// 모달 닫기
		 selectProductList(currentPage); // 목록조회 함수 다시 출력 
		 frealPopModal();// 입력폼 초기화
	 } */
	 
	 /* 제품 수정 */
/* 	 function fUpdateProduct(){
		 
		 // validation 체크 
		 if(!(fValidatePopup())){ return; }
		 
		
		 
		 var resultCallback3 = function(data){
			 fSaveProductResult(data);
		 };
		 
		
			//form	
			var frm = document.getElementById("myProduct");
			frm.enctype = 'multipart/form-data';
			var dataWithFile = new FormData(frm);
			
			//다중 selected option값 가져오기
			var selected=[];
			 $('#ware_no :selected').each(function(){
			     selected.push($(this).val());
			    });
			 //form에 추가
			 dataWithFile.append("ware_list", selected);
			 
			 $("#action").val("I");  // insert
		
		
		 $("#action").val("U");  // update
		 
		 callAjaxFileUploadSetFormData("/scm/productUpd.do", "post", "json", true, dataWithFile, resultCallback3);
	 	
	 	
	 } */
	 
	 /* 상품 1건 삭제  */
/* 	 function fDeleteProduct(){
		 var con = confirm("정말 삭제하겠습니까? \n 삭제시 복구불가합니다."); 
		 if(con){
			 var resultCallback3 = function(data){
				 fSaveProductResult(data);
			 }
			 $("#action").val("D");  // delete
			 callAjax("/scm/productDel.do", "post", "json", true, $("#myProduct").serialize(), resultCallback3);
		 }else{
			 gfCloseModal();	// 모달 닫기
			 selectProductList(currentPage); // 목록조회 함수 다시 출력 
			 frealPopModal();// 입력폼 초기화
		 }
	 } */
	 
/* 	 // 숫자타입체크
	 function filterNumber(elem, event){
			elem.value=elem.value.replace(/[^0-9]/g,"");
			var code = event.keyCode;
			if((code>47&&code<58)||event.ctrlKey||event.altKey||code==8||code==9||code==46){
				return;
			}
			event.preventDefault();
			return false;
		}
		function filterNum(elem){
			elem.value=elem.value.replace(/[^0-9]/g,"");
		}
		 */

</script>
</head>
<body>

<form id="myProduct" action="" method="">
	
	<input type="hidden" id="currentPage" value="1">  <!-- 현재페이지는 처음에 항상 1로 설정하여 넘김  -->
	<input type="hidden" id="currentPageProduct" value="1"> 
	<input type="hidden" id="tmpListNum" value=""> <!-- 스크립트에서 값을 설정해서 넘길거임 / 임시 리스트 넘버 -->
	<input type="hidden" name="action" id="action" value=""> 
	
	<input type="hidden" name="modelCode" id="modelCode" value=""> 
	
	 <!-- <input type="hidden" id="swriter" value="${writer}"> 작성자 session에서 java에서 넘어온값 -->
	
	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> 
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href=/dashboard/dashboard.do" class="btn_set home">메인으로</a> 
							<a href="#" class="btn_nav">기준 정보</a> 
								<span class="btn_nav bold">제품정보 관리</span> 
								<a onClick="top.location='javascript:location.reload()'" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>제품정보 관리 </span> <span class="fr"> 
								<c:set var="nullNum" value=""></c:set>
								<a class="btnType blue" href="javascript:fProductNew();" name="modal">
								<span>신규등록</span></a>
								
							</span>
						</p>
						
					<!--검색창   -->
					<div id="searchproduct">
					<table width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="border-collapse: collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="100" height="25" style="font-size: 120%">&nbsp;&nbsp;</td>
                           <td width="50" height="25" style="font-size: 100%; text-align:right;padding-right:25px;">
     	                       <select id="select" name="select" style="width:130px;height:27px" v-model="select">
						        <option value="all">전체</option>
						        <option value="pro_no">제품 코드</option>
						        <option value="pro_nm">제품명</option>
						        <option value="model_nm">모델명</option>
						        <option value="pd_corp">제조사</option>
						      </select>
						      
     	                       <input type="text" style="width: 150px ; height: 25px;" id="search" name="search" v-model="search" >                    
	                           <a href="" class="btnType blue" id="serachbtn" name="btn"><span>검  색</span></a>
                           </td> 
                           
                        </tr>
                     </table> &nbsp;&nbsp;
						</div>
						
						<div id="productList">
							<table class="col">
								<caption>caption</caption>
	
								<thead>
									<tr>
									      <th scope="col"></th>
							              <th scope="col">모델명</th>
									      <th scope="col">제품 코드</th>							              
							              <th scope="col">제품명</th>
							              <th scope="col">제조사</th>
							              <th scope="col">판매가</th>
							              <th scope="col">납품 업체</th>							              
									</tr>
								</thead>
								<!--기존 자바스크립트 방법  <tbody id="productList"></tbody> -->
								<tbody>
										<tr v-for="(item, index) in listitem"
										v-if="listitem.length > 0" @click="DetailProduct(item.modelCode)"> <!-- db모델이랑 똑같이  -->
											<td>{{ item.modelCode }}</td>
											<td>{{ item.modelName }}</td>
											<td>{{ item.pdCode }}</td>
											<td>{{ item.pdName }}</td>
											<td>{{ item.pdCorp }}</td>
											<td>{{ item.pdPrice }}</td>
											<td>{{ item.company }}</td>
											<%-- <td>
				   								<fmt:formatNumber value="{{item.pdPrice}}" pattern="#,###,###,###"></fmt:formatNumber>
											</td> --%>
										</tr>
										<tr v-else>
											<td colspan = "7">데이터 없어요</td>
										</tr>
								</tbody>
							</table>
							
						</div>
                    </div> <!--// content -->
                   <!-- 페이징 처리  -->
				   <div class="paging_area" id="pagingnavi"></div>	
                    
					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 제품정보관리 모달 -->
		<div id="productsave" class="layerPop layerType2" style="width: 900px; height: auto;">
		<input type="hidden" id="loginID" name="loginID"> <!-- 수정시 필요한 num 값을 넘김  -->
           <dl>
			<dt>
				<strong>제품정보 관리</strong>
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
					<!-- 	<tr>
							<th scope="row">제품 번호 <span class="font_red">*</span></th>
							<td colspan="3"><input class = "ui-widget ui-widget-content ui-corner-all" style="height:20px;" type="text" maxlength="15" name="modelCode" id="modelCode" v-model="modelCode" /></td>
													
						</tr> -->
						<tr>
							<th scope="row">제품 코드 <span class="font_red">*</span></th>
							<td colspan="3"> <input class = "ui-widget ui-widget-content ui-corner-all" style="height:20px;" type="text" maxlength="15" name="pdCode" id="pdCode" v-model="pdCode" /></td>
						</tr>	
					<%-- 	<tr>
							<th scope="row">저장 창고 <span class="font_red">*</span></th>
							<td colspan="3">  
							<select name="ware_no" id="ware_no" data-placeholder="1개 이상의 창고를 선택하세요." 
							multiple class="chosen-select">
								<c:forEach var="tempCdlist2" items="${whListObj}">
						         	<option value="${tempCdlist2.ware_no}">${tempCdlist2.ware_name}( ${tempCdlist2.ware_dt_address} )</option>
						        </c:forEach>
							</select>
							</td>	
						</tr> --%>					
						<tr>
							<th scope="row">제품명 <span class="font_red">*</span></th>
							<td><input class = "ui-widget ui-widget-content ui-corner-all" style="height:20px;" type="text" maxlength="15" name="pdName" id="pdName" v-model="pdName"></td>
							
							<th scope="row">모델명 <span class="font_red">*</span></th>
							<td><input class = "ui-widget ui-widget-content ui-corner-all" style="height:20px;" type="text" maxlength="15" name="modelName" id="modelName" v-model="modelName"/></td>
						</tr>
						<tr>
							<th scope="row">제조사 <span class="font_red">*</span></th>
							<td><input class = "ui-widget ui-widget-content ui-corner-all" style="height:20px;" type="text" maxlength="15" name="pdCorp" id="pdCorp" v-model="pdCorp"/></td>
							
							<th scope="row">제품 가격 <span class="font_red">*</span></th>
							<td><input class = "ui-widget ui-widget-content ui-corner-all" style="height:20px;" type="text" maxlength="10" name="pdPrice" id="pdPrice" v-model="pdPrice" style="ime-mode: disabled;"  ></td>							
						</tr>
						<tr>
							<th scope="row">납품 업체 <span class="font_red">*</span></th>
							<td>  
							   <select id="loginId"  name="loginId" v-model="loginId">
                                 <option value="">선택</option>
                                 <option value="fadmin">ASUS</option>
                                 <option value="naadmin">납품업체1</option>
                                 <option value="naadmin1">납품업체2</option>
                                 <option value="naadmin2">납품업체3</option>
                                 <option value="naadmin4">납품업체4</option>
                                 <option value="zoo2234">한성</option>
                                 <option value="wallmart">월마트일렉트로닉스</option>
                               </select>
							</td>
						</tr> 
						
						<tr>
							
							<th scope="row">상세 정보 <span class="font_red">*</span></th>
							<td colspan="3">
							<textarea class = "ui-widget ui-widget-content ui-corner-all" id="pdDetail" maxlength="500" name="pdDetail" v-model="pdDetail" style="height:130px;outline:none;resize:none;" placeholder="여기에 상세정보를 적어주세요.(500자 이내)"></textarea>
							</td>
								
						</tr>		

						<!-- 첨부파일&다운로드  -->
						<tr>
		                    <th scope="row">대표 이미지 <span class="font_red">*</span></th>
		                    <td class="thumb">
		                        <span> 
								    <input name="thumbnail" type="file" id="thumbnail" @change="selimg">
		                        </span>
						   </td>
						   <td colspan="2" style="text-align:center;">
						       {{pdfileName}}
							   <img id="tempImg" style="object-fit: cover;max-width:100%" v-bind:src="pdNadd" @click="download()" alt="제품사진미리보기">
						   </td>
                	</tr>		
						
					</tbody>
					
				</table>
				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnUpdatePro" name="btn" style="display:none"><span>수정</span></a> 
					<!-- <a href="" class="btnType blue" id="btnDeletePro" name="btn" ><span>삭제</span></a>  -->
					<a href="" class="btnType blue" id="btnSavePro" name="btn"><span>저장</span></a>			
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
		    </dd>
          </dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
     </div>

	

</form>

</body>
</html>
