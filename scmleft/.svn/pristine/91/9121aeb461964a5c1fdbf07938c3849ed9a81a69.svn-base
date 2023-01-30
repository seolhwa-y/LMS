<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<!-- abc -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>구매승인 </title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">


    //페이지 관리 
    
    var pagesize = 5;
    var pagenumsize = 5;

    
	/** OnLoad event */ 
		$(function() {
		
		// 게시판 조회
		orderConfirm();
		
		fRegisterButtonClickEvent();
		
		
	});
	
		/** 버튼 이벤트 등록 */
		function fRegisterButtonClickEvent() {
			$('a[name=btn]').click(function(e) {
				e.preventDefault();

				var btnId = $(this).attr('id');
				
				switch (btnId) {
					case 'btnSearch' : 
						orderConfirm();  //누르면 jquery실행하라는 의미 
						break;
					case 'btnsuccess' : 
						alert("승인 되었습니다.");  //누르면 jquery실행하라는 의미 
						break;
				}
			});
		}
	
		function orderConfirm(clickpagenum) {
			
			clickpagenum = clickpagenum || 1;
			
			var DIR_CODE = $("#DIR_CODE").val();
			
			var sdate = $("#sdate").val();
			var edate = $("#edate").val();
			
			var param = {
					
					searchtype : $("#searchtype").val(),
					searchvalue : $("#searchvalue").val(),
					sdate : sdate,
					edate : edate,
					clickpagenum : clickpagenum,
					pagesize : pagesize,
					DIR_CODE : DIR_CODE
			};
			
			var firstsearchcallback = function(returndata) {
				
				console.log("returndata : " + returndata);
				
				firstsearchcallbackprocess(returndata,clickpagenum);				
			}			
			callAjax("/cmp/orderConfirmMgt.do", "post", "text", true, param, firstsearchcallback);			
		}
		
		function Sclick() {
			$("#DIR_CODE").val(DIR_CODE);
			console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@22" + DIR_CODE);
			alert("승인 되었습니다.");
		}
		
		function firstsearchcallbackprocess(returndata,clickpagenum) {

			$("#orderConfirmMgt").empty().append(returndata);
			
			console.log("wqwqwqwqwqw 2222: " + orderConfirmMgt);
			
			console.log("DIR_CODE : " + DIR_CODE);
			
			var totalcnt = $("#orderConfirmMgtcnt").val();
			
			var paginationHtml = getPaginationHtml(clickpagenum, totalcnt, pagesize, pagenumsize, 'orderConfirm');
			
			console.log("paginationHtml : " + paginationHtml);
			
			$("#orderConfirmMgtPagination").empty().append( paginationHtml );
			
			$("#hclickpagenum").val(clickpagenum);
		}	
		

</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="hclickpagenum" name="hclickpagenum"  value="" />
	<input type="hidden" id="action" name="action"  value="" />
	<input type="hidden" id="loginID" name="loginID" value =""/>
	<input type="hidden" id="DIR_CODE" name="DIR_CODE" value =""/>
		
	<!-- 모달 배경 -->
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
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">승인</span> <span class="btn_nav bold">구매 승인</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>구매 승인</span> <span class="fr"> 
							</span>
						</p>
						<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"  align="left"   style="collapse; border: 1px #50bcdf;">
	                        <tr style="border: 0px; border-color: blue">
	                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">

									
		     	         <span> 제품명 </span>   
		     	         
		     	         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		     	         
		     	         <input type="text" style="width: 300px; height: 25px;" id="searchvalue" name="searchvalue">
	     	             <span align="left" >
		                 
						 <span class="fr"> 	  
						  		<input type="date" id="sdate"> ~ <input type = "date" id ="edate">
						  		&nbsp;&nbsp;&nbsp;&nbsp;
							    <a  class="btnType blue" id="btnsearch" name="btn"><span>검  색</span></a></span>
						 </span>  	                       	                            
		                        
	                           </td> 	                           
	                        </tr>	
                        </table> 
                        
                   	<div class="divfileuploadList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
																		
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">발주업체명</th>
										<th scope="col">제품명</th>
										<th scope="col">수량</th>
										<th scope="col">금액</th>
										<th scope="col">구매일자</th>
										<th scope="col">구매 승인</th>
									</tr>
								</thead>
								
								<tbody id="orderConfirmMgt"></tbody> 
							</table>
							<div class="paging_area"  id="orderConfirmMgtPagination"> </div>
						</div>
						                      
					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
			
		</div>	
	</div>
</form>
</body>
</html>
