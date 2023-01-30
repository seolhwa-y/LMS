<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>SamplePage3</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
                              
<script type="text/javascript">
    
    $(document).ready(function() {
    	Vue.directive('focus', {
    		inserted : function(el) {
    			el.focus()
    		}
    	});
    	
    	var test1 = new Vue({
    		                           el : "#test1",
    		                           data : {
    		                        	          str : '' ,
    		                        	          data1 : "data1 values"
    		                           },
    		                           methods : {
    		                        	       setstr : function() {
    		                        	    	   this.str = "변경된 문자열"
    		                        	       }
    		                           },
    		                           directives : {
    		                        	   focus2 : {
    		                           		             inserted : function(el) {
    		                        			                                           el.focus()
    		                           		             }
    		                        	   },
    		                        	   test : {
    		                        		   // 지시자가 태그에 셋팅 되었을때 딱 한번 실행
    		                        		   bind : function(el) {
    		                        			       console.log("bind");
    		                        		   },
    		                        		   // 지시자가 셋팅되어 있는 HTML 태그가 객체로 만들어지고 사용 가능한 형태가 되었을때 호출되는 함수
        		                        	   inserted : function(el) {
        		                        		   console.log("inserted");
        		                        	   },
        		                        	   // 지시자가 셋팅되어 있는 HTML 태그가 변경되기 전 
        		                        	   update : function(el) {
        		                        		   console.log("update");
        		                        	   },
        		                        	   // 지시자가 셋팅되어 있는 HTML 태그가 변경된 후 
        		                        	   componentUpdated : function(el) {
        		                        		   console.log("componentUpdates");
        		                        	   },
        		                        	   // 지시자가 셋팅되어 있는 태그에서 지시자가 제거 될때 ( 예 : 다른 페이지로 이동시)
        		                        	   unbind : function(el) {
        		                        		   console.log("unbind");
        		                        	   }
    		                        	   },
        		                           test2 : {
  		                        	                   bind : function(el, binding, vnode) {
	                        			                    console.log("el : " + el);
	                        			                    console.log("바인딩 된 지시자 이름 binding.name : " + binding.name);
	                        			                    console.log("바인딩 된 지시자 값 binding.value : " + binding.value);
	                        			                    console.log("바인딩 된 파라메터 이름 binding.arg : " + binding.arg);
	                        			                    console.log("바인딩 된 파라메터 a1 유무 binding.modifiers.a1 : " + binding.modifiers.a1);
	                        			                    console.log("바인딩 된 파라메터 a2 유무 binding.modifiers.a2 : " + binding.modifiers.a2);
	                        			                    console.log("바인딩 된 파라메터 a3 유무 binding.modifiers.a3 : " + binding.modifiers.a3);
	                        			                    console.log("바인딩 된 태그 이름 vnode.tag : " + vnode.tag);
	                        		                   }
  		                                           }
    		                           }
    		
    		
    	});
    	
    	
    	
    	
	});


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
								class="btn_nav bold">Sample</span> <span class="btn_nav bold">SampleTest3
								</span> <a href="/sampletest/samplepage3.do" class="btn_set refresh">새로고침</a>
						</p>

                        <br>  
                        사용자 정의 지시서
                        <br>  
                        <div id="test1">
                            <input type="text"  v-focus /> <br>
                            <input type="text"  v-focus2 /><br>
                            <h3 v-test>{{str}}</h3><br>
                            <button type="button" @click="setstr"> str 변경</button><br>
                            <h3 v-test2="data1">{{str}}</h3>
                            <h3 v-test2="1 + 1">{{str}}</h3>
                            <h3 v-test2:arg1="data1">{{str}}</h3>
                            <h3 v-test2:arg1.a1.a2="data1">{{str}}</h3>
                            <!-- <h3 v-test2="paramdata">{{str}}</h3>   paramdata  라는 변수를 찾아서 에러-->
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