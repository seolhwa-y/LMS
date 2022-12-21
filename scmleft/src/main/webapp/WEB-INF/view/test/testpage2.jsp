<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>TestPage2</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
                              
<script type="text/javascript">
    
    $(document).ready(function() {
    	
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
								class="btn_nav bold">Sample</span> <span class="btn_nav bold">TestPage2
								</span> <a href="/test/TestPage2.do" class="btn_set refresh">새로고침</a>
						</p>
						<br>   <b>두가지중 최소 한개 제출</b>
						<br>   <b>첫번째.</b>
                        <br>   <b>목록  그리드 항목은 접수번호, 신고인 성명   클릭 시 아래 폼  형태로 팝업 (gfModalPop("#layer1");  div id가 "layer1" 팝업 처리)</b>
                        <br>   <b>그리드 Data는 Json 임의 형태로 작성</b>                        
                        <br>   <b>아래 그림 폼을 그림 아래에 VueJS로 구현 ( 접수번호, 접수일자(달력) 은 입력 항목 ) </b>
                        <br>   <b>저장 버튼을 아래에 두고, 클릭시 입력항목 값 alert 처리</b>
                         <br>   <b>두번째.</b>
                         <br>   <b>동일한 방법으로 공통코드 그룹코드 부분만 작성</b>
                         <br>   <b><a href="/sample/comnCodMgr.do"  target="_blank">공통코드</a>  </b>
                         
                         
                         <br> <img src="/images/question.png" style="width: 400px; height: 500px;" alt="사진" />

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