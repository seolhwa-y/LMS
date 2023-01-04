<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>배송 지시서</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<!-- duDatePicker import css-->
<link rel="stylesheet" type="text/css"
	href="${CTX_PATH}/css/duDatePicker/duDatepicker.css">
<!-- duDatePicker import js -->
<script type="text/javascript"
	src="${CTX_PATH}/js/duDatePicker/duDatepicker.js"></script>

<script type="text/javascript">	
</script>
</head>
<script type="text/javascript">

	// 페이징 설정 
	var pageSize = 10;    	// 화면에 뿌릴 데이터 수 
	var pagenumSize = 5;		// 블럭으로 잡히는 페이징처리 수
	
	/* onload 이벤트  */
	$(function(){
		//  리스트 뿌리기 함수 
		fselectProductList();
		
	});
	
	
	/* 버튼 이벤트 등록 - 저장, 수정, 삭제  */
/* 	function fButtonClickEvent(){
		$('a[name=btn]').click(function(e){
			e.preventDefault();   
					
			var btnId = $(this).attr('id');
			
			switch(btnId){
			case 'btnSavePro' : fSaveProduct(); // save 안에 저장,수정
				//alert("저장버튼 클릭!!!이벤트!!");
				break;
			case 'btnDeletePro' : fDeleteProduct();	// 만들자 
				//alert("삭제버튼 클릭!!!이벤트!!");		
				break;
			case 'btnClose' : gfCloseModal();  // 모달닫기 
			
				break;
			case 'btnUpdatePro' : fUpdateProduct();  // 수정하기
				break;
			case 'searchBtn' : board_search();  // 검색하기
			break;
			
			}
		});
	} */
	
	/* 제품정보 목록 불러오기  */
	function fselectProductList(pagenum){
		
		pagenum = pagenum || 1;   // or		
		
		var param = {
				currentPage : pagenum ,
				pageSize : pageSize 
		}
		
		var resultCallback = function(returndata){  // 데이터를 이 함수로 넘깁시다. 
			productListResult(returndata, pagenum); 
		}
		
		callAjax("/scm/productInfoList.do","post","text", true, param, resultCallback);
		
	}
	

	 /* 제품정보 리스트 data를 콜백함수를 통해 뿌려봅시당   */
	 function productListResult(data, currentPage){
		 
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
	    $("#currentPage").val(currentPage);
	    
		 
	 }
	 
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
	 
	
	 
	 /* 제품정보관리 모달창(팝업) 실행  여기부터 */
 	 function pdModalOpen(model_code) {
		 
		 // 신규저장 하기 버튼 클릭시 (값이 null)
		 if(model_code == null || model_code==""){
			
			$("#action").val("I"); // insert 
			frealPopModal(pro_no); //  초기화 
			
			//모달 팝업 모양 오픈! (빈거) _ 있는 함수 쓰는거임. 
			gfModalPopTop("#pdinfo");
			
		 }else{
			$("#action").val("U");  // update
			fdetailModal(pro_no); //번호로 -> 상품 상세 조회 팝업 띄우기
		 }

	 } 
	 
	 
	 /*1건 상세 조회*/
/* 	 function fdetailModal(pro_no){
		 //alert(" 상세 조회  ");
		 
		 var param = {pro_no : pro_no};
		 var resultCallback2 = function(data){
			 fdetailResult(data);
		 };
		 
		 callAjax("/scm/detailProduct.do", "post", "json", true, param, resultCallback2);
		 //alert(" 상세 조회  22");
		 
	 } */
	 
	 /*  1건 상세 조회 -> 콜백함수   */
/* 	 function fdetailResult(data){

		 //alert("공지사항 상세 조회  33");
		 if(data.resultMsg == "SUCCESS"){
			 //모달 띄우기 
			 gfModalPopTop("#user");
			 
			 //alert(data.result);
			// 모달에 정보 넣기 
			frealPopModal(data.result);
		 
		 }else{
			 alert(data.resultMsg);
		 }
	 } */
	 
	 /* 팝업 _ 초기화 페이지(신규) 혹은 내용뿌리기  */
 	 function frealPopModal(object){
		 
		
		 gfModalPopTop("#pdinfo");
		
			 
		 }
	  
	 
	 
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


<body>

