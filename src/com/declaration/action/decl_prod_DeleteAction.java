package com.declaration.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.declaration.db.declarationDAO;
import com.declaration.db.declarationDTO;
import com.msg.db.MsgDAO;
import com.prod.db.ProdDAO;

public class decl_prod_DeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("prodDeleteAction_execute() 호출");
		
		int num = Integer.parseInt(request.getParameter("num"));
		int state = Integer.parseInt(request.getParameter("state"));
		int decl_num = Integer.parseInt(request.getParameter("decl_num"));
		
		ProdDAO pDAO = new ProdDAO();
		declarationDAO dcDAO = new declarationDAO();
		MsgDAO mdao = new MsgDAO();
		
		// 게시판에서 글 삭제
		pDAO.deleteProduct(num);

		// 해당글삭제하기를 하면 상품게시판DB에서는 지우고 신고게시판에서는 지우지 않음
		
		// 신고 처리후 신고한사람에게 처리결과를, 
		// 삭제된글의 작성자에게 삭제되었다는 쪽지를 보내줌
		declarationDTO dcDTO = dcDAO.getDeclContent(decl_num);
		
		// 처리완료되면서 삭제된글의 작성자에게 쪽지 보내기
		mdao.msgDeclWriter(dcDTO);
		
		// 신고한 사람들에게 처리결과쪽지 보내기위해 신고한 사람들 목록 가져오기
		List<String> memberList = dcDAO.getDecl_prod_members(num);
		
		// 처리완료되면서 신고자에게 처리결과쪽지 보내기
		mdao.msgDeclUser(dcDTO, memberList);
		
		
		// 관리자가 신고된 글 삭제시 처리상태를 1(처리중)에서 2(처리완료)로 변경
		dcDAO.decl_state_prod_update(num);
		
		// 페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("decl_prod_list.decl?state="+state);
		forward.setRedirect(true);
		
		return forward;
	}

}
