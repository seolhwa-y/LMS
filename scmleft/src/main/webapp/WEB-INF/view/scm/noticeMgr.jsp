<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: SCM</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://unpkg.com/axios@0.12.0/dist/axios.min.js"></script>
<script src="https://unpkg.com/lodash@4.13.1/lodash.min.js"></script>
<!-- D3 -->
<style>
//
click-able rows
	.clickable-rows {tbody tr td { cursor:pointer;
	
}

.el-table__expanded-cell {
	cursor: default;
}
}
</style>
<script type="text/javascript">
        var pageSizeinf  = 3;
        var pageBlockSizeinquiry  = 10;

        var noticeareavar;
        var noticeeditvue;
        var vuevar;
        var vuebind;
        var vuecheck;
        var vueradio;
        var vueprop1;
        var vueprop2;
        var vueoption;
        var vuecompute;
        var watchExampleVM;
        var divComGrpCodList;
        var divComGrpCoddetail;
        
		/* onload 이벤트  */
		$(document).ready(function() {
			
			init();
			
			// 공지사항 조회
			// fListInf();
			
			fListComnGrpCod();
			
			// 버튼 이벤트 등록
			fRegisterButtonClickEvent();
	    });
		
		function init() {
			Vue.component('my-component',{
                template : '<div>전역 컴포넌트</div>'
            });
			
			noticeareavar = new Vue({
				  el: '#divNoticeList',
				  components: {
					                   'bootstrap-table': BootstrapTable
					                },
				  data: {
					  			   listitem:[]
				  }, 
				  methods:{					
					  detailview:function(no){
						  alert(no);
						  fNoticeModal(no);  
					  }
				  }  
				  
				});		
			
			noticeeditvue = new Vue({
				  el: '#notice',
				  data: {
							  loginId:"",
							  noticeTitle:"",
							  noticeContent:"",
							  loginIdread:"",
							  noticeTitleread:"",
							  noticeContentread:""
				  }
				});	
			
			vuevar = new Vue({
				  el: '#vuevar',
				  data: {
					           inputtext:"",
							  inputnum:99
				  }, 
				  methods:{					
					  inputkey:function(event){
						  console.log(event.target.value);
					  }
				  }  
				});	
			
			vuebind = new Vue({
				  el: '#vuebind',
				  data: {
							  imgpath:""
				  }, 
				  methods:{					
					  selimg:function(event){
						  var image = event.target;
						  
						  if(image.files[0]){
							  alert(window.URL.createObjectURL(image.files[0]));
							  vuevar.inputtext="asdfghj";
							  this.imgpath =  window.URL.createObjectURL(image.files[0]);
						  }
					  }
				  }  
				});	
			
			vuecheck = new Vue({
											  el: '#vuecheck',
											  data: {
											    checkedNames: [],
											    checklistitem:[
											                         { "vueid" : "checkid1", "vuename" : "첫번째"  },
											                         { "vueid" : "checkid2", "vuename" : "두번째 "  },
											                         { "vueid" : "checkid3", "vuename" : "세번째 "  }
											                     ]
											  }
				                       });
			
			vueradio = new Vue({
											  el: '#vueradio',
											  data: {
											    radioName: "",
											    radiolistitem:[
											                         { "vueid" : "radioid", "vuename" : "첫번째"  }, 
											                         { "vueid" : "radioid", "vuename" : "두번째 "  }
											                     ]
											  }
							           });
			
			new Vue({
		        el : '#vueprop1',
		    });
			
			vueprop2 = new Vue({
								                el : '#vueprop2',
								                components:{
								                    'my-component-child':{
								                        props:['msg'],
								                        template : '<div>지역 컴포넌트 {{ msg }} </div>'
								                    },
								 
								                }
								            });		
			
			vuecompute = new Vue({
											  data: { a: 1 },
											  computed: {
														    // get only, just need a function
														    aDouble: function () {
														      return this.a * 2
														    },
														    // both get and set
														    aPlus: {
																	      get: function () {
																	        return this.a + 1
																	      },
																	      set: function (v) {
																	        this.a = v - 1
																	      }
														          }
											             }
											});			
			
			
			
			
			vueoption = new Vue({
											  el: "#vueoption",
											  data: {
											    selectList: [
															  {value:"1", text:"one"},
														      {value:"2", text:"two"},
														      {value:"3", text:"three"}
											                ],
							                   options: [
													    	  {value:"option1", text:"항목1"},
													          {value:"option2", text:"항목2"},
													          {value:"option3", text:"항목3"}
										                  ]             
											  },
											  methods: {
											  	toggle: function(todo){
											    	todo.done = !todo.done
											    }
											  }
											});
			


			watchExampleVM = new Vue({
													  el: '#watch-example',
													  data: {
													    question: '',
													    answer: '질문을 하기 전까지는 대답할 수 없습니다.'
													  },
													  watch: {
													    // 질문이 변경될 때 마다 이 기능이 실행됩니다.
													    question: function (newQuestion) {
													      this.answer = '입력을 기다리는 중...';
													      this.debouncedGetAnswer();
													    }
													  },
													  created: function () {
													    // _.debounce는 lodash가 제공하는 기능으로
													    // 특히 시간이 많이 소요되는 작업을 실행할 수 있는 빈도를 제한합니다.
													    // 이 경우, 우리는 yesno.wtf/api 에 액세스 하는 빈도를 제한하고,
													    // 사용자가 ajax요청을 하기 전에 타이핑을 완전히 마칠 때까지 기다리길 바랍니다.
													    // _.debounce 함수(또는 이와 유사한 _.throttle)에 대한
													    // 자세한 내용을 보려면 https://lodash.com/docs#debounce 를 방문하세요.
													    this.debouncedGetAnswer = _.debounce(this.getAnswer, 500)
													  },
													  methods: {
													    getAnswer: function () {
													      if (this.question.indexOf('?') === -1) {
													        this.answer = '질문에는 일반적으로 물음표가 포함 됩니다. ;-)'
													        return
													      }
													      this.answer = '생각중...'
													      var vm = this
													      axios.get('https://yesno.wtf/api')
													        .then(function (response) {
													          vm.answer = _.capitalize(response.data.answer)
													        })
													        .catch(function (error) {
													          vm.answer = '에러! API 요청에 오류가 있습니다. ' + error
													        })
													    }
													  }
													});
													
			divComGrpCodList = new Vue({
				                                         el : "#divComGrpCodList",
				                                     data : {
				                                    	          grouplist : [],
				                                    	          pagenavi : ""
				                                     },
				                                     methods : {
				                                    	 grpdetail : function(grpcod) {
				                                               //alert(grpcod);
				                                               fSelectGrpCod(grpcod);
				                                               
				                                    	 } ,
				                                     }
			});
			
			divComGrpCoddetail = new Vue({
	                   el : "#layer2",
	               data : {
	                            grp_cod : "",
	                                   grp_cod_nm : "",
	                                   grp_cod_eplti : "",
	                                   mp_fld_01 : "",
	                                   mp_fld_02 : "",
	                                   mp_fld_03 : "",
	                                   use_poa : "",
	                                   fst_enlm_dtt : "",
	                                   reg_date : "",
	                                   fst_rgst_sst_id : "",
	                                   fnl_mdfd_dtt : "",
	                                   fnl_mdfr_sst_id : "",
	                                   detailcnt : 0,
	                                   delshow : false,
           	            }    
            });										
			
			
		}	
		
		function selimg() {
			alert("JavaScript Function");			
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
					case 'btnCloseGrpCod' :
						gfCloseModal();
						break;					
					case 'btnSaveGrpCod' :
						fSaveGrpCod();
						break;							
						
			}
		});
	}
				  
				
	/** 공지사항 조회 */
	function fListInf(currentPage) {
		
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

		//console.log(data);		
		noticeareavar.listitem = data.notice;
		
		// 총 개수 추출
		var totalCntlistInf = data.noticeCnt;
		var list = $("#selectedInfNo").val();
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCntlistInf, pageSizeinf, pageBlockSizeinquiry, 'fListInf',[list]);
		//console.log("paginationHtml : " + paginationHtml);
	
		$("#listInfPagination").empty().append( paginationHtml );
	 
	}
		
	 /*공지사항 상세 조회*/
	 function fNoticeModal(noticeNo) {
	
		 var param = {noticeNo : noticeNo};
		 var resultCallback2 = function(data){
			 fdetailResult(data);
		 };
		 
		 callAjax("/system/detailNotice.do", "post", "json", true, param, resultCallback2);
	 }
	
	 /*  공지사항 상세 조회 -> 콜백함수   */
	 function fdetailResult(data){

		 if(data.resultMsg == "SUCCESS"){
			 //모달 띄우기 
			 gfModalPop("#notice");
			 
			// 모달에 정보 넣기 
			frealPopModal(data.result);
		 
		 }else{
			 alert(data.resultMsg);
		 }
	 }
	
	 /* 팝업 _ 초기화 페이지(신규) 혹은 내용뿌리기  */
	 function frealPopModal(object){
		 
		 noticeeditvue.loginId = object.loginId;
		 noticeeditvue.noticeTitle = object.noticeTitle;
		 noticeeditvue.noticeContent = object.noticeContent;
		 
		 noticeeditvue.loginIdread = "readonly";
		 noticeeditvue.noticeTitleread = "readonly";
		 noticeeditvue.noticeContentread = "readonly";
		 
		 $("#noticeNo").val(object.noticeNo); // 중요한 num 값도 숨겨서 받아온다. 
		 
	 }

	 function fn_valuedis(parm) {
		 // alert(parm);
		 if(parm == 'inputnum') {
			 alert("inputnum : " + vuevar.inputnum);
		 } else {
			 alert("inputtext : " + vuevar.inputtext);
		 }
	 }
	 
	 function fn_compute1() {
		 alert("vuecompute.a : " + vuecompute.a + " vuecompute.aPlus : " + vuecompute.aPlus);
	 }
	 
	 function fn_compute2() {
		 vuecompute.aPlus = 3
		 alert("vuecompute.a : " + vuecompute.a);
	 }
	 
	 function fn_compute3() {
		 alert("vuecompute.a : " + vuecompute.a);
	 }
	 
	 function fn_compute4() {
		 alert("vuecompute.a" + vuecompute.a + " vuecompute.aDouble : " + vuecompute.aDouble);
	 }	 
	 
	 function fn_changesel() {
		 vueoption.options = vueoption.selectList;
	 }	 
	 
	 function inputkey(event) {
		 alert("inputkey");
	 }
	
		/** 그룹코드 조회 */
		function fListComnGrpCod(currentPage) {
			
			currentPage = currentPage || 1;
			
			var sname = "";
			var oname = "";
			
			console.log("currentPage : " + currentPage);
			
			var param = {	
						sname : sname
					,	oname : oname
					,	currentPage : currentPage
					,	pageSize : pageSizeinf
			}
			
			var resultCallback = function(data) {
				flistGrpCodResult(data, currentPage);
			};
			//Ajax실행 방식
			//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
			callAjax("/system/vueListComnGrpCod.do", "post", "json", true, param, resultCallback);
		}
		
		
		/** 그룹코드 조회 콜백 함수 */
		function flistGrpCodResult(data, currentPage) {
			
			console.log(JSON.stringify(data));
			
			divComGrpCodList.grouplist = data.listComnGrpCodModel;
			
			var totalCntComnGrpCod = data.totalCntComnGrpCod;
			
			// 총 개수 추출
			
			//var totalCntComnGrpCod = $("#totalCntComnGrpCod").val();
			
			
			//swal(totalCntComnGrpCod);
			
			// 페이지 네비게이션 생성
			
			var paginationHtml = getPaginationHtml(currentPage, totalCntComnGrpCod, pageSizeinf, pageBlockSizeinquiry, 'fListComnGrpCod');
			console.log("paginationHtml : " + paginationHtml);
			
			divComGrpCodList.pagenavi = paginationHtml;
			//swal(paginationHtml);
			//$("#comnGrpCodPagination").empty().append( paginationHtml );
			
			// 현재 페이지 설정
			//$("#currentPageComnGrpCod").val(currentPage);
		}


		/** 그룹코드 단건 조회 */
		function fSelectGrpCod(grp_cod) {
			
			var param = { grp_cod : grp_cod };
			
			var resultCallback = function(data) {
				fSelectGrpCodResult(data);
			};
			
			callAjax("/system/selectComnGrpCod.do", "post", "json", true, param, resultCallback);
		}
		
		
		/** 그룹코드 단건 조회 콜백 함수*/
		function fSelectGrpCodResult(data) {
			console.log(JSON.stringify(data));
			 
			if (data.result == "SUCCESS") {

				// 모달 팝업
				gfModalPop("#layer2");
				
				// 그룹코드 폼 데이터 설정
				fInitFormGrpCod(data.comnGrpCodModel);
				
			} else {
				swal(data.resultMsg);
			}	
		}
		
		function fInitFormGrpCod(object) {
			console.log(JSON.stringify(object));
			console.log(JSON.stringify(object.grp_cod));
			
			divComGrpCoddetail.grp_cod = object.grp_cod;
			divComGrpCoddetail.grp_cod_nm = object.grp_cod_nm;
			divComGrpCoddetail.grp_cod_eplti = object.grp_cod_eplti;
			divComGrpCoddetail.mp_fld_01 = object.mp_fld_01;
			divComGrpCoddetail.mp_fld_02 = object.mp_fld_02;
			divComGrpCoddetail.mp_fld_03 = object.mp_fld_03;
			divComGrpCoddetail.use_poa = object.use_poa;
			divComGrpCoddetail.fst_enlm_dtt = object.fst_enlm_dtt;
			divComGrpCoddetail.reg_date = object.reg_date;
			divComGrpCoddetail.fst_rgst_sst_id = object.fst_rgst_sst_id;
			divComGrpCoddetail.fnl_mdfd_dtt = object.fnl_mdfd_dtt;
			divComGrpCoddetail.fnl_mdfr_sst_id = object.fnl_mdfr_sst_id;
			divComGrpCoddetail.detailcnt = object.detailcnt;
			
			if(divComGrpCoddetail.detailcnt == 0) {
				console.log("0000000000000");
				divComGrpCoddetail.delshow = false;
			} else {
				console.log("over");
				divComGrpCoddetail.delshow = true;
			}
			
			
		}
				
		function fSaveGrpCod() {
			
			var param = {
					grp_cod : divComGrpCoddetail.grp_cod,
					grp_cod_nm : divComGrpCoddetail.grp_cod_nm,
					grp_cod_eplti : divComGrpCoddetail.grp_cod_eplti,
					mp_fld_01 : divComGrpCoddetail.mp_fld_01,
					mp_fld_02 : divComGrpCoddetail.mp_fld_02,
					mp_fld_03 : divComGrpCoddetail.mp_fld_03,
					use_poa : divComGrpCoddetail.use_poa,
					fst_enlm_dtt : divComGrpCoddetail.fst_enlm_dtt,
					reg_date : divComGrpCoddetail.reg_date,
					fst_rgst_sst_id : divComGrpCoddetail.fst_rgst_sst_id,
					fnl_mdfd_dtt : divComGrpCoddetail.fnl_mdfd_dtt,
					fnl_mdfr_sst_id : divComGrpCoddetail.fnl_mdfr_sst_id,
					detailcnt : divComGrpCoddetail.detailcnt,
					action : "U"
			}

			
			
			var resultCallback = function(data) {
				fSaveGrpCodResult(data);
			};
			
			callAjax("/system/saveComnGrpCod.do", "post", "json", true, param, resultCallback);
		}
		
		
		/** 그룹코드 저장 콜백 함수 */
		function fSaveGrpCodResult(data) {
			
			// 목록 조회 페이지 번호
			var currentPage = "1";
			if ($("#action").val() != "I") {
				currentPage = $("#currentPageComnGrpCod").val();
			}
			
			if (data.result == "SUCCESS") {
				
				// 응답 메시지 출력
				swal(data.resultMsg);
				
				// 모달 닫기
				gfCloseModal();
				
				// 목록 조회
				fListComnGrpCod(currentPage);
				
			} else {
				// 오류 응답 메시지 출력
				swal(data.resultMsg);
			}
			
			// 입력폼 초기화
			//fInitFormGrpCod();
		}
		