<form id="myProduct" action="" method="">
	
	<input type="hidden" id="currentPage" value="1">  <!-- 현재페이지는 처음에 항상 1로 설정하여 넘김  -->
	<input type="hidden" id="tmpList" value=""> <!-- ★ 이거뭐임??? -->
	<input type="hidden" id="tmpListNum" value=""> <!-- 스크립트에서 값을 설정해서 넘길거임 / 임시 리스트 넘버 -->
	<input type="hidden" name="action" id="action" value=""> 
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
								<a class="btnType blue" href="javascript:pdModalOpen(${null});" name="modal">
								
								<span>신규등록</span></a>
								
							</span>
						</p>
						
					<!--검색창   -->
					<table width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="border-collapse: collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="100" height="25" style="font-size: 120%">&nbsp;&nbsp;</td>
                           <td width="50" height="25" style="font-size: 100%; text-align:right;padding-right:25px;">
     	                       <select id="oname" name="oname" style="width:130px;height:27px">
						        <option value="all">전체</option>
						        <option value="pro_no">제품 번호</option>
						        <option value="pro_nm">제품명</option>
						        <option value="model_nm">모델명</option>
						        <option value="manu_nm">제조사</option>
						      </select>
     	                       <input type="text" style="width: 150px ; height: 25px;" id="sname" name="sname" >                    
	                           <a href="" class="btnType blue" id="searchBtn" name="btn"><span>검  색</span></a>
                           </td> 
                           
                        </tr>
                     </table> &nbsp;&nbsp;
						
						
						<div class="divUserList">
							<table class="col">
								<caption>caption</caption>
	
								<thead>
									<tr>
									      <th scope="col"></th>
							              <th scope="col">모델명</th>
									      <th scope="col">제품 번호</th>							              
							              <th scope="col">제품명</th>
							              <th scope="col">제조사</th>
							              <th scope="col">판매가</th>
							              <th scope="col">납품 업체</th>							              
									</tr>
								</thead>
								<tbody id="productList"></tbody>
							</table>
							
							<!-- 페이징 처리  -->
							<div class="paging_area" id="pagingnavi">
								<div class="paging">
									<a class="first" href="javascript:selectProductList(1)">
									<span class="hidden">맨앞</span></a>
									<a class="pre" href="javascript:selectProductList(1)">
									<span class="hidden">이전</span></a>
									<strong>1</strong> 
									<a href="javascript:selectProductList(2)">2</a> 
									<a href="javascript:selectProductList(3)">3</a> 
									<a href="javascript:selectProductList(4)">4</a>
									<a href="javascript:selectProductList(5)">5</a>
									<a class="next" href="javascript:selectProductList(5)">
									<span class="hidden">다음</span></a>
									<a class="last" href="javascript:selectProductList(5)">
									<span class="hidden">맨뒤</span></a>
								</div>
							</div>
											
						</div>

		
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 제품정보관리 모달 -->
		<div id="pdinfo" class="layerPop layerType2" style="width: 900px; height: auto;">
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
						<tr>
							<th scope="row">제품 번호 <span class="font_red">*</span></th>
							<td colspan="3"><input class = "ui-widget ui-widget-content ui-corner-all" style="height:20px;" type="text" maxlength="15" name="pro_no" id="pro_no" /></td>
													
						</tr>
						<tr>
							<th scope="row">제품 코드 <span class="font_red">*</span></th>
							<td colspan="3">  
							<select name="pro_cd" id="pro_cd" style="width:webkit-fill-available; height:16.25px" data-placeholder="제품 코드를 선택하세요." class="chosen-select">
								<c:forEach var="tempCdlist" items="${cdListObj}">
						         	<option value="${tempCdlist.detail_code}">${tempCdlist.detail_name}</option>
						        </c:forEach>
							</select>
							</td>
						</tr>	
						<tr>
							<th scope="row">저장 창고 <span class="font_red">*</span></th>
							<td colspan="3">  
							<select name="ware_no" id="ware_no" data-placeholder="1개 이상의 창고를 선택하세요." 
							multiple class="chosen-select">
								<c:forEach var="tempCdlist2" items="${whListObj}">
						         	<option value="${tempCdlist2.ware_no}">${tempCdlist2.ware_name}( ${tempCdlist2.ware_dt_address} )</option>
						        </c:forEach>
							</select>
							</td>	
						</tr>					
						<tr>
							<th scope="row">제품명 <span class="font_red">*</span></th>
							<td><input class = "ui-widget ui-widget-content ui-corner-all" style="height:20px;" type="text" maxlength="15" name="pro_name" id="pro_name" ></td>
							
							<th scope="row">모델명 <span class="font_red">*</span></th>
							<td><input class = "ui-widget ui-widget-content ui-corner-all" style="height:20px;" type="text" maxlength="15" name="pro_model_name" id="pro_model_name" /></td>
						</tr>
						<tr>
							<th scope="row">제조사 <span class="font_red">*</span></th>
							<td><input class = "ui-widget ui-widget-content ui-corner-all" style="height:20px;" type="text" maxlength="15" name="pro_manu_name" id="pro_manu_name" /></td>
							
							<th scope="row">제품 가격 <span class="font_red">*</span></th>
							<td><input class = "ui-widget ui-widget-content ui-corner-all" style="height:20px;" type="text" maxlength="10" name="pro_price" id="pro_price" style="ime-mode: disabled;" onKeyDown="filterNumber(this, event);" onChange="filterNum(this);" ></td>							
						</tr>
						<tr>
							<th scope="row">납품 업체 <span class="font_red">*</span></th>
							<td>  
							<select name="deli_no" id="deli_no" style="width:129px; height:16.25px" data-placeholder="납품업체를 선택하세요."class="chosen-select">
								<c:forEach var="tempCdlist3" items="${deliListObj}">
						         	<option value="${tempCdlist3.deli_no}">${tempCdlist3.deli_company}</option>
						        </c:forEach>
							</select>
							</td>
							<th scope="row">납품 단가 <span class="font_red">*</span></th>
							<td><input class = "ui-widget ui-widget-content ui-corner-all" style="height:20px;" type="text" maxlength="10" name="pro_deli_price" id="pro_deli_price" style="ime-mode: disabled;" onKeyDown="filterNumber(this, event);" onChange="filterNum(this);"></td>							
						</tr>
						
						<tr>
							
							<th scope="row">상세 정보 <span class="font_red">*</span></th>
							<td colspan="3">
							<textarea class = "ui-widget ui-widget-content ui-corner-all" id="pro_detail" maxlength="500" name="pro_detail" style="height:130px;outline:none;resize:none;" placeholder="여기에 상세정보를 적어주세요.(500자 이내)"></textarea>
							</td>
								
						</tr>		

						
						<tr>
		                    <th scope="row">대표 이미지 <span class="font_red">*</span></th>
		                    <td class="thumb">
		                        <span> 
								<input name="thumbnail" type="file" id="thumbnail" accept="image/* " required>
		
										<!-- 파일 미리보기 스크립트 영역 -->
								       <script>
								       var file = document.querySelector('#thumbnail');
										
								       file.onchange = function () { 
								           var fileList = file.files ;
								           
								           // 읽기
								           var reader = new FileReader();
								           reader.readAsDataURL(fileList [0]);
								           //로드 한 후
								           reader.onload = function  () {
								               //로컬 이미지를 보여주기
								               
								               //썸네일 이미지 생성
								               var tempImage = new Image(); //drawImage 메서드에 넣기 위해 이미지 객체화
								               tempImage.src = reader.result; //data-uri를 이미지 객체에 주입
								               tempImage.onload = function() {
								                   //리사이즈를 위해 캔버스 객체 생성
								                   var canvas = document.createElement('canvas');
								                   var canvasContext = canvas.getContext("2d");
								                   
								                   //캔버스 크기 설정
								                   canvas.width = 400; //가로 400px
								                   canvas.height = 400; //세로 400px
								                   
								                   
								                   //이미지를 캔버스에 그리기
								                   canvasContext.drawImage(this, 0, 0, 400, 400);
								                   //캔버스에 그린 이미지를 다시 data-uri 형태로 변환
								                   var dataURI = canvas.toDataURL("image/jpeg");
								                   
								                   //썸네일 이미지 보여주기
								                   document.querySelector('#tempImg').src = dataURI;
								               };
								           }; 
								       };
		                            </script>
		                            <!-- 파일 미리보기 스크립트 영역 끝 -->
		                            </span>
								 </td>
								 <td colspan="2" style="text-align:center;">
								 	<img id="tempImg" style="object-fit: cover;max-width:100%" src="/images/admin/comm/no_image.png" alt="제품사진미리보기">
								 </td>
                	</tr>		
						
					</tbody>
					
				</table>
				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnUpdatePro" name="btn" style="display:none"><span>수정</span></a> 
					<a href="" class="btnType blue" id="btnDeletePro" name="btn" ><span>삭제</span></a> 
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
