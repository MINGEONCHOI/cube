package com.ccnc.cube.board;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

public interface NoticeBoardRepository  extends JpaRepository<NoticeBoard, Integer>{

	Optional<NoticeBoard> getNoticeBoardByNboardId(Integer nboardId);
	
	List<NoticeBoard> findByNboardTitleContaining(String nboardTitle);
	
	

	
}
