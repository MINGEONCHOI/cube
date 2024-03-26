package com.ccnc.cube.board;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ccnc.cube.common.Team;
import com.ccnc.cube.user.Users;

@Repository
public interface BoardRepository extends JpaRepository<Board, Integer> {

	List<Board> findByTeamId(Team team);

	List<Board> findByBoardTitleContaining(String boardTitle);
	
	List<Board> findByBoardWriter_UserNameContaining(String userName);
}
