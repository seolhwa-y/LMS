<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:if test="${sessionScope.userType ne 'C'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마이페이지</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

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
        
</script>
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">

	var userInfoArea;
	var userChk;
	
	//온로드이벤트
	$(document).ready(function(){
		
		init();
		
		//마이페이지 조회
		detailUser();
		
		//버튼이벤트 등록
		buttonClickevent();
		
	});
	
	
	function init(){
		userInfoArea = new Vue({
			el : '#userinfoarea',
			data :{
					rloginID:"",
					name:"",
					password:"",
					repassword:"",
					hp:"",
					email:"",
					zip:"",
					addr:"",
					dtl_add:"",
					company:""
				
			}
			
		})
		
		userChk = new Vue({
			methods:{
				usercheck:function()  {
					/*패스워드 정규식*/
					var passwordRules = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
				 	var password = userInfoArea.password;
				 	var repassword = userInfoArea.repassword;
					/*이메일 정규식*/
					var emailRules = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
					var email = userInfoArea.email;
						var chk = checkNotEmpty(
						[ [ "rloginID", "아이디를 입력해주세요!" ]
				         ,[ "password", "비밀번호를 입력해주세요!" ]
						 ,[ "hp", "연락처 기입해주세요!" ]
						 ,[ "email", "이메일을 입력해주세요!" ]
						 ,[ "zip", "우편번호를 입력해주세요!" ]
						 ,[ "addr", "주소를 입력해주세요!" ]
						 ,[ "dtl_add", "상세주소 기입해주세요!" ]
						 ,[ "name", "이름을 기입해주세요!" ]
						 ,[ "company", "회사명 기입해주세요!" ]]
						);
					
					
					if (!chk) {
						return;
					} else if(password!=repassword){
						swal('비밀 번호가 서로 일치하지 않습니다.');
						return;
					} else if(!passwordRules.test(password)){
						swal('비밀 번호는 숫자,영문자,특수문자 조합으로 8~15자리를 사용해야 합니다.');
						return;
					} else if(!emailRules.test(email)){
						swal("이메일 형식을 확인해주세요.");
						return;
					} 
					
					saveUser();
				}
			}			
		
		})
		
	}
	
	
	//버튼이벤트
	function buttonClickevent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			
			case 'btnUpdateUser' : 
				userChk.usercheck();  // 수정하기
			break;
			
			}
		});
	}
	
	/*회원정보 상세 조회*/
	function detailUser() {
		
		var ID = '${loginID}'		
		var param = {
				loginID : ID
		};
		
		console.log(param);
		var resultCallback = function(data) {
			console.log("상세정보콜백 : " + "resultCallback : " + JSON.stringify(data))
			usercallback(data);
		};

		callAjax("/cor/detailUser.do", "post", "json", true, param,
				resultCallback);

	}
	
	//회원정보 콜백
	function usercallback(data) {
		
		frealPopModal(data.result);
		
	}
	
	// 팝업 _ 초기화 페이지(신규) 혹은 내용뿌리기  
     function frealPopModal(object){
    	console.log(object);

    	userInfoArea.rloginID = object.loginID;
		userInfoArea.name = object.name;
		userInfoArea.password = object.password;
		userInfoArea.repassword = object.password;
		userInfoArea.hp = object.hp;
		userInfoArea.email = object.email;
		userInfoArea.zip = object.zip;
		userInfoArea.addr = object.addr;
		userInfoArea.dtl_add = object.dtl_add;
		userInfoArea.company = object.company; 

       
    }  
	
     /* 회원 등록(저장) */
     function saveUser() {
     	
     	var param = {
     		rloginID : userInfoArea.rloginID,
    		name : userInfoArea.name,
    		password: userInfoArea.password, 
    		repassword : userInfoArea.repassword, 
    		hp : userInfoArea.hp, 
    		email : userInfoArea.email, 
    		zip : userInfoArea.zip,
    		addr : userInfoArea.addr, 
    		dtl_add : userInfoArea.dtl_add, 
    		company : userInfoArea.company 
     	}
     	
     	var resultCallback2 = function(data) {
			swal("썽공");
     	};

     	callAjax("/cor/saveUser.do", "post", "json", true, param, resultCallback2);

     }
     
     //우편번호 api
     function execDaumPostcode(q) {
     	new daum.Postcode({
     		oncomplete : function(data) {
     			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

     			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
     			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
     			var addr = ''; // 주소 변수
     			var extraAddr = ''; // 참고항목 변수

     			//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
     			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
     				addr = data.roadAddress;
     			} else { // 사용자가 지번 주소를 선택했을 경우(J)
     				addr = data.jibunAddress;
     			}

     			// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
     			if (data.userSelectedType === 'R') {
     				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
     				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
     				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
     					extraAddr += data.bname;
     				}
     				// 건물명이 있고, 공동주택일 경우 추가한다.
     				if (data.buildingName !== '' && data.apartment === 'Y') {
     					extraAddr += (extraAddr !== '' ? ', '
     							+ data.buildingName : data.buildingName);
     				}
     			}

     			// 우편번호와 주소 정보를 해당 필드에 넣는다.
     			//document.getElementById('zipcode').value = data.zonecode;
     			//document.getElementById("address").value = addr;
     			userInfoArea.zip = data.zonecode;
     			userInfoArea.addr = addr;
     			
     			// 커서를 상세주소 필드로 이동한다.
     			document.getElementById("dtl_add").focus();
     		}
     	}).open({
     		q : q
     	});
     	
     }
     
