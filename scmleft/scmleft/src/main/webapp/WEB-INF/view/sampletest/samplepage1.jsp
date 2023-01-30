<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>SamplePage1</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
                              
<script type="text/javascript">
    
    var vuelist;
    var noticepop;
    var pageSizeinf = 5;
    var pageBlockSizeinquiry = 5;
    
    $(document).ready(function() {
    	
    	init();
    	
    	//listitem();
    	
    	fRegisterButtonClickEvent();
	});

    function init() {
    	
    	vuelist  = new Vue({
			  el: '#divNoticeList',
			  components: {
				                   'bootstrap-table': BootstrapTable
				                },
			  data: {
				  			   listitem:[{"row_num":0,"noticeNo":5,"loginId":"admin","noticeTitle":"1234","noticeContent":null,"noticeRegdate":"2021-10-17","from_date":null,"to_date":null},
				  			           {"row_num":0,"noticeNo":4,"loginId":"admin","noticeTitle":"zinkki","noticeContent":null,"noticeRegdate":"2021-06-22","from_date":null,"to_date":null}
				  			 ,{"row_num":0,"noticeNo":3,"loginId":"admin","noticeTitle":"콤보박스 업데이트","noticeContent":null,"noticeRegdate":"2021-06-22","from_date":null,"to_date":null}
				  			 ,{"row_num":0,"noticeNo":2,"loginId":"admin","noticeTitle":"반갑습니다","noticeContent":null,"noticeRegdate":"2021-06-22","from_date":null,"to_date":null}
				  			 ,{"row_num":0,"noticeNo":1,"loginId":"admin","noticeTitle":"안녕하세요","noticeContent":null,"noticeRegdate":"2021-02-26","from_date":null,"to_date":null}]
			  }, 
			  methods:{					
				  detailview:function(no){
					  alert(no);
					  fNoticeModal(no);  
				  }
			  }  
			  
			});		
    	
    	noticepop = new Vue({
			  el: '#notice',
			  data: {
			    	      loginId : "",
			    	      noticeTitle : "",
			    	      noticeContent : "",
			    	      loginIdread : "",
			    	      noticeTitleread : "",
			    	      noticeContentread : "",
			    	      noticeNo : "",
			    	      action : ""
			  }, 
			  methods:{					
				  closepop:function(){
					  alert("close");
					  gfCloseModal();
				  }
			  }  
			  
			});	    
    	

    	
    	
    }
    
	function listitem(currentPage) {
		
		currentPage = currentPage || 1;
		
		//console.log("currentPage : " + currentPage);
						    
		var param = {
					currentPage : currentPage
				,	pageSize : pageSizeinf
		}
		
		var resultCallback = function(data) {
			fListInfResult(data, currentPage);
		};
		
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		//html로 받을거라 text
		callAjax("/inf/listinfvue.do", "post", "json", true, param, resultCallback);
	}
	
	
	/** 공지사항 조회 콜백 함수 */
	function fListInfResult(data, currentPage) {

		console.log(JSON.stringify(data));		
		vuelist.listitem = data.notice;
		
		// 총 개수 추출
		var totalCntlistInf = data.noticeCnt;
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCntlistInf, pageSizeinf, pageBlockSizeinquiry, 'fListInf');
		//console.log("paginationHtml : " + paginationHtml);
	
		$("#listInfPagination").empty().append( paginationHtml );
	 
	}
	
	function fNoticeModal(no) {
		
		
		var param = {
				noticeNo : no
	      }
	
		var resultCallback = function(data) {
			fselectInfResult(data);
		};
		
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		//html로 받을거라 text
		callAjax("/system/detailNotice.do", "post", "json", true, param, resultCallback);
		
	}
	
	function fselectInfResult(data) {
		console.log(JSON.stringify(data));		
		
		noticepop.loginId = data.result.loginId;
		noticepop.noticeTitle = data.result.noticeTitle;
		noticepop.noticeContent = data.result.noticeContent;
		noticepop.noticeNo = data.result.noticeNo;
		noticepop.action = "U";
		
		//loginIdread
		//noticeTitleread
		//noticeContentread

		gfModalPop("#notice");
	}
	
	function fn_save() {

		var param = {
				noticeNo : noticepop.noticeNo,
				noticeTitle : noticepop.noticeTitle,
				noticeContent : noticepop.noticeContent,
				action : noticepop.action
	      }
	
		var resultCallback = function(data) {
			fupdateInfResult(data);
		};
		
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		//html로 받을거라 text
		callAjax("/system/noticeSave.do", "post", "json", true, param, resultCallback);

	}
	
	function fupdateInfResult (data) {
		console.log(JSON.stringify(data));		
	}
	

	function fn_isave() {

		var param = {
				noticeNo : noticepop.noticeNo,
				noticeTitle : noticepop.noticeTitle,
				noticeContent : noticepop.noticeContent,
				action : noticepop.action
	      }
	
		var resultCallback = function(data) {
			fupdateInfResult(data);
		};
		
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		//html로 받을거라 text
		callAjax("/system/noticeSave.do", "post", "json", true, param, resultCallback);

	}
	
	
	function fn_newpopup() {
		noticepop.noticeNo = "";
		noticepop.noticeTitle = "";
		noticepop.noticeContent = "";
		noticepop.action = "I";
		
		gfModalPop("#notice");		
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
				case 'btnUpdate' :
					fn_save();
					break;
				case 'btnInsert' :
					fn_isave();
					break;	
		}
	});
  }
