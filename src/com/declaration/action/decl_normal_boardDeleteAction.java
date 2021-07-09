package com.declaration.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.user.db.AdminUserDAO;
import com.board.comment.db.boardCommentDAO;
import com.board.db.boardDAO;
import com.declaration.db.declarationDAO;
import com.declaration.db.declarationDTO;
import com.msg.db.MsgDAO;

public class decl_normal_boardDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("BoardDeleteAction_execute() 호출");
		
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		int state = Integer.parseInt(request.getParameter("state"));
		int decl_num = Integer.parseInt(request.getParameter("decl_num"));
		
		
		boardDAO bDAO = new boardDAO();
		declarationDAO dcDAO = new declarationDAO();
		MsgDAO mdao = new MsgDAO();
		boardCommentDAO bcDAO = new boardCommentDAO();
		
		// 게시판에서 글 삭제
		bDAO.deleteBoard(board_num);
		
		// 해당글삭제하기를 하면 게시판DB에서는 지우고 신고게시판에서는 지우지 않음
		
		// 신고 처리후 신고한사람에게 처리결과를, 
		// 삭제된글의 작성자에게 삭제되었다는 쪽지를 보내줌
		declarationDTO dcDTO = dcDAO.getDeclContent(decl_num);
		
		// 처리완료되면서 삭제된글의 작성자에게 쪽지 보내기
		mdao.msgDeclWriter(dcDTO);
		
		// 신고한 사람들에게 처리결과쪽지 보내기위해 신고한 사람들 목록 가져오기
		List<String> memberList = dcDAO.getDecl_normal_members(board_num);
		
		// 처리완료되면서 신고한 사람들에게 처리결과쪽지 보내기
		mdao.msgDeclUser(dcDTO, memberList);
		
		// 게시글 삭제되면 댓글도 같이 삭제되게 처리
		bcDAO.delete_cmt_to_board(board_num);
		
		// 관리자가 신고된 글 삭제시 처리상태를 1(처리중)에서 2(처리완료)로 변경
		dcDAO.decl_state_normal_update(board_num);
		

		String delnick = dcDAO.getUserCount(board_num);
		
		AdminUserDAO auDAO = new AdminUserDAO();
		
		if(!delnick.equals("")){
			auDAO.activateUser(delnick);			
		}
		

		// 페이지이동
		ActionForward forward = new ActionForward();
		forward.setPath("decl_normal_list.decl?state="+state);
		forward.setRedirect(true);
		
		return forward;
	}

}
