package com.ccnc.cube.board;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.apache.catalina.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ccnc.cube.common.ResponseDTO;
import com.ccnc.cube.common.Team;
import com.ccnc.cube.common.TeamService;
import com.ccnc.cube.user.UserService;
import com.ccnc.cube.user.Users;

import jakarta.servlet.http.HttpSession;

@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;

	@Autowired
	private CommentService commentService;

	@Autowired
	private TeamService teamService;

	@Autowired
	private UserService userService;
	
	

	// 글 목록 good
	@GetMapping("/listBoard/{teamId}")
	public String getListBoard(Model model, @PathVariable int teamId) {
		List<Board> getTeamBoardList = boardService.findByTeamId(teamService.getTeam(teamId));
		model.addAttribute("team", teamService.getTeam(teamId));
		model.addAttribute("getTeamBoardList", getTeamBoardList);
		model.addAttribute("asidePage", "./board/board_aside.jsp");
		model.addAttribute("mainPage", "./board/board_getList.jsp");
		return "index";
	}

	// 조회 good
	@GetMapping("/getBoard/{teamId}/{boardId}")
	public String getBoard(@PathVariable Integer boardId, @PathVariable Integer teamId, Model model) {
		Board board = boardService.getBoard(boardId);
		model.addAttribute("teamId", teamId);
		model.addAttribute("Board", board);
		model.addAttribute("commentList", commentService.commentList(boardId));
		model.addAttribute("asidePage", "./board/board_aside.jsp");
		model.addAttribute("mainPage", "./board/board_get.jsp");
		return "index";
	}

	@GetMapping("/insertBoard/{teamId}") // 글등록 페이지로 이동
	public String getInsertBoard(Model model, @PathVariable int teamId) {
		model.addAttribute("team", teamService.getTeam(teamId));
		model.addAttribute("asidePage", "./board/board_aside.jsp");
		model.addAttribute("mainPage", "./board/board_insert.jsp");
		return "index";
	}

//	@GetMapping("/getBoardTeamList") // 팀게시판 팀 목록으로 이동
//	public String getTeamList(Model model) {
//
//		model.addAttribute("teamList", teamService.getTeamList());
//		model.addAttribute("asidePage", "./board/board_aside.jsp");
//		model.addAttribute("mainPage", "./board/board_teamList.jsp");
//		return "index";
//	}

	// 등록 !!!
	@PostMapping("/insertBoard/{teamId}")
	@ResponseBody
	public void insertBoard(@RequestBody Board board, @PathVariable int teamId, HttpSession session) {
		Users users = (Users) session.getAttribute("login_user");

		board.setBoardWriter(users);
		board.setTeamId(teamService.getTeam(teamId));
		boardService.insertBoard(board);

	}

	// 업데이트 !!!!
	@PostMapping("/updateBoard/{teamId}")
	@ResponseBody
	public String updateBoard(@RequestBody Board board, HttpSession session, Model model,
			@PathVariable Integer teamId) {

		Users users = (Users) session.getAttribute("login_user");

		Board findBoard = boardService.getBoard(board.getBoardId());

		findBoard.setBoardTitle(board.getBoardTitle());
		findBoard.setBoardContent(board.getBoardContent());
		findBoard.setBoardUpdated(LocalDateTime.now());
		boardService.updateBoard(findBoard);
		model.addAttribute("teamId", teamId);
		model.addAttribute("asidePage", "./board/board_aside.jsp");
		model.addAttribute("mainPage", "./board/board_updateBoard.jsp");

		return "index";
	}

	@GetMapping("/updateBoard/{boardId}") // 글수정 페이지로 이동
	public String updateBoard(@PathVariable Integer boardId, Model model) {

		model.addAttribute("Board", boardService.getBoard(boardId));
		model.addAttribute("asidePage", "./board/board_aside.jsp");
		model.addAttribute("mainPage", "./board/board_updateBoard.jsp");
		return "index";
	}

	// 삭제 !!
	// ---------------------------------------------------------------------------------------
	@DeleteMapping("/deleteBoard/{boardId}")
	public ResponseEntity<?> deleteBoard(@PathVariable Integer boardId, Model model) {

		boardService.deleteBoard(boardId);
		model.addAttribute("asidePage", "./board/board_aside.jsp");
		model.addAttribute("mainPage", "./board/board_main.jsp");

		return new ResponseEntity<>(new ResponseDTO<>(HttpStatus.OK.value(), "글 삭제 성공"), HttpStatus.OK);

	}

	@PostMapping("/insertComment/{boardId}")
	@ResponseBody
	public void insertBoard(@RequestBody Comment comment, @PathVariable int boardId, HttpSession session) {
		Users user = (Users) session.getAttribute("login_user");
		Comment comm = new Comment();
		comm.setBoardId(boardService.getBoard(boardId));
		comm.setCommentContent(comment.getCommentContent());
		comm.setCommentWriter(user);

		commentService.insertComment(comm);
	}

	@ResponseBody
	@DeleteMapping("/deleteComment/{commentId}")
	public void deleteComment(@PathVariable Integer commentId) {

		commentService.deleteComment(commentId);

	}

	/*--------------------------------------------------------------------------------------------------------------------------------
	이름 제목 검색  */
	@GetMapping("/listBoard/{teamId}/{searchType}/{searchInput}")
	public String searchBoard(@PathVariable Integer teamId, @PathVariable String searchType,
			@PathVariable String searchInput, Model model) {

		List<Board> teamBoardList = new ArrayList<>();
		
		if (searchType.equals("userName")) {
			System.out.println("이름으로 검색 실행");

			List<Board> boardList = boardService.findByBoardWriterLike(searchInput);
		
			for (Board board : boardList) {
				if (board.getTeamId().getTeamId() == teamId) {
					teamBoardList.add(board);
				}
			}
			model.addAttribute("getTeamBoardList", teamBoardList);

		} else if (searchType.equals("boardTitle")) {
			System.out.println("게시글 제목으로 검색 실행");
			List<Board> boardList = boardService.findByBoardTitleLike(searchInput);

			for (Board board : boardList) {
				if (board.getTeamId().getTeamId() == teamId) {
					teamBoardList.add(board);
				}
			}
			model.addAttribute("getTeamBoardList", teamBoardList);
		}

		model.addAttribute("team", teamService.getTeam(teamId));
		model.addAttribute("teamId", teamId);
		model.addAttribute("asidePage", "./board/board_aside.jsp");
		model.addAttribute("mainPage", "./board/board_getList.jsp");
		System.out.println("세팅완료");

		return "index";
	}

}
