<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title> 고객/회원 관리  </title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" charset="utf-8"
	src="${CTX_PATH}/js/popFindZipCode.js"></script>
	
<c:if test="${sessionScope.userType ne 'A'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>

<script type="text/javascript">

	// 페이징 설정 
	var userPageSize = 10;  	// 화면에 뿌릴 데이터 수 
	var userPageBlock = 10;		// 블럭으로 잡히는 페이징처리 수
	
	var userareavar;
	var searcharea;
	
	$(document).ready(function() {
		init();
		// 사용자 목록 조회
		fListInf();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
    });
	
	function init(){
		
		
		//comcombo("divCD", "checkstaff", "all", "");
		
		userareavar = new Vue({
			  el: '#divUserList',
			  componened4ts: {
				                   'bootstrap-table': BootstrapTable
				                },
			  data: {
				  			   userlist:[],
				  			   action:"",
				  			   type:""
			  }, 
			  methods:{					
				  detailview:function(loginID){
					  fUserModal(loginID);  
				  }
			  }  
			});	
		

		searcharea = new Vue({
            el : "#searcharea",
           data : {
          	 option : "",
          	 search : ""
           } 
		});
		
		usereditvue = new Vue({
			  el: '#user',
			  data: {
				  divCD:"",    
				  rloginID:"",
				  password:"",
				  hp:"",
				  email:"",
				  name:"",
				  chaCD:"",
				  zip:"",
				  addr:"",
				  company:"",
				  dtl_add:"",
				  delflag:true,
				  type:"out",
				  checkstaff:"instaff",
				  account:"",
				  bank:"",
				  checkbank:"",
				  checkcha:"A",
				  readonly:"",
				  optionflag:"",
				  idcheck:true,
				  inflag:true,
				  outflag:false
			  },
			  methods : 
			  {
				  setdtlfocus : function() 
				  {
					  this.$refs.dtl_add.focus();
				  },
				  check : function() 
				  {
					  
					  var chk = false;
					  
					  if (this.inflag) 
					  {
							//swal("내부직원 validation입니다.");
							//console.log("내부 직원 로직 실행");
							
							chk = checkNotEmpty(
									[
											[ "hp", "연락처를 입력해주세요!" ],
											[ "password", "비밀번호를 입력해주세요!" ],
									        [ "email", "이메일을 입력해주세요!" ],
									        [ "name", "직원명을  입력해주세요!" ],
									        [ "zipcode", "우편번호를 입력해주세요!" ],
									        [ "address", "주소를 입력해주세요!" ],
									        [ "dtl_add", "상세주소를 입력해주세요!" ] 
									]
							);
							
							
						}
					  	else if(this.outflag || userareavar.action == "I")
					  	{	
							//console.log("외부 직원 로직 실행");
							chk = checkNotEmpty(
									[
											[ "password", "비밀번호를 입력해주세요!" ],
											[ "rloginID", "아이디를 입력해주세요!" ],
											[ "hp", "연락처를 입력해주세요!" ],
									        [ "email", "이메일을 입력해주세요!" ],
									        [ "company", "회사명을  입력해주세요!" ],
									        [ "name", "담당자명을 입력해주세요!"],
									        [ "zipcode", "우편번호를 입력해주세요!" ],
									        [ "address", "주소를 입력해주세요!" ],
									        [ "dtl_add", "상세주소를 입력해주세요!" ], 
									        [ "account", "계좌명을 입력해주세요!"],
									        [ "checkbank", "은행을 선택해주세요"]
									]
							)
						}
					  	else
					  	{
							//console.log("어케 들어옴?");
						}
						
						if (!chk)
						{							
							return;
						}
						if(userareavar.action == "I")
						{
							fn_usersave();
						}
						else if(userareavar.action == "U")
						{
							fn_usersave();
						}
						else
						{
							console.log("오류!!!");
						}
				  },
				  
				  samecheck : function() {
					  // var checkid = this.rloginID;
					  
					console.log(this.rloginID);
					var param = {
							  checkid : this.rloginID
		             } 
					 
					callAjax("/scm/check_loginID.do","post", "json", true, param, this.resultCallback4);
				  },
				  	resultCallback4 : function(data)
				  	{
				  		if (data.result == 0) {
							console.log("아이디 중복안됨");
							
							swal("사용할 수 있는 아이디입니다.");
						} else {
							console.log("아이디 중복");
							
							swal("중복된 아이디가 존재합니다.");
							
							this.rloginID = ""; // 빈값으로 만들기
							this.idcheck = false;  // 저장버튼 잠금
							
						}
				  	},
				  editchang : function() {
					  
					  if(this.checkstaff == "instaff"){
						  this.inflag = true;
						  this.outflag = false;
					  } else {
						  this.inflag = false;
						  this.outflag = true;
					  }
						  
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
				case 'btnClose' :
					gfCloseModal();
					break;
				case 'btnUpdateUser' :
					usereditvue.check();
					break;	
				case 'btnSaveUser' :
					usereditvue.check();
					break;	
				case 'duplicate_check' :
					console.log("이벤트 핸들러 들어옴");
					usereditvue.samecheck();
					break;	
							}
			});
	}
	
	/** 사용자 목록 조회 */
	function fListInf(currentPage) {
		
		currentPage = currentPage || 1;
		
		//console.log("currentPage : " + currentPage);
		
		var param = {
					currentPage : currentPage,
					pageSize : userPageSize,
					option : searcharea.option,
					search : searcharea.search
		}
		
		var resultCallback = function(data) { 
			//console.log("resultCallback : " + JSON.stringify(data));
			
			fListInfResult(data, currentPage);
		};
		
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		//html로 받을거라 text
		callAjax("/scm/UserInfoList.do", "post", "json", true, param, resultCallback);
	}

	/** 사용자 목록 조회 콜백 함수 */
	function fListInfResult(data, currentPage) {

		//console.log(data);		
		userareavar.userlist = data.listUser;
		
		// 총 개수 추출
		var totalCntlistInf = data.totalCount;
		var list = $("#selectedInfNo").val();
		
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCntlistInf, userPageSize, userPageBlock, 'fListInf',[list]);
		//console.log("paginationHtml : " + paginationHtml);
	
		$("#listInfPagination").empty().append( paginationHtml );
	}
	 /*신규등록*/
	 function fn_userreg() {
		userareavar.action = "I";
		
		frealPopModal();
		
		gfModalPop("#user");
	}
	
	/*사용자 상세 조회*/
	 function fUserModal(loginID) {
	
		 var param = {
				 loginID : loginID};
		 var resultCallback2 = function(data){
			 
		       //console.log("resultCallback2 : " + JSON.stringify(data));
		       fdetailResult(data);
		 };
		 
		 callAjax("/scm/detailUser.do", "post", "json", true, param, resultCallback2);
	 }
	
	 /*사용자 상세 조회 -> 콜백함수  */
	 function fdetailResult(data){

		 if(data.resultMsg == "SUCCESS"){
			 userareavar.action = "U"
			 //모달 띄우기 
			 gfModalPop("#user");
			 
			// 모달에 정보 넣기 
			frealPopModal(data.result);
		 }else{
			 alert(data.resultMsg);
		 }
	 }
	
	 
	 /* 팝업 _ 초기화 페이지(신규) 혹은 내용뿌리기  */
	 function frealPopModal(object){
		 //console.log("userareavar.action = " + userareavar.action);
		 if(userareavar.action == "I") {
			 usereditvue.rloginID = "";
			 usereditvue.password = "";
			 usereditvue.hp = "";
			 usereditvue.email = "";
			 usereditvue.name = "";
			 usereditvue.company = "";
			 //usereditvue.chaCD = "";
			 usereditvue.zip = "";
			 usereditvue.addr = "";
			 usereditvue.dtl_add = "";
			 usereditvue.divCD = "";
			 usereditvue.bank = "";
			 usereditvue.optionflag = false;
			 
			 usereditvue.delflag = false;
			 usereditvue.readonly = false;
		 } else {
			 if(object.div_cd == "outstaff"){
				 usereditvue.inflag = false;
				 usereditvue.outflag = true;				  
			 }else{
				  usereditvue.inflag = true;
				  usereditvue.outflag = false;
			  }
			 
			 usereditvue.checkbank= object.bank;
			 usereditvue.checkstaff= object.div_cd;
			 usereditvue.checkcha= object.user_type;
			 usereditvue.rloginID = object.loginID;
			 usereditvue.password = object.password;
			 usereditvue.hp = object.hp;
			 usereditvue.email = object.email;
			 usereditvue.name = object.name;
			 usereditvue.company = object.company;
			 //usereditvue.chaCD = object.chaCD;			 
			 usereditvue.account = object.account;
			 usereditvue.zip = object.zip;
			 usereditvue.addr = object.addr;
			 usereditvue.dtl_add = object.dtl_add;
			 usereditvue.bank = object.bank;
			 usereditvue.optionflag = true;
			 
			 usereditvue.delflag = true;
			 usereditvue.readonly = true;
		 } 
	 }
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
	             //document.getElementById('zip').value = data.zonecode;
	             //document.getElementById("addr").value = addr;
	             usereditvue.zip = data.zonecode;
	             usereditvue.addr = addr;
	             // 커서를 상세주소 필드로 이동한다.
	             document.getElementById("dtl_add").focus();
	             //usereditvue.setdtlfocus();
	          }
	       }).open({
	          q : q
	       });
	    }
	 /*사용자 수정*/
	 function fn_usersave() {
		var  param = {
		     	 action : userareavar.action,
				 rloginID : usereditvue.rloginID,
				 password : usereditvue.password,
				 hp : usereditvue.hp,
				 email : usereditvue.email,
				 name : usereditvue.name,
				 zip : usereditvue.zip,
				 addr : usereditvue.addr,
				 dtl_add : usereditvue.dtl_add,
				 checkstaff : usereditvue.checkstaff,
				 div_cd : usereditvue.div_cd,
				 // 기업고객
				company : usereditvue.company,
				bank : usereditvue.checkbank,
				account : usereditvue.account,
				//내부
				chaCD : usereditvue.checkcha 
		 }
		 
		 var savecallback = function(savereturn) {
			 //console.log("savecallback : " + JSON.stringify(savereturn));
			 
			 if(savereturn.resultMsg == "SUCCESS") {
				 alert(" 저장되었습니다.");
				 gfCloseModal();
				 
				 fListInf();
			 } else if(savereturn.resultMsg == "UPDATED"){
				 alert(" 수정되었습니다.");
				 gfCloseModal();
				 
				 fListInf();
			 }else{
			 
				 alert("오류!");
			 }
		 }
		 
		 callAjax("/scm/userSave.do", "post", "json", true, param, savecallback);
	 }

