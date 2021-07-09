package com.tradeLog.db;

public class tradeLogDAO {

	// 생각해볼 것. 
	// buyer ==> 본인으로 바꾸고 (user_nick) 
	// seller ==> 돈을 지불하거나 주는 대상으로 ? (target)  
	
	
	
	
	// 충전시 동작하는 함수 
	// buyer (session에 저장된 user_nick)  
	// coin :  충전 금액을 기록  + member의 coin을 증가
	// type = 0 
	
	
	// 금액을 걸어놓을 때 동작하는 함수 
	// buyer(구매자명 = 본인?)
	// seller (판매자명) 
	// coin :  구매 시 지불하는 금액을 기록  + 지불된 금액만큼 member 의 coin을 차감.  
	// type = 1  ( 1이라면 -로 표기해줄 것) 
	// prod_num : 상품 글의 번호 ( 같은 판매자의 여러 상품들 중 하나를 구분하기 위함) 
	// 참고 : 이 시점에서 판매자에게 금액이 지불되는 것은 아니다. 이후 동작에서 처리된다. 
	
	
	// 금액을 실제로 지불할 때 동작하는 함수 
	// buyer (구매자명)
	// seller (판매자명 = 본인) 
	// coin : 구매시 지불되는 금액 + member 테이블의 coin 업데이트
	// type = 2 ( 2라면 +로 표기해줄 것) 
	// prod_num : 상품 글의 번호 
	// 참고 : 동명의 테이블을 조회해서 {buyer , seller , prod_num } 을 조건으로 했을 때, 
	// 일치하는 정보가 있을 경우에 동작을 시켜주도록 한다. 단, 환불한 경우가 있는지도 확인해야 한다. 
	
	
	
	// 금액을 환불해줄 때 동작하는 함수 
	// 사용자가 마음을 바꿔서 구매를 취소하는 등에 동작해줄 함수 
	
	// 금액을 걸어놓을 때 동작하는 함수의 동작에서 반대로 동작하도록 한다. 
	// buyer (구매자명)
	// seller (판매자명 = 본인) 
	// coin : 환불시 지불되는 금액  + member 테이블의 coin 업데이트
	// type = 3 ( 3이라면 +로 표기해줄 것) 
	// prod_num : 상품 글의 번호 
	// 생각 거리 : 환불 시 기존에 저장해둔 금액을 걸었던 기록을 남겨둘지 생각해볼 것 
}