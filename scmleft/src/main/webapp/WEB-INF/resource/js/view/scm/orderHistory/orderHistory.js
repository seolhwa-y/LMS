	let listCount = 10;
	let pageCount = 10;
	
	// 수주리스트 조회
	function getOrderList(pageNum) {
		let currentPage = pageNum || 1;
		let pageLine = document.querySelector("#orderHistoryPaging");
		let stDate = document.getElementById("inpStartDate").value.replaceAll("-", ""), edDate = document.getElementById("inpEndDate").value.replaceAll("-", "");
		let reInput = document.getElementsByName("returnType"), reType = null, dateType = null;
		
		if((edDate - stDate) < 0) return swal("날짜를 다시 선택하세요.");
		if(stDate != "") dateType = document.getElementById("selClass").value;
		
		reInput.forEach((reInput) => { if (reInput.checked) reType = reInput.value; });

		let param = {  pageNum : currentPage, listCount : listCount, type : dateType, startDate : stDate, endDate : edDate, reType : reType }
		let callafterback = (ajax) => { 
			makeOHTable(ajax.newOrderSearchList); 
				
			pageLine.innerHTML = getPaginationHtml(currentPage, ajax.historyCount, listCount, pageCount, 'getOrderList');
		    pageLine.appendChild( createInput("historyCount", ajax.historyCount));
		}
		callAjax("/scm/searchOrderHistoryList", "post", "json", true, param, callafterback);
	}
	
	// 지시서 작성하기
	function showDirection(ty, jCode, mCode, jIn) {
		if(ty == "s" && jIn != 1) return swal("미입금 상태라 배송지시서 작성이 불가능 합니다."); 
		
		if (ty != null && jCode != null && mCode != null) {
			let param = { type : ty, jordCode : jCode, modelCode : mCode }
			let callafterback = (ajax) => { callDirectionList(ajax); }
			callAjax("/scm/showDirection", "post", "json", true, param, callafterback);
		} else return;
		
	}
	
	// 지시서 내용 리스트 정리
	function callDirectionList(ajax) {
		const type = ajax.type;
		
		switch(type) {
		case "b" :
			removeDetail('b');
			makeBorderInfo(ajax.bordInfo);
			fillDirectionModal(makeWhSelect(ajax.whInfo));
			gfModalPop("#bDirection");
			break;
			
		case "s" :	
			removeDetail('s');
			makeShipInfo(ajax.shipInfo);
			fillDirectionModal(makeWhSelect(ajax.whInfo), makeDeliSelect(ajax.deliInfo));
			gfModalPop("#sDirection");
			break;
		}
	}
	
	// 창고선택
	function inTotalStock(val){
		let data = val.split("&");
		let stock = document.querySelectorAll(".totalStock"), amt = document.querySelectorAll(".countAmt");
	
		stock.forEach((stock, index) => { stock.value = data[1]; })
	}
	
	// 항목 추가
	function appendDetail(type) {
		let bName = ["jordCode_B", "modelCode_B", "pdName_B", "pdCode_B", "bCorp_B"], 
			sName = ["jordCode_S", "modelCode_S", "companyName_S", "pdName_S", "pdCode_S"];
	 	let borderWhCode = document.querySelector("#selBWInfo").value, shipWhCode = document.querySelector("#selSWInfo").value;
		let bAmt = document.querySelector("#bAmt").value, sAmt = document.querySelector("#sAmt").value; 
		let data = [];
		
		switch (type) {
		case 'b' : 
			if(borderWhCode == "창고선택") return swal("창고를 선택하세요.");
			if(bAmt == "") return swal("수량을 입력하세요.");
			if(document.querySelector("#detailBorder").childNodes.length > 0) return swal("하나의 지시서만 등록이 가능합니다. \n올바른 내용을 작성하여 추가해주세요.");
	
		 	bName.forEach((bName, index) => {
				data.push(document.getElementById(bName).innerText);
			})
			
			data.push(borderWhCode.substring(0, borderWhCode.indexOf("&"))); // 창고번호
			data.push(borderWhCode.substring(borderWhCode.lastIndexOf("&") + 1)); // 창고이름
		 	data.push(bAmt); // 수량
		 	
			makeDetailDirect(type, data, bAmt); 
			break;
			
		case 's' :
			if(shipWhCode == "창고선택") return swal("창고를 선택하세요.");
			if(sAmt == "") return swal("수량을 입력하세요.");
			if(document.querySelector("#detailShip").childNodes.length > 0) return swal("하나의 지시서만 등록이 가능합니다. \n올바른 내용을 작성하여 추가해주세요.");
			
			sName.forEach((sName, index) => {
				data.push(document.getElementById(sName).innerText);
			})
			
			data.push(shipWhCode.substring(0, shipWhCode.indexOf("&"))); // 창고번호
			data.push(shipWhCode.substring(shipWhCode.lastIndexOf("&") + 1)); // 창고이름
		 	data.push(sAmt); // 수량
		 	
			makeDetailDirect(type, data, sAmt);
			break;
			
		default:
			break;
		}
	}
	
	// 디테일 테이블  :: 배열데이터, 창고정보, 수량
	function makeDetailDirect(type, data, amt) {
		let dB = document.querySelector("#detailBorder"), dS = document.querySelector("#detailShip");
		let tr = document.createElement("tr");
		const deli = document.querySelector("#deli").innerText;
		
		switch (type) {
		case "b":
			data.forEach((data, index) => {
				tr.appendChild(makeTable(data));
	        })
	        
	      	tr.appendChild(makeTable("<a class='btnType gray' id='btnRemove' name='btn' onClick = 'removeDetail(\"b\")'><span>삭제</span></a>"))
	        dB.appendChild(tr);
			break;

		case "s" :
			data.forEach((data, index) => {
				tr.appendChild(makeTable(data));
	        })
	        
	        tr.appendChild(makeTable(deli));
	        tr.appendChild(makeTable("<a class='btnType gray' id='btnRemove' name='btn' onClick = 'removeDetail(\"s\")'><span>삭제</span></a>"))
	        dS.appendChild(tr);
			break;
		default: break;
		}

	}

	// 항목 삭제 
	function removeDetail(type) {
		switch(type) {
			case 'b' : document.querySelector("#detailBorder").innerHTML = ""; break; 
			case 's' : document.querySelector("#detailShip").innerHTML = ""; break;
		}
	}
	
	// 발주지시서 작성완료
	function insBordDirec() {
		let text = document.querySelector("#detailBorder").childNodes[0].childNodes; 
		let value = [];
		
		text.forEach((text, index) => { if(index < 8) value.push(text.innerText); })

		let param = { jordCode : value[0], modelCode : value[1], companyName : value[4], whCode : value[5], jordAmt : value[7] }
		let callafterback = (ajax) => {
			let pageLine = document.querySelector("#orderHistoryPaging");
			
			gfCloseModal();
			makeOHTable(ajax.orderHistoryList);
			pageLine.innerHTML = getPaginationHtml(1, ajax.historyCount, listCount, pageCount, 'getOrderList');
	       	pageLine.appendChild( createInput("historyCount", ajax.historyCount));
	       	
	       	swal(ajax.message);
		}
		callAjax("/scm/insertBorderDirection", "post", "json", true, param, callafterback);
	}
	
	// 배송지시서 작성완료
	function insShipDirec() {
		let text = document.querySelector("#detailShip").childNodes[0].childNodes; 
		let value = [];
		
		if(text[8].childNodes[0].value == "배송담당자 선택") return swal("배송담당자를 선택하세요.");
		
		text.forEach((text, index) => { 
			if(index < 8) value.push(text.innerText); 
			if(index == 8) value.push(text.childNodes[0].value.substring(0, text.childNodes[0].value.indexOf("&")));
		})
		
		if(value[7] != document.querySelector("#jordAmt_S").innerText) return swal("주문수량과 같지 않습니다. \n모든 창고에 재고가 부족하다면 발주지시서부터 작성하세요.");
		
		let param = { jordCode : value[0], companyName : value[1], modelCode : value[2], whCode : value[5], jordAmt : value[7], deliID : value[8] }
		let callafterback = (ajax) => {
			let pageLine = document.querySelector("#orderHistoryPaging");
			
			gfCloseModal();
			makeOHTable(ajax.orderHistoryList);
			pageLine.innerHTML = getPaginationHtml(1, ajax.historyCount, listCount, pageCount, 'getOrderList');
	       	pageLine.appendChild( createInput("historyCount", ajax.historyCount));
	       	
	       	swal(ajax.message);
		}
		callAjax("/scm/insertShipDirection", "post", "json", true, param, callafterback);
	}

	// 모달 내용 채우기
	function fillDirectionModal (wh, deli) {
		let selBW = document.getElementById("selBWInfo"), selSW = document.getElementById("selSWInfo");
		let stock = document.querySelectorAll(".totalStock"), amt = document.querySelectorAll(".countAmt");
		
		stock.forEach((stock, index) => {
			stock.value = "", amt[index].value = "";
		})
	
		if(deli != null) {
			selSW.innerHTML = wh;
			document.querySelector("#deli").innerText = deli;
		} else selBW.innerHTML = wh;
	}
	
	// 발주지시서 정보 넣기
	function makeBorderInfo (list, direc) {
		let name = ['#jordCode_B', '#modelCode_B', '#pdName_B', '#pdCode_B', '#bCorp_B'];
		let value = [list.jordCode, list.modelCode, list.pdName, list.pdCode, list.companyName, list.jordAmt];
		
		name.forEach((name, index) => {
			document.querySelector(name).innerText = value[index];
		})
	}
	
	// 배송지시서 정보 넣기
	function makeShipInfo (list) {
		let name = ['#jordCode_S', '#jordDate_S', '#companyName_S',  '#modelCode_S', '#pdName_S', '#pdCode_S', '#jordAmt_S'];
		let value = [list.jordCode, cngDateType(list.jordDate), list.modelCode, list.companyName, list.pdName, list.pdCode, list.jordAmt];
		
		name.forEach((name, index) => {
			document.querySelector(name).innerText = value[index];
		})
	}
	
	// 창고정보 셀렉트
	function makeWhSelect (list) {
		let selectBox = "<option selected disabled>창고선택</option>";

		if(list.length != 0){
			list.forEach((list, index) => { selectBox += "<option value = '" + list.whCode + "&" + list.whStock + "&" + list.whName + "'>" + list.whName + "</option>"; })
		} else selectBox += "<option disabled>선택할 수 있는 창고가 없습니다.</option>";

		return selectBox;
	}
	
	// 배송담당자 정보 셀렉트
	function makeDeliSelect (list) {
		let selectBox = "<select id = 'selDeliInfo'><option disabled selected>배송담당자 선택</option>";

		if(list.length != 0){
			list.forEach((list, index) => { selectBox += "<option value = '" + list.loginId + "&" + list.deliName + "'>" + list.deliName + "</option>"; })
		} else selectBox += "<option disabled>선택할 수 있는 배송담당자가 없습니다.</option>";
		
		selectBox += "</select>";
		
		return selectBox;
	}
	
	// 일별수주내역 테이블 그리기
	function makeOHTable(list) {
		let tbody = document.getElementById("orderHistoryTBody");
		let content = "";

		tbody.innerHTML = "";
		
		if(list.length > 0) {
			list.forEach((list, index) => {
				content += "<tr><td>" + list.jordCode + "</td>" 
				+ "<td>" + cngDateType(list.jordDate) + "</td>" 
				+ "<td>" + list.companyName + "</td>" 
				+ "<td>" + list.pdName + "</td>" 
				+ "<td>" + cngNumberType(list.whStock) + "</td>"
				+ "<td>" + cngNumberType(list.pdPrice) + "</td>" 
				+ "<td>" + cngNumberType(list.jordAmt) + "</td>"
				+ "<td>" + cngNumberType(list.totalAmt) + "</td>";
	
			list.reDate != null? content += "<td>Y</td><td>" + cngDateType(list.reDate) + "</td>" : content += "<td>N</td><td></td>";
			list.jordIn == "0" ? content += "<td>미입금</td>" : content += "<td>입금</td>";
			list.bordCode != "0" ? content += "<td>작성완료</td>"
								 : content += "<td><a id = 'btnBordDirec' class = 'btnType blue' onClick = 'showDirection(\"b\", " 
										   + list.jordCode + "," + list.modelCode + ")'><span>작성</span></a></td>";
			list.shCode != "0" ? content += "<td>작성완료</td>"
							   : content += "<td><a id = 'btnShipDirec' class = 'btnType blue' onClick = 'showDirection(\"s\", " 
									     + list.jordCode + "," + list.modelCode + "," + list.jordIn + ")'><span>작성</span></a></td>";
			})
		} else content += "<tr><td colspan = '12'>조회된 수주내역이 없습니다.</td></tr>";

		tbody.innerHTML = content;
	}

	// 타입 변환 :: 스트링 -> 날짜
	function cngDateType(strDate) {
		return strDate.substr(0, 4) + "-" + strDate.substr(4, 2) + "-" + strDate.substr(6, 2);
	}
	
	// 금액 콤마
	function cngNumberType(num) {
		return num.toLocaleString('ko-KR');
	}
	
	// <input type = 'hidden' /> 
	function createInput(id, value) {
		let input = document.createElement("input");
		
		input.setAttribute("type", "hidden");
		input.setAttribute("id", id);
		input.setAttribute("value", value);	
		
		return input;
	}
	
	// <td> value </td>
    function makeTable (value) {
        let td = document.createElement("td");

        td.innerHTML = value;
        
        return td;
    }
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
			switch (btnId) {
			case 'btnBModalClose' : 
			case 'btnSModalClose' : gfCloseModal(); break;
			case 'btnBorderDirec' : insBordDirec(); break;
			case 'btnShipDirec' : insShipDirec(); break;
			case 'btnBDirec' :
			case 'btnSDirec' : appendDetail(); break;
			
			default : getOrderList(); break;
			}
		});
	}