</script>
</head>
<body>
	<!-- ///////////////////// html 페이지  ///////////////////////////// -->

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
							<a href="#" class="btn_nav">시스템 관리</a> 
								<span class="btn_nav bold">사용자 관리</span> 
							</p>
							<p class="conTitle">
							<span>사용자 관리 </span> 
							<!--검색창   -->
							<span class="fr">

							<div id="searcharea"><span></span><span class="fr"> 
									
								<select id="option" name="option"  v-model="option">
								    <option value="" >전체</option>
									<option value="user_id" >아이디</option>
									<option value="user_name" >회사/성명</option>
									<option value="user_cha" >담당업무</option>
								</select>
									<input type="text" id="search" name="search" v-model="search" style="height:27px"> 

									<input class="btnType blue" type="button" name="memberSearchBtn" value="검색" onclick="javascript:fListInf()">
								<!-- 
									<intput type="button class="btnType blue" href="javascript:fListInf()" placeholder="" style="height:27px" >
									<span id="searchEnter">검색</span></a>							 
								 -->
								</span>
							</div>	
							</p>	        							     
						     	
					        <div id="divUserList">
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
														<col width="8%">
														<col width="18%">
														<col width="18%">
														<col width="23%">
														<col width="18%">
														<col width="15%">
													</colgroup>
													<thead>
														<tr>
														      <th scope="col">구분</th>
														      <th scope="col">아이디</th>
												              <th scope="col">회사명/성명</th>
												              <th scope="col">담당자명</th>
												              <th scope="col">담당업무</th>
												              <th scope="col">연락처</th>
														</tr>
													</thead>
													
													<tbody id="listInf" v-for="(item,index) in userlist" v-show="userlist.length">
														<tr @click="detailview(item.loginID)">
														    <td>{{ item.divCD}}</td>
														    <td>{{ item.loginID}}</td>
															<td>{{ item.name}}</td>
															<td>{{ item.company}}</td>
															<td>{{ item.chaCD}}</td>
															<td>{{ item.hp}}</td>									
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
						</div>
						<span class="fr"> 
						<c:set var="nullNum" value=""></c:set>
						<a class="btnType blue" href="javascript:fn_userreg();" name="modal">
						<span>신규등록</span></a>
						</span>
					</li>
				</ul>
			</div>
		</div>
