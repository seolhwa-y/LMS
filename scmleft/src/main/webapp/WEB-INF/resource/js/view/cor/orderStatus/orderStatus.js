	let listCount = 5;
	let pageCount = 10;
	
	// 주문현황 조회
	function getOrderStatusList(pageNum) {
		let currentPage = pageNum || 1;
		let pageLine = document.querySelector("#orderStatusPaging");
		let stDate = document.getElementById("inpStartDate").value.replaceAll("-", "");
		let edDate = document.getElementById("inpEndDate").value.replaceAll("-", "");
	
		if((edDate - stDate) < 0) return swal("날짜를 다시 선택하세요.");

		let param = { pageNum : currentPage, listCount : listCount, startDate : stDate, endDate : edDate }
		let callafterback = (ajax) => { 
			makeOrderList(ajax.newOrder); 
			
			pageLine.innerHTML = getPaginationHtml(currentPage, ajax.orderCount, listCount, pageCount, 'getOrderStatusList');
	        pageLine.appendChild(createInput("orderCount", ajax.orderCount));
		}
		
		callAjax("/cor/searchOrderList", "post", "json", true, param, callafterback);	
	}

	// 주문내역에서 상세 제품정보 불러오기
	function getDetailList(pageNum, no, sh, jIn) {
		let currentPage = pageNum || 1;
		let pageLine = document.querySelector("#orderDetailPaging");
		let jNo = (no != null ? no : document.querySelector("#jordNo").value);
		
 		if(jIn == "0") return swal("아직 입금을 하지 않아서 조회가 불가능합니다.");
		if(sh == undefined) return swal("아직 배송이 진행되지 않았습니다."); 

		let param = { pageNum : currentPage, listCount : listCount, jordNo : jNo } 			
		let callafterback = (ajax) => { 
			makeOrderDetailList(ajax.osdList);

			pageLine.innerHTML = getPaginationHtml(currentPage, ajax.detailCount, listCount, pageCount, 'getDetailList');
	       	pageLine.appendChild( createInput("detailCount", ajax.detailCount));
	       	pageLine.appendChild( createInput("jordNo", ajax.jordNo));
		}
		
		callAjax("/cor/refundHistory", "post", "json", true, param, callafterback);
	}
	
	// 입금하기 목록 가져오기
	function updJordIn(no, pageNum) {
		let currentPage = pageNum || 1;
		let pageLine = document.querySelector("#orderStatusPaging");
		let param = { pageNum : currentPage, listCount : listCount, jordNo : no, jordIn : "1" }
		let callafterback = (ajax) => { 
			makeOrderList(ajax.newOsList);
			
			pageLine.innerHTML = getPaginationHtml(currentPage, ajax.orderCount, listCount, pageCount, 'getOrderStatusList');
	        pageLine.appendChild(createInput("orderCount", ajax.orderCount));
	        
			swal(ajax.message);
		}
			
		callAjax("/cor/updJorderStatus", "post", "json", true, param, callafterback);	
	}
	
	// 반품하기
	function insReturnInfo(pageNum) {		
		let currentPage = pageNum || 1;
		let pageLine = document.querySelector("#orderDetailPaging");
		let jNo = document.querySelector("#jordNo").value;
		let checkBox = document.querySelectorAll("input[name='cheReturn']:checked");
		let b = [], jCode = "", mCode = "", wCode = "", bCode = "", rAmt = "";
		
		checkBox.forEach((checkBox) => {
			b.push(checkBox.value.split("&"));
		})
		
		b.forEach((b, index) => {
			jCode += (index != 0 ? "&" : "") + b[0];
			mCode += (index != 0 ? "&" : "") + b[1];
			wCode += (index != 0 ? "&" : "") + b[2];
			bCode += (index != 0 ? "&" : "") + b[3];
			rAmt += (index != 0 ? "&" : "") + b[4];
		})
		
		if(jCode != null && mCode != null) {			
			let param = { pageNum : currentPage, listCount : listCount, jordCode : jCode, jordNo : jNo, modelCode : mCode, whCode : wCode, bordCode : bCode, reAmt : rAmt}
			console.log(param);
			let callafterback = (ajax) => { 
				makeOrderDetailList(ajax.osdList);
				
				pageLine.innerHTML = getPaginationHtml(currentPage, ajax.detailCount, listCount, pageCount, 'getDetailList');
		       	pageLine.appendChild( createInput("detailCount", ajax.detailCount));
		       	pageLine.appendChild( createInput("jordNo", ajax.jordNo));
				
				swal(ajax.message);
			}
			
			callAjax("/cor/insReturnProduct", "post", "json", true, param, callafterback);	
		} else return;
	}

	
	// 주문내역 테이블 그리기 + 페이징
	function makeOrderList(list){
		let tbody = document.getElementById("orderStatusTBody");
		let content = "";
		
		tbody.innerHTML = "";
		if(list.length > 0){
			list.forEach((list, index) => {
				content += "<tr><td>"+ list.jordNo + "</td>"
						+ "<td><a id='detail' onClick = 'getDetailList(1, " + list.jordNo + ", " + list.shDate + ", " + list.jordIn + ")' >" 
						+ "<span>" + (list.pdName + (list.count != "1" ? (" 외 " + (list.count - 1) + "개") : "")) + "</span></a></td>"
						+ "<td>" + cngNumberType(list.total) + "</td>"
						+ "<td>" + cngDateType(list.jordDate) + "</td>"
						+ "<td>" + (list.shDate != null ? cngDateType(list.shDate) : "") + "</td>";
				if(list.jordIn == "0") {
					content += "<td>" + "<a class='btnType blue' id='btnIn' name='btn' onClick = 'updJordIn(" + list.jordNo + ")'><span>입금하기</span></a>"  + "</td>";
				} else content += "<td></td></tr>";
			})

		} else content += "<tr><td colspan = '6'>조회된 주문현황 내역이 없습니다.</td></tr>";
	
		tbody.innerHTML = content;
	}
	
	// 주문 상세 내역 테이블 그리기
	function makeOrderDetailList(list) {
		let tbody = document.getElementById("detailOrderStatusTBody");
		let content = "";
		
		tbody.innerHTML = "";
		if(list.length > 0) {
			list.forEach((list, index) => {
				content += "<tr><td><input type = 'checkBox' name = 'cheReturn' value = '" + list.jordCode + "&" + list.modelCode + "&" 
						+ list.whCode + "&" + list.bordCode + "&" + list.jordAmt + "' " 
						+ ((list.shType == "1" ? "" : "disabled") || (list.reCode == "0" ? "" : "disabled")) + "/ ></td>"
						+ "<td>" + list.jordNo + "</td>"
						+ "<td>" + list.pdName + "</td>"
						+ "<td>" + list.pdCode + "</td>"
						+ "<td>" + list.pdCorp + "</td>"
						+ "<td>" + cngNumberType(list.pdPrice)  + "</td>"
						+ "<td>" + cngNumberType(list.jordAmt) + "</td>"
						+ "<td>" + cngNumberType(list.total) + "</td></tr>";
			})
			tbody.innerHTML = content;
		} 
	}
	
	// 타입 변환 :: 스트링 -> 날짜
	function cngDateType(strDate) {
		return strDate.substr(0, 4) + "-" + strDate.substr(4, 2) + "-" + strDate.substr(6, 2);
	}
	
	// 금액 콤마
	function cngNumberType(num) {
		return num.toLocaleString('ko-KR');
	}
	
	// 버튼 이벤트 등록
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
			switch (btnId) {
				case 'btnClose' : gfCloseModal(); break;
				case 'btnReturn' : insReturnInfo(); break;
				case 'detail' : getgetDetailList(); break;
			}
		});
	}
	
	// <input type = 'hidden' /> 
	function createInput(id, value) {
		let input = document.createElement("input");
		
		input.setAttribute("type", "hidden");
		input.setAttribute("id", id);
		input.setAttribute("value", value);	
		
		return input;
	}