</script>



</head>
<body>
<form id="myUser" action=""  method="">

	<input type="hidden" id="selectedInfNo" value="">
	<input type="hidden" name="action" id="action" value="">
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
	
					<div class="content">

						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">마이페이지</span> <span
								class="btn_nav bold">정보 변경</span> <a href="../cor/myPage"
								class="btn_set refresh">새로고침</a>
						</p>
						
					<p class="conTitle">
                        <span>마이 페이지 </span> 
					</p>
											
					<div id="userinfoarea">
					<input type="hidden" id="loginID" name="loginID" /> <!-- 수정시 필요한 num 값을 넘김  -->
          			 <dl>
			
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
							<th scope="row" style="width:70px">아이디 <span class="font_red">*</span></th>
							<td><input type="text" name="rloginID" id="rloginID" v-model="rloginID" readonly="readonly"/>
							</td>
							
							<th style="width:70px" scope="row">비밀번호<span class="font_red">*</span></th>
							<td><input type="password" name="password" id="password" v-model="password"/></td>
						</tr>
						
						<tr>
							<th scope="row">연락처 <span class="font_red">*</span></th>
							<td>
								<input style="width:160px" type="text" id="hp" name="hp" v-model="hp">
							</td>
							<th style="width:70px" scope="row">비밀번호 확인<span class="font_red">*</span></th>
							<td><input type="password" name="repassword" id="repassword" v-model="repassword"/></td>
									
						</tr>
						
						<tr>
							<th scope="row" style="width:70px">이름<span class="font_red">*</span></th>
							<td><input type="text" name="name" id="name" v-model="name"/></td>
							
							<th scope="row">이메일 </th>
							<td style='width:30%'>
								<input type="text"  name="email" id="email" v-model="email" size="30">
							</td>					
						</tr>
						
						<tr id="outstaff">
							<th scope="row" style="width:70px">회사명<span class="font_red">*</span></th>
							<td colspan="4"><input type="text" name="company" id="company" v-model="company"/></td>
							
						</tr>
						
						<tr>
							<th style="width:70px" scope="row">우편번호<span class="font_red">*</span></th>
							<td colspan="4"><input type="text" name="zip" id="zip" v-model="zip"/>
							<input type="button" value="우편번호 찾기"
								onclick="execDaumPostcode()"
								style="width: 130px; height: 20px;" />
							</td>
						</tr>
						<tr>
							<th style="width:70px" scope="row">주소<span class="font_red">*</span></th>
							<td colspan="4"><input type="text" name="addr" id="addr" v-model="addr" size="100"/></td>
						</tr>
						<tr>
							<th style="width:70px" scope="row">상세주소<span class="font_red">*</span></th>
							<td colspan="4"><input type="text" name="dtl_add" id="dtl_add" v-model="dtl_add" size="100"/></td>
						</tr>
							
					</tbody>
					
				</table>
				<div class="btn_areaC mt30">
					
					<a href="" class="btnType blue" id="btnUpdateUser" name="btn"><span>정보 수정</span></a>			
					
				</div>
		    	</dd>
          		</dl>
				<!-- <a href="" class="closePop"><span class="hidden">닫기</span></a> -->
     			</div>
					</div>
			
				</li>
				</ul>
				
		</div>
	</div>



</body>
</html>