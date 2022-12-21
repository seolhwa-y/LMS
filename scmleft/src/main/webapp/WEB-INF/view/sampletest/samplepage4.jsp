<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>SamplePage4</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
                              
<script type="text/javascript">
    
    $(document).ready(function() {
    	var homecomponent = {
    			template : '<div><h3>home</h3><input type="text" /></div>'
    	}
    	
    	var page1component = {
    			template : '<h3>page1 : {{ $route.params.data1 }}  : {{ $route.params.data2 }}</h3>'
    	}
    	
    	var page2component = {
    			template : '<h3>page2</h3>'
    	}
    	
    	var router = new VueRouter({
    		      routes : [
    		                    {
    		    	                path : '/',
    		    	                component : homecomponent
    		                    },
    		                    {
    		    	                path : '/page1/:data1/:data2',
    		    	                component : page1component
    		                    },
    		                    {
    		    	                path : '/page2',
    		    	                component : page2component
    		                    }
    		                 ]
    	
    	})
    	
    	var test1 = new Vue({
    	       el : "#test1",
    	       router : router
    	});
    	
    	// Vue에서 각 관리영역에서 공통으로 사용하는 함수들을 정의 하고 각 관리 영역에서 mixins : [myMixin]   이렇게 쓰면 
    	// mixins : [myMixin]  에 등록된 함수를 공통으로 사용 할수 있다.
    	var myMixin = {
    			created : function() {
    				alert("Mixin Create");
    			} ,
    			methods : {
    				             test1 : function() {
    				            	 alert("test1");
    				             },
    				             test2 : function() {
    				            	 alert("test2");
    				             }
    			}
    			
    	}
    	
   	/* 
    	
    	var Component = Vue.extend({
    	      mixins : [myMixin]    	
    	})
    	
    	var Component = new Component();
    	
    	 */
    	 
    	
    	
    	var test2 = new Vue({
 	       el : "#test2",
 	       mixins : [myMixin]    	
 	    });
    	 
    	 test2.test1();
    	 test2.test2();
    	

         
    	 Vue.component("com1", {
    		 template : "<h1>hello World </h1>"
    	 })
    	 
    	 Vue.component("com2", {
    		 template : "<h1>hello World <slot></slot></h1>"
    	 })
    	 
    	 Vue.component("com3", {
    		 render : function(createElement) {
    			 //var msg = "Hello World";
    			 
    			 var msg = "Hello World " + this.$slots.default[0].text;
    			 
    			 var tagname = this.tagname;
    			 var idvalue = this.id;
    			 
    			 var h1_tag = createElement(tagname,{  
    				                                          attrs : {
    				                                        	         id: idvalue,
    				                                        	         //style : "color:red;background-color:blue"
		    				                                          },
		    				                                          style : {
		    				                                        	          color : "red",
		    				                                        	          backgroundColor : "blue"
		    				                                          }
    			 
    			 },msg);
    			 
    			 return h1_tag;
    		 },
    		 props : {    // color, bgcolor 도 똑같이 파라메터 처리 가능   required : 필수 입력 항목 지정
    			 tagname : {
    				  attributes : String,
    				  required : true
    			 },
    			 id : {
    				 attributes : String
    			 }
    		 }
    	 })
    	 
    	 var test3 = new Vue({
   	       el : "#test3"	
   	    });
    	 
    	 var test4 = new Vue({
     	       el : "#test4",
     	       data : {
     	    	   value1 : 100,
     	    	   obj1 : {},
     	    	   counter : 0,
     	    	   newvalue : 0,
     	    	   oldvalue : 0
     	       },
     	       methods : {
     	    	   setvalue1 : function() {
     	    		   this.value1 = 200;
     	    	   },
     	    	  setvalue2 : function() {
    	    		   this.value2 = 300;
    	    	   },
      	    	  setvalue3 : function() {
   	    		   this.obj1.value3 = 333300;
   	    	      },
   	    	      addcounter : function() {
   	    	    	  this.counter++;
   	    	      }
     	       }
     	    });
    	 
    	 //test4.value1 = 1000;
    	 //test4.value2 = 2000;  // 외부에서 Vue 객체 생성 후 변수 추가시 반영(랜더링_ 안됨    value1 에 값이 바뀔때 반영 됨
    	 Vue.set(test4.obj1, 'value3',3000);  // 외부 생성 변수 바로 랜더링 하기 위해 set 사용
    	 
    	 
    	 test4.$watch("counter", function(new_value,old_value) {
    		 this.newvalue = new_value;
    		 this.oldvalue = old_value;
    	 });
    	 
    	 

	 
	 var test5 = new Vue({
		  el : "#test5",
		  methods : {
			  divclick : function() {
				  alert("divclick");
			  },
			  tetinput : function() {
				  alert("tetinput");
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
								class="btn_nav bold">Sample</span> <span class="btn_nav bold">SampleTest4
								</span> <a href="/sampletest/samplepage4.do" class="btn_set refresh">새로고침</a>
						</p>

                        <br>   
                        <h4>- 라우팅(Route)</h4><br>
                         <div id="test1">
                             <router-link to="/">home</router-link>
                             <router-link to="/page1/test1/test11">page1 test1 test11</router-link>
                             <router-link to="/page1/test2/test22">page1 test2 test22</router-link>
                             <router-link to="/page2">page2</router-link>
                             <!--  링크를 누르면 뵤여줄 화면이 표시되는 부분 -->
                             <router-view></router-view>
                         </div>
                         <br>
                         <h4>- Mixin</h4><br>
                         Vue에서 각 관리영역에서 공통으로 사용하는 함수들을 정의 하고 각 관리 영역에서 mixins : [myMixin]   이렇게 쓰면<br> 
    	                 mixins : [myMixin]  에 등록된 함수를 공통으로 사용 할수 있다.<br>
                         <div id="test2">
                             <button type="button" @click="test1">test1</button>
                             <button type="button" @click="test2">test2</button>
                         </div>
                 
                          <br>
                          <h4>- 랜더 함수</h4><br>
                         <div id="test3">
                            <com1>Apple</com1>
                            <com1>Google</com1>
                            <com1>MicroSoft</com1>
                            
                            <com2>Apple</com2>
                            <com2>Google</com2>
                            <com2>MicroSoft</com2>
                            
                            <br>
                            // "'h1'"   'h1' 문자열로 파라메터로 넘기기 위해
                            <com3 :tagname="'h1'" :id="'aa'">Apple</com3>
                            <com3 :tagname="'h2'">Apple</com3>
                         </div>
 
                          <br>
                          <h4>- 반응형 인터페이스</h4><br>
                          <div id="test4">
                               <h3> value1 : {{ value1 }}</h3>
                               <button type="button" @click="setvalue1">value1</button>
                              <!--  <h3> value2 : {{ value2 }}</h3> 
                               <button type="button" @click="setvalue2">value2</button> -->
                               <h3> value3 : {{ obj1.value3 }}</h3>
                               <button type="button" @click="setvalue3">value3</button>
                               <h3> counter : {{ counter }}</h3>
                               <h3> newvalue : {{ newvalue }}</h3>
                               <h3> oldvalue : {{ oldvalue }}</h3>
                               
                               <button type="button" @click="addcounter">addcounter</button>
                          </div>
                          
                          <br>
                          <div id="test5" @click.stop="divclick">
                               <input type="text" @input="tetinput" />
                          
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