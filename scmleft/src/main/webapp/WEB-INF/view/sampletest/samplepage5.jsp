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
    
   //vue instance위한 변수선언
   var form;
   var form2;
   var imgpath; 
   
    $(document).ready(function() {
       init();
   });

    function init(){
       
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
              ,onSelect: function(d){self.$emit('update-date',d)} //emit : 이벤트 핸들링(이벤트를 내보냄)
            });
          },
             beforeDestroy: function(){$(this.$el).datepicker('hide').datepicker('destroy')} //this.$el하면, 뷰인스턴스자체에 접근하여 요소들을 컨트롤가능
           });
     
       
       
       
            form= new Vue({
                          el: '#inputform',
                          data: {
                                loginId : "",
                                passwd : "",
                                coname : "",
                                emailid : "",
                                emaildom : "",
                                emailcop : "daum.net",
                                name : "",
                                birth : "",
                                tel1 : "010",
                                tel2 : "",
                                tel3 : "",
                                note : "",
                                gender: "male",
                                grade : "beginner",
                                location : "locAll",
                                    //,listitem:[]
                                telnums: [
                                         {value:"010", text:"010"},
                                         {value:"011", text:"011"},
                                          {value:"019", text:"019"},
                                          {value:"018", text:"018"}
                                           ],
                                    emaillistcop: [//data에 넣어놓고 루프돌릴것
                                          {value:"daum.net", text:"다음"},
                                           {value:"google.com", text:"구글"},
                                           {value:"naver.com", text:"네이버"},
                                           {value:"", text:"직접입력"}
                                          ] ,
                                 checkedDiv :[] ,
                                 locationlist :[
                                                {value:"locAll", text:"지역전체"},
                                                {value:"seoul", text:"서울"},
                                                {value:"busan", text:"부산"},
                                                {value:"incheon", text:"인천"},
                                                {value:"gwangju", text:"광주"},
                                                {value:"daegu", text:"대구"}
                                                ],
                                  gradelist:[
                                                {value:"beginner", text:"초급"},
                                                {value:"intermediate", text:"중급"},
                                                {value:"expert", text:"고급"},
                                                {value:"master", text:"특급"}
                                             ],
                                  prtcpateTypeList: [
                                                {value:"SI", text:"SI(상주프로젝트)"},
                                              {value:"SM", text:"SM(상주프로젝트)"},
                                              {value:"solution", text:"솔루션개발"}     
                                                     
                                                     
                                             ] 
                                          
                                }
                                    ,
                             methods:{               
                           updateDate: function(d) {
                                   this.date = d; //바뀐 날짜가 들어가도록.
                            } ,
                            
                            emailchange : function(d) {
                                   this.emaildom = this.emailcop; //선택된 값이 도메인에 들어가도록
                            }
              } 
           
         });      
            
            
            form2= new Vue({
               el: '#historyForm',
               data: {
                     loginId : "",
                     passwd : "",
                     coname : "",
                     emailid : "",
                     emaildom : "",
                     emailcop : "daum.net",
                     name : "",
                     birth : "",
                     tel1 : "010",
                     tel2 : "",
                     tel3 : "",
                     note : "",
                     gender: "male",
                     grade : "beginner",
                     title : "",
                     loc1 : "locAll",
                     loc2 : "locAll",
                     loc3 : "locAll",
                     hpSalary : "",
                     addTech : "",
                     extranote :"",
                     historynote:"",
                     workYear : "1",
                     workMonth: "1",
                        //,listitem:[]
                     imgpath:  "",
                     telnums: [
                                {value:"010", text:"010"},
                                {value:"011", text:"011"},
                                 {value:"019", text:"019"},
                                 {value:"018", text:"018"}
                                  ],
                           emaillistcop: [//data에 넣어놓고 루프돌릴것
                                 {value:"daum.net", text:"다음"},
                                  {value:"google.com", text:"구글"},
                                  {value:"naver.com", text:"네이버"},
                                  {value:"", text:"직접입력"}
                                 ] ,
                        chkNegoYn :[] ,
                        loclist1 :    [
                                       {value:"locAll", text:"지역전체"},
                                       {value:"seoul", text:"서울"},
                                       {value:"busan", text:"부산"},
                                       {value:"incheon", text:"인천"},
                                       {value:"gwangju", text:"광주"},
                                       {value:"daegu", text:"대구"}
                                       ],
                         loclist2 :    [
                                     {value:"locAll", text:"지역전체"},
                                     {value:"seoul", text:"서울"},
                                     {value:"busan", text:"부산"},
                                     {value:"incheon", text:"인천"},
                                     {value:"gwangju", text:"광주"},
                                     {value:"daegu", text:"대구"}
                                    ],    
                         loclist3 :    [
                                     {value:"locAll", text:"지역전체"},
                                     {value:"seoul", text:"서울"},
                                     {value:"busan", text:"부산"},
                                     {value:"incheon", text:"인천"},
                                     {value:"gwangju", text:"광주"},
                                     {value:"daegu", text:"대구"}
                                         ],      
                         yearlist :    [
                                    {value:"1", text:"1"},
                                    {value:"2", text:"2"},
                                    {value:"3", text:"3"},
                                    {value:"4", text:"4"},
                                    {value:"5", text:"5"},
                                    {value:"6", text:"6"},
                                    {value:"7", text:"7"},
                                    {value:"8", text:"8"},
                                    {value:"9", text:"9"},
                                    {value:"10", text:"10"},
                                    {value:"11", text:"11"},
                                    {value:"12", text:"12"},
                                    {value:"13", text:"13"},
                                    {value:"14", text:"14"},
                                    {value:"15", text:"15"},
                                    {value:"16", text:"16"},
                                    {value:"17", text:"17"},
                                    {value:"18", text:"18"},
                                    {value:"19", text:"19"},
                                    {value:"20", text:"20"},
                                    {value:"20over", text:"20 Over"}
                                     ],
                        monthlist :    [
                                           {value:"1", text:"1"},
                                        {value:"2", text:"2"},
                                       {value:"3", text:"3"},
                                       {value:"4", text:"4"},
                                       {value:"5", text:"5"},
                                       {value:"6", text:"6"},
                                       {value:"7", text:"7"},
                                       {value:"8", text:"8"},
                                       {value:"9", text:"9"},
                                       {value:"10", text:"10"},
                                       {value:"11", text:"11"},
                                       {value:"12", text:"12"}
                                         ],
                         checkedProTech  : []   ,
                         frmwrkList :   [
                                            {value:"Spring", text:"Spring"},
                                          {value:"eGov"  , text:"eGov"},
                                         {value:"Struts" , text:"Struts"},
                                         {value:"jQuery", text:"jQuery"},                                 
                                       ]
                         
                      }
                      ,
                methods:{               
                  updateDate: function(d) {
                         this.date = d; //바뀐 날짜가 들어가도록.
                  } ,
                  
                  emailchange : function(d) {
                         this.emaildom = this.emailcop; //선택된 값이 도메인에 들어가도록
                  },
                  
                  profileUpldMthd : function(e){
                      var image = e.target; 
                       
                       if(image.files[0]){
                          this.imgpath =  "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fthumb2.gettyimageskorea.com%2Fimage_preview%2F700%2F201112%2FFKO%2F133955590.jpg&type=sc960_832";
                           alert("예쁜 해바라기입니다.");
                       }
                    } // profileUpldMthd end  
                    
              
               } ,  // methods end    
               
               components:{
                                    'my-chkbox-test':{
                                                       props:['msg'], // msg를 option으로 잡는다면 어떻게될까?
                                                      template : "<input type='checkbox'  :id='option.value'  :name='option.value'  :value='option.value'  v-model='checkedProTech'> <label>{{msg}}</label>"
                                                             
                                      //  '<div>지역 컴포넌트 {{ msg }} </div>'
                                    }
                       }//components end
    
                   
               
     

       });      // instance end
            
       
       
    }//whole init function end

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

                        <br> <h1>기본정보</h1>
                         <div id="inputform">
                           <table class="row">         
                     <caption>caption</caption>
                        <colgroup>
                                    <col width="10%">
                                    <col width="30%">
                                    <col width="10%">
                                    <col width="20%">
                                    <col width="10%">
                                    <col width="20%">
                             </colgroup>

               <tbody>
                  <tr>
                     <th scope="row">아이디 <span class="font_red">*</span></th>
                     <td><input type="text" class="inputTxt p100" name="loginId" id="loginId" v-model="loginId"  /></td>
                     <th scope="row">비밀번호<span class="font_red">*</span></th>
                     <td colspan=3><input type="text" class="inputTxt p100" name="passwd" id="passwd" v-model="passwd" /></td>
                  </tr>
                  
                  <tr>
                     <th scope="row">성명 <span class="font_red">*</span></th>
                     <td><input type="text" class="inputTxt p100" name="coname" id="coname" v-model="coname"  /></td>
                     <th scope="row">이메일<span class="font_red">*</span></th>
                     <td>
                     <input type="text" class="inputTxt p100" name="emailid" id="emailid" v-model="emailid" />@
                     <input type="text" class="inputTxt p100" name="emaildom" id="emaildom" v-model="emaildom" />
                     <select id="emailcop" name="emailcop" v-model="emailcop" @change="emailchange" >
                          <option v-for="option in emaillistcop" v-bind:value="option.value">
                               {{ option.text }}
                         </option> 
                         <!--  
                         <option value="daum" >다음</option>
                         <option value="google">구글</option>
                         <option value="naver">네이버</option>
                         <option value="userDef">직접입력</option>-->
                     </select>
                     </td>
                     <th scope="row">성별 <span class="font_red">*</span></th>
                     <td>
                     <select id="gender" name="gender" v-model="gender" >
                         <!--  <option v-for="option in emaillistcop" v-bind:value="option.value">
                               {{ option.text }}
                         </option> -->
                         <option value="male" >남</option>
                         <option value="female">여</option>
                     </select>
                     </td>
                  </tr>
                  
                  <tr>
                     <th scope="row">등급 <span class="font_red">*</span></th>
                     <td>
                     <select id="grade" name="grade" v-model="grade" >
                           <option v-for="option in gradelist" v-bind:value="option.value">
                               {{ option.text }}
                         </option> 
                     </select>
                     </td>
                     
                     <th scope="row">참여구분 <span class="font_red">*</span></th>
                     <td colspan=3>
                     
                          <template v-for="option in prtcpateTypeList"  >
                               <input type="checkbox"  :id="option.value"  :value="option.value" v-model="checkedDiv">
                                 <label for ="option.value">{{ option.text }}</label>
                         </template> 
                           
                           <!--    
                        <input type="checkbox" id="SI" value="SI" v-model="checkedDiv">
                                <label for="SI">SI(상주프로젝트)</label>
                        <input type="checkbox" id="SM" value="SM" v-model="checkedDiv">
                                <label for="SM">SM(상주프로젝트)</label>
                        <input type="checkbox" id="Sol" value="Sol" v-model="checkedDiv">
                                <label for="Sol">솔루션개발</label>                
                      -->         
                     </td>
                  </tr>
                  
                  
                  
                  
                  <tr>
                     <th scope="row">생년월일 <span class="font_red">*</span></th>
                     <td>
                      <datepicker @update-date="updateDate" style="width: 100px; height: 25px;"></datepicker>
                     <input type="text" class="inputTxt p100" name="birth" id="birth" v-model="birth"  /></td>
                     
                     <th scope="row">거주지역<span class="font_red">*</span></th>
                     <td>
                       <select id="location" name="location" v-model="location" >
                          <option v-for="option in locationlist" v-bind:value="option.value">
                               {{ option.text }}
                         </option> 
                       </select> 
                     </td>
                                          
                     <th scope="row">연락처<span class="font_red">*</span></th>
                     <td>
                        <select id="tel1" name="tel1" v-model="tel1">
                           <option v-for="option in telnums" v-bind:value="option.value">
                               {{ option.text }}
                          </option>
                            <!--  <option value="010" >010</option>
                            <option value="011">011</option>
                            <option value="018">018</option>
                            <option value="019">019</option> -->
                        </select>
                        <input type="text" class="inputTxt p100" name="tel2" id="tel2" v-model="tel2" />
                         <input type="text" class="inputTxt p100" name="tel3" id="tel3" v-model="tel3" />
                     </td>
                  </tr>
                  
               </tbody>
            </table>
            </div> <!-- form 1영역 -->     
                         
                <br> <h1>경력정보 </h1>       
                  <div id="historyForm">
                  <table class="row">         
                     <caption>caption</caption>
                        <colgroup>
                                    <col width="20%">
                                    <col width="30%">
                                    <col width="20%">
                                    <col width="30%">
                             </colgroup>

               <tbody>
                  <tr>
                     <th scope="row">제목 <span class="font_red">*</span></th>
                     <td colspan=3><input type="text" class="inputTxt p100" name="title" id="title" v-model="title"  /></td>
                  </tr>
                  
                  <tr>
                     <th scope="row">희망근무<span class="font_red">*</span></th>
                     <td>
                     <select id="loc1" name="loc1" v-model="loc1" >
                         <option v-for="option in loclist1" v-bind:value="option.value">
                               {{ option.text }}
                         </option> 
                     </select>
                     <select id="loc2" name="loc2" v-model="loc2" >
                          <option v-for="option in loclist2" v-bind:value="option.value">
                               {{ option.text }}
                         </option> 
                     </select>
                     <select id="loc3" name="loc3" v-model="loc3" >
                          <option v-for="option in loclist3" v-bind:value="option.value">
                               {{ option.text }}
                         </option> 
                     </select>
                     </td>
                     <th scope="row">희망연봉<span class="font_red">*</span></th>
                     <td>
                     <input type="text" class="inputTxt p100" name="hpSalary" id="hpSalary" v-model="hpSalary" />만원
                     <input type="checkbox" id="negoYn" value="negoYn" v-model="chkNegoYn">
                                <label for="negoYn">협의가능</label>
                     </td>
                  </tr>
                  
                  <tr>
                     <th scope="row">경력기간<span class="font_red">*</span></th>
                     <td colspan=3>
                     <select id="workYear" name="workYear" v-model="workYear" >
                           <option v-for="option in yearlist" v-bind:value="option.value">
                               {{ option.text }}
                         </option> 
                     </select> 년 
                     <select id="workMonth" name="workMonth" v-model="workMonth" >
                           <option v-for="option in monthlist" v-bind:value="option.value">
                               {{ option.text }}
                         </option> 
                     </select> 월
                     </td>
                  </tr>
                  
                  <tr>
                     <th scope="row">전문기술<span class="font_red">*</span></th>
                     <td colspan=3>
                      
                      <template v-for = "option in frmwrkList">
                          <my-chkbox-test :msg= "option.text"></my-chkbox-test>
                      </template>
                      <!-- 
                        <template v-for ="option in frmwrkList">
                             <input type="checkbox"  :id="option.value"  :name="option.value"  :value="option.value"  v-model="checkedProTech">
                             <label for="option.value">{{option.text}}</label>
                        </template>
                        --> 
                     
                      <!-- 
                         <input type="checkbox" id="Spring" value="Spring" v-model="checkedProTech">
                                <label for="Spring">Spring</label>
                        <input type="checkbox" id="Jquery" value="Jquery" v-model="checkedProTech">
                                <label for="Jquery">Jquery</label>
                        <input type="checkbox" id="eGov" value="eGov" v-model="checkedProTech">
                                <label for="eGov">eGov</label>                
                          <input type="checkbox" id="Struts" value="Struts" v-model="checkedProTech">
                                <label for="Struts">Struts</label>
                      -->           
                     </td>
                  </tr>
                  
                  
                  <tr>
                     <th scope="row">추가기술<span class="font_red">*</span></th>
                     <td colspan=3>
                     <input type="text" class="inputTxt p100" name="addTech" id="addTech" v-model="addTech" />
                     </td>
                  </tr>
               
                   <tr>
                           <th scope="row">경력내용</th>
                              <td colspan="3">
                                 <textarea class="inputTxt p100" name="historynote" id="historynote" v-model="historynote" >
                                 </textarea>
                              </td>
                      </tr>
                      
                      <tr>
                           <th scope="row">특이사항</th>
                              <td colspan="3">
                                 <textarea class="inputTxt p100" name="extranote" id="extranote" v-model="extranote" >
                                 </textarea>
                              </td>
                      </tr>
                  
                  <tr>
                           <th scope="row">프로파일</th>
                              <td colspan="3">
                                 <input type="file" name="profileUpld"  id="profileUpld"   @change="profileUpldMthd" />
                                    <div>
                             <img v-bind:src="imgpath"> 
                           </div>      
                              </td>
                      </tr>                        
                     
                  
               </tbody>
            </table>
                  
                         
                         
             </div> <!-- form 2영역 -->          
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