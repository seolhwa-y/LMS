	// 버튼 :: 주문하기
	function confOrder() {
		confirm("입금도 같이 진행하시겠습니까?") == true ? insOrderInfo('1') : insOrderInfo('0');
	}
	
	function insOrderInfo(isCheck) {
		let checkBox = document.querySelectorAll("input[name='delProduct']:checked");
        let value = [], type = '0', model = "", amt = "", wish = "", jin = "";

        checkBox.forEach((checkBox, index) => { value.push(checkBox.value.split("&")); })
        value.forEach((value, index) => { 
        	value.push(isCheck); 
			model += (index == 0 ? "" : "&" ) + value[0];
			amt += (index == 0 ? "" : "&" ) + value[1];
			wish += (index == 0 ? "" : "&" ) + value[2];
			jin += (index == 0 ? "" : "&" ) + value[3];
		})
		
        if(model != null && amt != null && wish != null && jin != null) {
			let param = { modelCode : model, jordAmt : amt, jordWishdate : wish, jordIn : jin }
			let callafterback = (ajax) => { 
				makeBasketList(ajax.insBaList);
				document.querySelector("#basketTotal").innerText = ajax.basketTotal;
				alert(ajax.message);
			}
			
 			callAjax("/cor/insJorder", "post", "json", true, param, callafterback);	  
		} else return;  
	}
	
	// 제품 삭제
	function delBaProduct() {
		let checkBox = document.querySelectorAll("input[name='delProduct']:checked");
		let val = "";
		
		checkBox.forEach((checkBox, index) => {
			val += (index != 0 ? "&" : "") + checkBox.value.substring(0, checkBox.value.indexOf("&"));
		})

		if(val != null) {			
			let param = { modelCode : val }
			let callafterback = (ajax) => { 
				makeBasketList(ajax.delBaList);
				document.querySelector("#basketTotal").innerText = ajax.basketTotal;
				alert(ajax.message);
			}
			
			callAjax("/cor/delBasketProduct", "post", "json", true, param, callafterback);	
		} else return;
	}
	
	// 테이블 그리기
	function makeBasketList(list) {
		let tbody = document.getElementById("shoppingCartTBody");
		let content = "";
		tbody.innerHTML = "";
		
		for(i = 0; i < list.length; i++) {
			content += "<tr><td><input type = 'checkBox' name = 'delProduct' value = '" + list[i].modelCode + "&" + list[i].baAmt + "&" + list[i].baWishdate + "' /></td>"
					+ "<td>"+ list[i].pdName +"</td>"
					+ "<td>"+ cngNumberType(list[i].pdPrice) +"</td>"
					+ "<td>"+ list[i].baAmt +"</td>"
					+ "<td>"+ cngNumberType(list[i].total) +"</td>"
					+ "<td>"+ cngDateType(list[i].baWishdate) +"</td>";
		}
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
	
	// 버튼 이벤트 등록
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
			switch (btnId) {
				case 'btnClose' : gfCloseModal(); break;
				case 'btnDelProduct' : insReturnInfo(); break;
				case 'btnDelBasket' : delBaProduct(); break;
				case 'btnOrderMoney' : confOrder(); break;
			}
		});
	}