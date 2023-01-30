<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>SamplePage2</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
                              
<script type="text/javascript">
        
    var htmlinput;    
        
	$(document).ready(function() {
		
		init();
		
	});

	
	function init() {
		Vue.component('inputtest',{
			   props:['msg'],    
	           template : '<div>Login ID : &nbsp&nbsp {{ inputtext }} &nbsp&nbsp&nbsp&nbsp&nbsp{{ msg }}' + 
	                          '<br> <input type="text" v-model="inputtext" @input="clickev" />' + 
	                          '<br> <a class="btnType blue" @click="btnclick" name="modal">값 확인</a>' +
	                          '</div>',
	           data: () => ({
	        	                 inputtext: '',
	        	    }),
        	    methods:{					
					  clickev:function(event){
						  htmlinput.htmlinput = this.inputtext;
						  console.log(this.inputtext);
					  },
					  btnclick:function(event){
						  alert(this.inputtext);
					  },
				  }  
        });
		
		htmlinput = new Vue({
									        el : '#vuearea1',
									       data: {
									    	            htmlinput : ""
									       },
									       methods:{					
									    	      inputtextfunc:function(event){
													  console.log(this.htmlinput);
												  },
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
								class="btn_nav bold">Sample</span> <span class="btn_nav bold">SampleTest2
								</span> <a href="/sampletest/samplepage2.do" class="btn_set refresh">새로고침</a>
						</p>

                        <br>
                        <div id="vuearea1">
                               <inputtest msg="로 로그인 중 입니다."> </inputtest>
                               <input type="text" id="htmlinput" name="htmlinput" v-model="htmlinput"  @input="inputtextfunc" /><br>
                               <div>{{ htmlinput }}</div>
                               <inputtest msg="로 두번째...로그인 중 입니다. "> </inputtest>
                               
                        </div>

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