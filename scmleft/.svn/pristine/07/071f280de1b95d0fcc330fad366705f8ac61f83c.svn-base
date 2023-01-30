<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<!-- abc -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>반품 승인 </title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">

    //페이지 관리 
    
    var pagesize = 5;
    var pagenumsize = 5;
    
    var refundarea;

    
	/** OnLoad event */ 
		$(function() {
			
			init();

			refundConfirm();
			
		fRegisterButtonClickEvent();
	});
	
		function init() {
			refundarea = new Vue({
				el : '#refundConfirm',
				data : {
					refundConfirmList : [],
					re_TYPE : "",
				},
				methods : {
					sclick : function(re_TYPE) {
						this.re_TYPE = "1";
						Sclick(re_TYPE );
					},
					cancle : function(re_TYPE) {
						this.re_TYPE = "2";
						Sclick(re_TYPE);
					}
				}
			});
		}

	
		/** 버튼 이벤트 등록 */
		function fRegisterButtonClickEvent() {
			$('a[name=btn]').click(function(e) {
				e.preventDefault();

				var btnId = $(this).attr('id');
				
				switch (btnId) {
					case 'btnSearch' : 
						refundConfirm();  //누르면 jquery실행하라는 의미 
						break;
					case 'Sbtn' : 
						refundConfirm();  //누르면 jquery실행하라는 의미 
						break;
					case 'Bbtn' : 
						refundConfirm();  //누르면 jquery실행하라는 의미 
						break;
				}
			});
		}
		
		function refundConfirm(clickpagenum ) {
			
			clickpagenum = clickpagenum || 1;
			
			
			var param = {
					searchvalue : $("#searchvalue").val(),
					sdate :  $('#sdate').val().replaceAll('-', ''),
					edate :  $('#edate').val().replaceAll('-', ''),
					clickpagenum : clickpagenum,
					pagesize : pagesize,

			};
			
			var firstsearchcallback = function(returndata) {
				
				console.log("returndata : " + JSON.stringify(returndata));
				
				firstsearchcallbackprocess(returndata,clickpagenum);
				
			}
			
			callAjax("/cmp/refundConfirmMgt.do", "post", "json", true, param, firstsearchcallback);			
		}
		
		function firstsearchcallbackprocess(returndata,clickpagenum) {

			refundarea.refundConfirmList = returndata.refundConfirmlist;
			
			console.log(refundarea.refundConfirmList);
			
			
			var totalcnt = returndata.refundConfirmMgtcnt;
			var list = $("#refundConfirmMgtcnt").val();
			
			var paginationHtml = getPaginationHtml(clickpagenum, totalcnt, pagesize, pagenumsize, 'refundConfirm', [ list ]);
			
			console.log("paginationHtml : " + paginationHtml);
			
			$("#refundConfirmMgtPagination").empty().append( paginationHtml );
			
			$("#hclickpagenum").val(clickpagenum);
		}	
		 	
		function Sclick(re_code) { //반품시 넘겨줘야할 코드가 반품코드,지시서코드  생각했지만 주문코드 발주코드도 들어가 줘야 하는가? 
			
			
			// console.log("DIR_CODE 22222222222222222222:  " + re_code   + $("RE_CODE").val());

			var param = { 
					re_TYPE : refundarea.re_TYPE,
 					re_code : re_code
			}
			
 			var Sclickcallback = function(returndata) {
				
				console.log(returndata);
				
				if ( refundarea.re_TYPE  == 1 ){
					
					alert("승인 완료")
					return false;
			    } else if( refundarea.re_TYPE == 2 ){
						
				    alert("승인 반려 ")  
				    return false;  
			    }
				
				refundConfirm();
			} 
			
			 callAjax("/cmp/SclickRefundConfirm.do", "post", "json", true, param, Sclickcallback);
	    }						

		
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="hclickpagenum" name="hclickpagenum"  value="" />
	<input type="hidden" id="action" name="action"  value="" />
	<input type="hidden" id="DIR_CODE" name="DIR_CODE"  value="" />
	<input type="hidden" id="loginID" name="loginID" value =""/>
	<input type="hidden" id="RE_TYPE" name="RE_TYPE" value =""/>
	<input type="hidden" id="RE_CODE" name="RE_CODE" value =""/>
	<input type="hidden" id="JORD_CODE" name="JORD_CODE" value =""/>
	<input type="hidden" id="RE_CODE" name="RE_CODE" value =""/>	
	
	
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
								class="btn_nav bold">승인</span> <span class="btn_nav bold">반품 승인</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>반품 승인</span> <span class="fr"> 
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
							    <a  class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
						 </span>  	                       	                            
		                        
	                           </td> 	                           
	                        </tr>	
                        </table> 
                        
                   	<div id="refundConfirm">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">반품고객</th>
										<th scope="col">제품명</th>
										<th scope="col">구매일자</th>
										<th scope="col">반품일자</th>
										<th scope="col">수량</th>
										<th scope="col">금액</th>
										<th scope="col">반품 승인</th>
									</tr>
								</thead>
								<tbody>
								<tr v-for="(item, index) in refundConfirmList" v-if="refundConfirmList.length != 0">
									<td>{{ item.name }}</td>
									<td>{{ item.pd_NAME }}</td>
									<td>{{ item.jord_DATE }}</td>
									<td>{{ item.re_DATE }}</td>
									<td>{{ item.re_AMT }}</td>
									<td>{{ item.re_PRICE }}</td>
									<td v-if='item.re_TYPE == "0"'>
									<a @click="sclick(item.re_CODE)"
												class="btnType blue" id="btnSclick" name="btn" ><span>승인</span></a>
									<a @click="cancle(item.re_CODE)"
												class="btnType blue" id="btnSclick" name="btn" ><span>반려</span></a>
									</td>
									<td v-else-if='item.re_TYPE == "1"'> 승인 </td>
									<td v-else-if='item.re_TYPE == "2"'> 반려 </td>
									<td v-else></td>
								</tr>
								</tbody>
							</table>
							<div class="paging_area"  id="refundConfirmMgtPagination"> </div>
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