<!-- 회원관리 모달 -->
		<div id="user" class="layerPop layerType2" style="width: 1000px; display: table;">
		<input type="hidden" id="loginID" name="loginID"> <!-- 수정시 필요한 num 값을 넘김  -->
           <dl>
			<dt>
				<strong>회원관리</strong>
			</dt>
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
							<th scope="row" rowspan="3" >
								<select id="checkstaff" name="checkstaff" style="width: 80px;" v-model="checkstaff" @change="editchang()" :readonly="readonly" >
									 <option value="instaff">내부직원 </option>
									 <option value="outstaff" :disabled="optionflag">기업고객 </option>
								</select>
							</th>
							
							<th scope="row" style="width:70px">아이디 <span class="font_red">*</span></th>
							<td>
								<input type="text" name="rloginID" id="rloginID" v-model="rloginID" :readonly="readonly" style="width:160px"/>
								<!-- <a href="" class="btnType blue" id="btnUpdateUser" name="btn" v-if="delflag" :disabled="idcheck"><span>수정</span></a> -->
								<a href=""  id="duplicate_check" name="btn" style="border: 1px solid">중복체크</a>
								<!-- <button id="duplicate_check" type="button" @click="usereditvue.idcheck()">중복체크</button> -->
							</td>
							
							<th style="width:70px" scope="row">비밀번호<span class="font_red">*</span></th>
							<td><input type="password" name="password" id="password" v-model="password" style="width:160px"/></td>
						</tr>
						
						<tr>
							<th scope="row">연락처 <span class="font_red">*</span></th>
							<td>
								<input style="width:160px" type="text" id="hp" name="hp" v-model="hp"/>								
							</td>
							<th scope="row">이메일 </th>
							<td style='width:30%'>
								<input type="text"  name="email" id="email" size="30" v-model="email" style="width:160px"/>
							</td>							
						</tr>
						<tr id="instaff" v-show="inflag">
							<th scope="row" style="width:70px">직원명<span class="font_red" >*</span></th>
							<td><input type="text" name="name" id="name" v-model="name" style="width:160px"/></td>
							<th style="width:70px" scope="row">담당업무<span class="font_red">*</span></th>
							<td>
								<select id="checkcha" name="checkcha" style="width: 120px;" v-model="checkcha">
									 <option value="A">SCM담당자 </option>
									 <option value="B">배송담당자</option>
									 <option value="D">구매담당자</option>
									 <option value="E">회사임원 </option>
								</select>
							</td>
						</tr>
						<tr id="outstaff" v-show="outflag">
							<th scope="row" style="width:70px">회사명<span class="font_red" >*</span></th>
							<td><input type="text" name="company" id="company" v-model="company" style="width:160px"/></td>
							<th style="width:70px" scope="row">담당자명<span class="font_red">*</span></th>
							<td><input type="text" name="name" id="name" v-model="name" style="width:160px"/></td>
						</tr>
						<tr>
							<th style="width:70px" scope="row">우편번호<span class="font_red">*</span></th>
							<td colspan="4"><input type="text" name="zipcode" id="zipcode" v-model="zip"/>
							<input type="button" value="우편번호 찾기"
								onclick="execDaumPostcode()"
								style="width: 130px; height: 20px;" />
							</td>
						</tr>
						<tr>
							<th style="width:70px" scope="row">주소<span class="font_red">*</span></th>
							<td colspan="4"><input type="text" name="address" id="address" size="100" v-model="addr"/></td>
						</tr>
												<tr>
							<th style="width:70px" scope="row">상세주소<span class="font_red">*</span></th>
							<td colspan="4"><input type="text" v-ref="dtl_add" name="dtl_add" id="dtl_add" size="100" v-model="dtl_add"/></td>
						</tr>
						<tr id="outstaff_account"  v-show="outflag">
							<th scope="row" style="width:70px">계좌번호<span class="font_red">*</span></th>
							<td colspan="2">
								<input type="text" name="account" id="account" size="30" v-model="account"/>
							</td>
							
							<th scope="row">은행명<span class="font_red">*</span></th>
							<td>
								<select id="checkbank" name="checkbank" style="width: 80px;" v-model="checkbank">
									 <option value="">선택 </option>
									 <option value="cityB">씨티은행 </option>
									 <option value="hanaB">하나은행 </option>
									 <option value="ibkB">기업은행</option>
									 <option value="kakaoB">카카오뱅크 </option>
									 <option value="kB">국민은행</option>
									 <option value="nhB">농협 </option>
									 <option value="shinhanB">신한은행 </option>
									 <option value="uriB">우리은행</option>
								</select>
							</td>
						</tr>
					</tbody>
					
				</table>
				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnUpdateUser" name="btn" v-show="delflag" :disabled="idcheck"><span>수정</span></a>
					<a href="" class="btnType blue" id="btnSaveUser" name="btn" v-show="!delflag"><span>등록</span></a>			
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
		    </dd>
          </dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
     </div>

</form>
</body>
</html>