</script>

</head>
<body>
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
								class="btn_nav bold">Sample</span> <span class="btn_nav bold">SampleTest1
								</span> <a href="/sampletest/samplepage1.do" class="btn_set refresh">새로고침</a>
						</p>

                        <br>   
                        <span class="fr"> <a 	class="btnType blue" href="javascript:fn_newpopup();" name="modal"><span>신규등록</span></a>
                        <div id="divNoticeList">
								<div class="bootstrap-table">
									<div class="fixed-table-toolbar">
										<div class="bs-bars pull-left"></div>
										<div class="columns columns-right btn-group pull-right">	</div>
									</div>
									<div class="fixed-table-container" style="padding-bottom: 0px;">
										<div class="fixed-table-body">		
												<table class="col">
													<caption>caption</caption>
													<colgroup>
													   <col width="5%">
														<col width="70%">
														<col width="10%">
														<col width="5%">
													</colgroup>
								
													<thead>
														<tr>
														    <th scope="col">번호</th>
															<th scope="col">제목</th>
															<th scope="col">작성일</th>
															<th scope="col">작성자</th>
														</tr>
													</thead>
													<tbody id="listInf" v-for="(item,index) in listitem" v-if="listitem.length">
													      <tr @click="detailview(item.noticeNo)">
														    <td>{{ item.noticeNo }}</td>
															<td>{{ item.noticeTitle }}</td>
															<td>{{ item.noticeRegdate }}</td>
															<td>{{ item.loginId }}</td>									
													      </tr>
													</tbody>
												</table>
										</div>
	                                    <div>
												<div>
													<div class="clearfix" />
												</div>
										</div>
									 </div>		
								   </div>
								</div>			   

					        	<div class="paging_area"  id="listInfPagination"> </div>
                    
                    
                    

					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
					<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 모달팝업 -->
	<div id="notice" class="layerPop layerType2" style="width: 600px;">
		<input type="hidden" id="noticeNo" name="noticeNo" value="${noticeNo}"> <!-- 수정시 필요한 num 값을 넘김  -->
		
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
							<th scope="row">작성자 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="loginId" id="loginId" v-model="loginId" v-bind:readonly="loginIdread" /></td>
							<!-- <th scope="row">작성일<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="write_date" id="write_date" /></td> -->
						</tr>
						<tr>
							<th scope="row">제목 <span class="font_red">*</span></th>
							<td colspan="3">
							        <input type="text" class="inputTxt p100"	name="noticeTitle" id="noticeTitle" v-model="noticeTitle"  />
							 </td>
						</tr>
						<tr>
							<th scope="row">내용</th>
							<td colspan="3">
								<textarea class="inputTxt p100" name="noticeContent" id="noticeContent" v-model="noticeContent" >
								</textarea>
							</td>
						</tr>
						
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
				    <a href=""	class="btnType gray"  id="btnInsert" name="btn"><span>등록</span></a>
				    <a href=""	class="btnType gray"  id="btnUpdate" name="btn"><span>수정</span></a>
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>닫기</span></a>
				</div>
			</dd>

		</dl>
	</div>
      	
	
	
</body>
</html>