</script>

</head>
<body>
<form id="myForm" action=""  method="">

<input type="hidden" id="currentPage" value="1">
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

						<div class="content" style="margin-bottom: 20px;">

							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
								<span class="btn_nav bold">메인</span> <a
									href="../dashboard/dashboard.do" class="btn_set refresh">새로고침</a>
							</p>
							<div>
								<p class="conTitle" style="margin-bottom: 1%;">
									<span>TITLE</span> <span class="fr"> 관련 자료 </span>
								</p>

							</div>
							<br>
						</div>
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
							        <input type="text" class="inputTxt p100"	name="noticeTitle" id="noticeTitle" v-model="noticeTitle" v-bind:readonly="noticeTitleread" />
							 </td>
						</tr>
						<tr>
							<th scope="row">내용</th>
							<td colspan="3">
								<textarea class="inputTxt p100" name="noticeContent" id="noticeContent" v-model="noticeContent" v-bind:readonly="noticeContentread">
								</textarea>
							</td>
						</tr>
						
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>닫기</span></a>
				</div>
			</dd>

		</dl>
	</div>


	<div id="layer2" class="layerPop layerType2" style="width: 600px;">
	    <input type="hidden" id="action" name="action" value="U"> 
		<dl>
			<dt>
				<strong>그룹코드 관리</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
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
							<th scope="row">그룹 코드 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="grp_cod" id="grp_cod"  v-model="grp_cod" /></td>
							<th scope="row">그룹 코드 명 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="grp_cod_nm" id="grp_cod_nm" v-model="grp_cod_nm" /></td>
						</tr>
						<tr>
							<th scope="row">코드 설명 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="grp_cod_eplti" id="grp_cod_eplti" v-model="grp_cod_eplti"  /></td>
						</tr>
				
						<tr>
							<th scope="row">사용 유무 <span class="font_red">*</span></th>
							<td colspan="3"><input type="radio" id="radio1-1"
								name="grp_use_poa" id="grp_use_poa_1" value='Y'  v-model="use_poa" /> <label for="radio1-1">사용</label>
								&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" id="radio1-2"
								name="grp_use_poa" id="grp_use_poa_2" value="N" v-model="use_poa" /> <label for="radio1-2">미사용</label></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveGrpCod" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDeleteGrpCod" name="btn" v-show="delshow" ><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnCloseGrpCod" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>  
      
</form>
</body>
</html>