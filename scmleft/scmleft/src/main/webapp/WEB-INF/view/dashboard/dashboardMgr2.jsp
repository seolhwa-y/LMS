<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea</title>

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
        
		/* onload 이벤트  */
		$(document).ready(function() {
			
			init();
			
			// 공지사항 조회
			fListInf();
			
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
											                         { "vueid" : "checkid2", "vuename" : "두번째 "  }
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
	               
					<div class="content" style="margin-bottom:20px;">
                       
						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">메인</span> <a href="../dashboard/dashboard.do"
								class="btn_set refresh">새로고침</a>
						</p>
                         <div >
						        <p class="conTitle" style="margin-bottom: 1%;">
									<span>VueJS 개요</span> 
									<span class="fr"> 
										 관련 자료 
									</span>
								</p>	
								<div>
                                        <table>
										    <tbody>
										          <tr>
										               <td><b><h6>시작</h6></b></td>
										               <td>
										                       &nbsp&nbsp&nbsp&nbsp&nbsp<a  href="https://brunch.co.kr/@clay1987/138" target="_blank">OverView</a>
										               </td>
										          <tr>
										          <tr>
										               <td><b><h6>VueJS 설치</h6></b></td>
										               <td>
										                       &nbsp&nbsp&nbsp&nbsp&nbsp<a  href="https://code-daniel.tistory.com/80" target="_blank">CDN&NPM</a>
										               </td>
										          <tr>		
										          <tr>
										               <td>VueJS Life Cycle</td>
										               <td>
										                       &nbsp&nbsp&nbsp&nbsp&nbsp<a  href="https://wormwlrm.github.io/2018/12/29/Understanding-Vue-Lifecycle-hooks.html" target="_blank">Life Cycle</a>
										               </td>
										          <tr>		
										          <tr>
										               <td>공식 사이트</td>
										               <td>
										                       &nbsp&nbsp&nbsp&nbsp&nbsp<a  href="https://kr.vuejs.org/" target="_blank">공식 한국 VusJS</a>
										                       &nbsp&nbsp&nbsp&nbsp&nbsp<a  href="https://vuejsexamples.com/" target="_blank">VusJS Example</a>
										                       &nbsp&nbsp&nbsp&nbsp&nbsp<a  href="https://cli.vuejs.org/" target="_blank">VusJS 개발도구 VueCli</a> 
										               </td>
										          <tr>
										          <tr>
										               <td>Vue School </td>
										               <td>
										                       &nbsp&nbsp&nbsp&nbsp&nbsp<a  href="https://v3.ko.vuejs.org/api/instance-properties.html#el" target="_blank"> 인스턴스</a>
										               </td>
										          <tr>
										          https://v3.ko.vuejs.org/api/instance-properties.html#el
										          <tr>
										               <td>VueJS 개인 불로그</td>
										               <td>
										                       &nbsp&nbsp&nbsp&nbsp&nbsp<a  href="https://codelabs-vue.web.app/" target="_blank">개인 불로그</a>
										               </td>
										          <tr>		
										          <tr>
										               <td>자바스크립트</td>
										               <td>
										                       &nbsp&nbsp&nbsp&nbsp&nbsp<a  href="https://joshua1988.github.io/web-development/translation/essential-es6-features-for-vuejs/" target="_blank">EL6</a>
										               </td>
										          <tr>	
										          <tr>
										               <td>테스트 사이트</td>
										               <td>
										                       &nbsp&nbsp&nbsp&nbsp&nbsp<a  href="https://jsfiddle.net/boilerplate/vue" target="_blank">jsfiddle</a>
										               </td>
										          <tr>										    
										          <tr>
										               <td>참조 사이트</td>
										               <td>
										                       &nbsp&nbsp&nbsp&nbsp&nbsp<a  href="https://medium.com/@hozacho/%EB%A7%A8%EB%95%85%EC%97%90-vuejs-8a50055b7551" target="_blank">Hoza Cho</a>&nbsp&nbsp&nbsp&nbsp&nbsp
										                       <a  href="https://vuejsexamples.net/vue-table/" target="_blank">VueJS Table</a>
										               </td>
										          <tr>			
										          <tr>
										               <td colspan=2>
										                      <b>** VueJS Life Cycle 종류 별로 스크립트의 option으로 사용 가능(beforeCreate, Created 등) 	</b>
										               </td>
										          <tr>				    
										    </tbody>
										 
										 
										 </table>
								
								
								</div>
						</div>  						
						<br>
						
                        <div id="vuevar">
						        <p class="conTitle" style="margin-bottom: 1%;">
									<span>1. v-model(VueJS 내부 변수)</span> 
									<span class="fr"> 
										 입력 문자 숫자, Vue 변수 양방향: v-model
									</span>
								</p>
								<div class="fixed-table-body">		
										<table width="100%" class="col" border=0>
		                                    <colgroup>
											    <col width="40%">
												<col width="40%">
												<col width="20%">
											</colgroup>
											<tbody>
											     <tr>
											         <td colspan=3 style="text-align:left" >
											                  1. el 등 기본 문법 설명 <br>
											                  2. data 변수와 v-model로 연결 설정<br>
											                  3. 가상 DOM과 VueJS 구동 원리 ( 랜더링 개념 )<br>
											                  4. 일반 Javascript Function 에서 Vue Data 변수 접근 방법   listvue.item<br>
											                  5. methods 와 일반 Javascript Function 차이<br>
											                  6. 키보드 입력은 v-on:keyup.13와 같이 키보드 입력을 사용
											         </td>
											     </tr>
											     <tr> 
											         <td>
												         문자 : <input type="text" class="inputTxt p100"	name="inputtext" id="inputtext" v-model="inputtext"  @input="inputkey($event)" />
												     </td>
												     <td>
												          {{ inputtext }}
												     </td>
												     <td>
												         <a class="btnType blue" href="javascript:fn_valuedis('inputtext');" name="modal"><span>Javascript 값 확인</span></a>
												     </td>
											     <tr>
											     <tr> 
											         <td>
												         숫자 : <input type="text" class="inputTxt p100"	name="inputnum" id="inputnum" v-model="inputnum"  @input="inputkey($event)" />
											        </td>
											        <td>
												          {{ inputnum }}												          
												     </td>
												     <td>
												         <a class="btnType blue" href="javascript:fn_valuedis('inputnum');" name="modal"><span>Javascript 값 확인</span></a>
												     </td>
											     <tr>		
										     </tbody>						
										</table>
								</div>		
							</div>  
							<br>
                            <div id="vuebind">
						        <p class="conTitle" style="margin-bottom: 1%;">
									<span>2. v-bind,v-on(img src)  </span> 
									<span class="fr"> 
										 JavaScript 함수 와 Method 구분   :id/:name   
									</span>
								</p>	
								<div>
                                     <table width="100%" class="col" border=0>
		                                    <colgroup>
											    <col width="100%">
											</colgroup>
											<tbody>
											     <tr>
											         <td style="text-align:left" >
											                  1. Tag Attribe 와 VueJS 변수 연결(Tag별 속성 종류)<br>
											                  2. Tag Event(v-on)  & @대체  <br>
											         </td>
											     </tr>								
								           </tbody>
								     </table>   
								   
									<input type="file"  id="filesel" name="filesel"  @change="selimg" />									
									<div>
									     <img v-bind:src="imgpath">
									</div>										 
								</div>
							</div>  
							<div id="vuecheck">
							        <p class="conTitle" style="margin-bottom: 1%;">
										<span>3. Checkbox  </span> 
										<span class="fr"> 
											 체크박스 Binding   
										</span>
									</p>	
									<div>
	                                     <table width="100%" class="col" border=0>
			                                    <colgroup>
												    <col width="100%">
												</colgroup>
												<tbody>
												     <tr>
												         <td style="text-align:left" >
												                  1. VueJS 배열 변수 연결<br>
												                  2. Tag Attribe 변수 처리  <br>
												                  3. v-for 배열 변수 처리   <br>
												                  4. v-bind 축약  :
												         </td>
												     </tr>								
									           </tbody>
									     </table> 				
										  <input type="checkbox" id="jack" value="Jack" v-model="checkedNames">
										  <label for="jack">Jack</label>
										  <input type="checkbox" id="john" value="John" v-model="checkedNames">
										  <label for="john">John</label>
										  <input type="checkbox" id="mike" value="Mike" v-model="checkedNames">
										  <label for="mike">Mike</label>
										  <br>
										  <span>체크한 이름: {{ checkedNames }}</span>
									</div>
									<br>
									<div v-for="(item,index) in checklistitem" v-if="checklistitem.length">
										  {{ item.vuename }} <input type="checkbox" :id="item.vueid" :name="item.vueid" :value="item.vuename" v-model="checkedNames">
									</div>
									<div>
									      <br>
										  <span>체크한 이름: {{ checkedNames }}</span>
									</div>
							</div>  
							<br>
                            <div id="vueradio">
							        <p class="conTitle" style="margin-bottom: 1%;">
										<span>4. Radio  </span> 
										<span class="fr"> 
											 Radio Binding   
										</span>
									</p>
                                     <table width="100%" class="col" border=0>
		                                    <colgroup>
											    <col width="100%">
											</colgroup>
											<tbody>
											     <tr>
											         <td style="text-align:left" >
											                  1. VueJS 변수 연결<br>
											                  2. Tag Attribe 변수 처리  <br>
											                  3. v-if, v-else 문법&nbsp&nbsp&nbsp&nbsp&nbsp<a  href="https://beomy.tistory.com/51" target="_blank">v-if, v-else, v-else-if</a>     &nbsp&nbsp&nbsp&nbsp&nbsp<a  href="https://kamang-it.tistory.com/entry/Vue-05%EC%A1%B0%EA%B1%B4%EB%AC%B8" target="_blank">v-if, v-else, v-else-if</a>&nbsp&nbsp&nbsp&nbsp&nbsp<a  href="https://www.python2.net/questions-812626.htm" target="_blank">다중 조건</a> <br>  
											                  4. === 의미&nbsp&nbsp&nbsp&nbsp&nbsp<a  href="https://zinee-world.tistory.com/112" target="_blank">비교연산자</a>           
											         </td>
											     </tr>								
								           </tbody>
								     </table> 	
									<div v-for="(item,index) in radiolistitem" v-if="radiolistitem.length">
										  {{ item.vuename }} <input type="radio" :id="item.vueid" :name="item.vueid" :value="item.vuename" v-model="radioName">
									</div>
									<div>
									      <br>
										  <span>선택한 이름: {{ radioName }}</span>
									</div>
							</div>  							
							<br>
                            <div id="vueprop1">
							        <p class="conTitle" style="margin-bottom: 1%;">
										<span>5. Prop  </span> 
										<span class="fr"> 
											 동적출력    
										</span>
									</p>
                                    <table width="100%" class="col" border=0>
		                                    <colgroup>
											    <col width="100%">
											</colgroup>
											<tbody>
											     <tr>
											         <td style="text-align:left" >
											                  1. Component 개념 : 사용자 정의 태그 사용(my-component)<br>
											                  2. 사용자 정의  Component <br>
											                  3. Prop의특징 및 활용  <br>
											                  4. 컴포넌트 사이트의 컴포넌트 종류&nbsp&nbsp&nbsp&nbsp&nbsp<a  href="https://vuejsexamples.com/" target="_blank">VusJS Example</a>
											         </td>
											     </tr>								
								           </tbody>
								     </table> 										
                                      <my-component></my-component>
							</div>  							
					        <div id = "vueprop2">
					            <my-component-child msg = "파라미터 전송"></my-component-child>
					        </div>
					        <br>
							<div id="vueprop1">
							        <p class="conTitle" style="margin-bottom: 1%;">
										<span>6. Computed  </span> 
										<span class="fr"> 
											 실시간 계산    
										</span>
									</p>
                                    <table width="100%" class="col" border=0>
		                                    <colgroup>
											    <col width="100%">
											</colgroup>
											<tbody>
											     <tr>
											         <td style="text-align:left" >
											                  1. Computed 사용법<br>
											                  2. vuecompute.aPlus  :  get 함수 호출   vuecompute.aPlus = 3 : set 함수 호출  <br>
											                  3. VueJS 변수의 Life Cycle<br>
											                  4. Compute 참조&nbsp&nbsp&nbsp&nbsp&nbsp<a  href="https://kr.vuejs.org/v2/guide/computed.html"  target="_blank">공식 한국 VusJS</a> 
											         </td>
											     </tr>								
								           </tbody>
								     </table> 										
                                      <my-component></my-component>
							</div>  	
							<div>
							       <a class="btnType blue" href="javascript:fn_compute1()" name="modal"><span>vuecompute.aPlus  결과 : 2 =  1 + 1</span></a>
                                   <a class="btnType blue" href="javascript:fn_compute2()" name="modal"><span>vuecompute.aPlus = 3   결과 :  a=2</span></a>
                                   <a class="btnType blue" href="javascript:fn_compute3()" name="modal"><span>vuecompute.a</span></a>
                                   <a class="btnType blue" href="javascript:fn_compute4()" name="modal"><span>vuecompute.aDouble  결과 :  4 = 2 * 2</span></a>
							
							</div>
							<br>
							<div id="watch-example">
							        <p class="conTitle" style="margin-bottom: 1%;">
										<span>7. watch  </span> 
										<span class="fr"> 
											 VueJS 변수 감시  
										</span>
									</p>
                                    <table width="100%" class="col" border=0>
		                                    <colgroup>
											    <col width="100%">
											</colgroup>
											<tbody>
											     <tr>
											         <td style="text-align:left" >
											                  1. Watch 사용 문법 확인<br>
											                  2. 변수 변경 이벤트 발생 후 처리 
											         </td>
											     </tr>								
								           </tbody>
								     </table> 	
									  <p>
									    yes/no 질문을 물어보세요:
									    <input v-model="question">
									  </p>
									  <p>{{ answer }}</p>
							</div>	
							<br>					
							<div id="vueoption">
							        <p class="conTitle" style="margin-bottom: 1%;">
										<span>8. v-for, templete  </span> 
										<span class="fr"> 
											 반복 SelectBox   
										</span>
									</p>
                                    <table width="100%" class="col" border=0>
		                                    <colgroup>
											    <col width="100%">
											</colgroup>
											<tbody>
											     <tr>
											         <td style="text-align:left" >
											                  1. DB Select Jso 결과값을 활용 한 Select 박스 구성 가능<br>
											                  2. templete 범위 안에 templete 사용 불가능
											         </td>
											     </tr>								
								           </tbody>
								     </table> 										
                                    <template v-for="key in selectList">
								    {{key.value}}
								    <select v-model="key.value" >
								        <option value="1">one</option>
								        <option value="2">two</option>
								        <option value="3">three</option>
								    </select>
								  </template>
								  <br>
								  Option Loop
								  <select>								   
								      <template v-for="key in options">
								          <option value="key.value">{{ key.text }}</option>
								      </template>
								  </select>
							</div> 
							<br>
							<p class="conTitle" style="margin-bottom: 1%;">
								<span>9. 공지 사항(v-for,v-if)    </span> 
								<span class="fr"> 
									<a  href="https://vuejsexamples.net/vue-table/" target="_blank">변경된 bootstrap-table</a>
								</span>
							</p>
		                    <table width="100%" class="col" border=0>
                                    <colgroup>
									    <col width="100%">
									</colgroup>
									<tbody>
									     <tr>
									         <td style="text-align:left" >
									                  1. 테이블 컴포넌트 사용 예<br>
									                  2. v-for,v-if 설명 &nbsp&nbsp&nbsp&nbsp&nbsp<a  href="https://vuejsexamples.com/" target="_blank">VusJS Example</a> &nbsp&nbsp&nbsp&nbsp&nbsp<a  href="https://vuejsexamples.com/" target="_blank">VusJS Example</a> <br>
									                  3. Controller 와 연동 설명
									         </td>
									     </tr>								
						           </tbody>
						     </table> 					
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
					        	
                                <br>					
                                <p class="conTitle" style="margin-bottom: 1%;">
									<span>10. NPM Vuejs 개요     </span> 
									<span class="fr"> 
										  NPM
									</span>
							    </p>
			                    <table width="100%" class="col" border=0>
	                                    <colgroup>
										    <col width="100%">
										</colgroup>
										<tbody>
										     <tr>
										         <td style="text-align:left" >
										                  1. NodeJS와 연관성<br>
										                  2.ReactJS 와 관련성 <br>
										                  3. 사전 설정<br>
										                      D:\egov\jdk1.8.0_181 폴더를 D:\로 복사<br>
										                      D:\egov\apache-tomcat-8.0.53 폴더를 D:\로 <br>
										                      JAVA_HOME 설정
										         </td>
										     </tr>								
							           </tbody>
							     </table> 	
							     <br>
                                <p class="conTitle" style="margin-bottom: 1%;">
									<span>11. nodeJs  설치     </span> 
									<span class="fr"> 
										  NodeJS
									</span>
							    </p>
			                    <table width="100%" class="col" border=0>
	                                    <colgroup>
										    <col width="100%">
										</colgroup>
										<tbody>
										     <tr>
										         <td style="text-align:left" >
										                  <a  href="https://ojava.tistory.com/185" target="_blank">참조</a> <br>
										                   node-v14.16.0-x64.exe   실행
										         </td>
										     </tr>								
							           </tbody>
							     </table> 		
							     <br>
                                 <p class="conTitle" style="margin-bottom: 1%;">
									<span>12. nodeJs  설치  (Command)   </span> 
									<span class="fr"> 
										  NodeJS
									</span>
							    </p>
			                    <table width="100%" class="col" border=0>
	                                    <colgroup>
										    <col width="100%">
										</colgroup>
										<tbody>
										     <tr>
										         <td style="text-align:left" >
										                  CMD 창에서  C:\nodejs>npm install   실행
										         </td>
										     </tr>								
							           </tbody>
							     </table> 	
							     <br>
                                 <p class="conTitle" style="margin-bottom: 1%;">
									<span>13. vue 설치  (Command)   </span> 
									<span class="fr"> 
										  VueJS
									</span>
							    </p>
			                    <table width="100%" class="col" border=0>
	                                    <colgroup>
										    <col width="100%">
										</colgroup>
										<tbody>
										     <tr>
										         <td style="text-align:left" >
										                  CMD 창에서  npm install vue   실행<br>
										              설치 확인 : vue -v
										         </td>
										     </tr>								
							           </tbody>
							     </table> 		
							     <br>
                                 <p class="conTitle" style="margin-bottom: 1%;">
									<span>14. Vuejs Cli 설치  (Command)   </span> 
									<span class="fr"> 
										  VueJS
									</span>
							    </p>
			                    <table width="100%" class="col" border=0>
	                                    <colgroup>
										    <col width="100%">
										</colgroup>
										<tbody>
										     <tr>
										         <td style="text-align:left" >
										                  vue/cli 역활<br>
										                  CMD 창에서  npm install -g @vue/cli   실행
										         </td>
										     </tr>								
							           </tbody>
							     </table> 		
							     <br>
                                 <p class="conTitle" style="margin-bottom: 1%;">
									<span>14. 프로젝트 생성  (Command)   </span>
									<span class="fr"> 
									<a  href="https://blog.metafor.kr/201"  target="_blank">2.x 외 3.x의 차이점</a>
								    </span> 
							    </p>
			                    <table width="100%" class="col" border=0>
	                                    <colgroup>
										    <col width="100%">
										</colgroup>
										<tbody>
										     <tr>
										         <td style="text-align:left" >
										                  14.1 workspace 폴더 생성<br>
                                                                  &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp14.2 worksapce 폴더 cmd 에서 프로젝트 생성 (5.2.2 실행)<br>
                                                                  &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp14.2.1 vue init webpack (프로젝트 이름) <br>       
                                                             &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp예) vue init webpack my-app<br>
                                                                  &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp14.2.2 vue create (프로젝트 이름)  <br>
                                                                             &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbspvue create helloworld 
										         </td>
										     </tr>								
							           </tbody>
							     </table> 		
							     <br>
							      <p class="conTitle" style="margin-bottom: 1%;">
									<span>15. Server Run  (Command)   </span>
									<span class="fr"> 
									Server 실행
								    </span> 
							    </p>
			                    <table width="100%" class="col" border=0>
	                                    <colgroup>
										    <col width="100%">
										</colgroup>
										<tbody>
										     <tr>
										         <td style="text-align:left" >
										                 생성 프로젝트 폴더로 이동 후 실행  &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp npm run serve<br>
                                                              <a  href="http://localhost:8080/"  target="_blank">확인</a>
										         </td>
										     </tr>								
							           </tbody>
							     </table> 	
							     <br>
							      <p class="conTitle" style="margin-bottom: 1%;">
									<span>19. Vuejs 관리자  (Command)   </span>
									<span class="fr"> 
									관리자 화면
								    </span> 
							    </p>
			                    <table width="100%" class="col" border=0>
	                                    <colgroup>
										    <col width="100%">
										</colgroup>
										<tbody>
										     <tr>
										         <td style="text-align:left" >
										                 vue ui
										         </td>
										     </tr>								
							           </tbody>
							     </table> 
							     <br>
							      <p class="conTitle" style="margin-bottom: 1%;">
									<span>20. Vsc   설치</span>
									<span class="fr"> 
									Visual Studio Code
								    </span> 
							    </p>
			                    <table width="100%" class="col" border=0>
	                                    <colgroup>
										    <col width="100%">
										</colgroup>
										<tbody>
										     <tr>
										         <td style="text-align:left" >
										                 VSCodeUserSetup-x64-1.61.0.exe 실행
										         </td>
										     </tr>								
							           </tbody>
							     </table> 
							      <br>
							      <p class="conTitle" style="margin-bottom: 1%;">
									<span>21. vsc 환경 설정</span>
									<span class="fr"> 
									Visual Studio Code
								    </span> 
							    </p>
			                    <table width="100%" class="col" border=0>
	                                    <colgroup>
										    <col width="100%">
										</colgroup>
										<tbody>
										     <tr>
										         <td style="text-align:left" >
                                                              <a  href="https://ddolcat.tistory.com/1565"  target="_blank">참조1</a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
										                      <a  href="https://ojava.tistory.com/185"  target="_blank">참조2</a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
										                      <a  href="https://linked2ev.github.io/devsub/2020/08/31/Visual-Studio-Code-vue.js-%EA%B0%9C%EB%B0%9C%EC%8B%9C-%EC%B6%94%EC%B2%9C-plugin-%EC%A0%95%EB%A6%AC/"  target="_blank">참조3</a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
										                      <a  href="https://dev-onestep.tistory.com/25"  target="_blank">참조4</a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<br>
										                      첨부 이미지 참조
										         </td>
										     </tr>								
							           </tbody>
							     </table> 
							     <br>
							      <p class="conTitle" style="margin-bottom: 1%;">
									<span>22. 프로젝트 열기</span>
									<span class="fr"> 
									Visual Studio Code
								    </span> 
							    </p>
			                    <table width="100%" class="col" border=0>
	                                    <colgroup>
										    <col width="100%">
										</colgroup>
										<tbody>
										     <tr>
										         <td style="text-align:left" >
                                                     VSC 메뉴 : 파일-폴더열기   선택후     해당 프로젝트 폴더 열기
										         </td>
										     </tr>								
							           </tbody>
							     </table> 
							     <br>
							      <p class="conTitle" style="margin-bottom: 1%;">
									<span>23. 샘플소스 만들기</span>
									<span class="fr"> 
									Visual Studio Code
								    </span> 
							    </p>
			                    <table width="100%" class="col" border=0>
	                                    <colgroup>
										    <col width="100%">
										</colgroup>
										<tbody>
										     <tr>
										         <td style="text-align:left" >
                                                     샘플소스 만들기
										         </td>
										     </tr>								
							           </tbody>
							     </table> 
							     
							     
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
      
</form>
</body>
</html>