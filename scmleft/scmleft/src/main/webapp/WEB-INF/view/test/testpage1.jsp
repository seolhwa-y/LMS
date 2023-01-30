<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>TestPage1</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

                              
<script type="text/javascript">
    
    var searcharea;
    
    $(document).ready(function() {
    	init();
	});
 
    function init() {
    	Vue.component('datepicker', {
    		  template: '<input/>',
    		  mounted: function() {
    		    var self = this;
    		    $(this.$el).datepicker({
    		      dateFormat: "yy-mm-dd"
    		      ,monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
    		      ,monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
    		      ,dayNames: ['일', '월', '화', '수', '목', '금', '토']
    		      ,dayNamesShort: ['일', '월', '화', '수', '목', '금', '토']
    		      ,dayNamesMin: ['일', '월', '화', '수', '목', '금', '토']
    		      ,changeMonth: true // 월선택 select box 표시 (기본은 false)
    		      ,changeYear: true  // 년선택 selectbox 표시 (기본은 false)
    		      ,showMonthAfterYear: true // 다음년도 월 보이기
    		      ,showOtherMonths: true // 다른 월 달력에 보이기
    		      ,selectOtherMonths: true // 다른 월 달력에 보이는거 클릭 가능하게 하기
    		      ,onSelect: function(d){self.$emit('update-date',d)}
    		    });
    		  },
    		  beforeDestroy: function(){$(this.$el).datepicker('hide').datepicker('destroy')}
    		});
    	
    	
    	searcharea = new Vue({
										  el: '#searcharea',
										  data: {
											            date: null,
											            searchgrouptype: '',
														sgroupinput : '666',
													    searchoption:[
													                          {value:"", text:"전체"},
																	          {value:"option1", text:"항목1"},
																	          {value:"option2", text:"항목2"}
													                     ]
										        },
										        methods:{					
										        	sclick:function(event){
														  alert(this.sgroupinput);
													  },
													updateDate: function(d) {
										    		      this.date = d;
										    		}  
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
								class="btn_nav bold">Sample</span> <span class="btn_nav bold">TestPage1
								</span> <a href="/test/TestPage1.do" class="btn_set refresh">새로고침</a>
						</p>

                        <br> <b><h3>VueJS 소스에서 ]현재 화면의 폼바인딩 처리 중 정상적으로 나오지 않는 오류 원인 2가지가 무엇일까요.(개발자 모드의 로그)</h3></b>
                        <br> 참조 :  &nbsp&nbsp&nbsp&nbsp&nbsp<a  href="https://v3.ko.vuejs.org/api/instance-properties.html#el" target="_blank"> 인스턴스</a>
                        <br> 
                        <p class="conTitle" id="searcharea">
							<span>검색</span> 
							<span class="fr">
							     <datepicker @update-date="updateDate" style="width: 100px; height: 25px;"></datepicker>
							     <select id="searchgrouptype"  name="searchgrouptype"  v-model="searchgrouptype" style="width: 150px;">
								     <option v-for="option in searchoption" v-bind:value="option.value">
									    {{ option.text }}
									  </option>
							     </select> 
							     
							     <input type="text" style="width: 300px; height: 25px;" id="sgroupinput" name="sgroupinput" v-model="sgroupinput">                    
	                              <a href="" class="btnType blue" id="btnSearchGrpcod" name="btn" @click="sclick"><span>검  색</span></a>
							</span>
    
						</p>

					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
					<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!--// 모달팝업 -->
</body>
</html>