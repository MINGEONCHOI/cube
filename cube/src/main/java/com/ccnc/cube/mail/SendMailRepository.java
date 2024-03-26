package com.ccnc.cube.mail;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ccnc.cube.common.CommonEnum.MailImportant;
import com.ccnc.cube.common.CommonEnum.MailIsDelete;

@Repository
public interface SendMailRepository extends JpaRepository<SendMail, Integer> {

	//List<SendMail> findAllBySendMailSenderEmail(String sendMailSenderEmail);
	
	
	List<SendMail> findBySendMailSenderEmailAndSendMailIsDeleteAndSendMailImportant(String userEmail, MailIsDelete isDelete, MailImportant important);
	
	
	
}
