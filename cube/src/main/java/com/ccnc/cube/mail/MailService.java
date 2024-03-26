package com.ccnc.cube.mail;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ccnc.cube.common.CommonEnum.MailImportant;
import com.ccnc.cube.common.CommonEnum.MailIsDelete;

@Service
public class MailService {
	
	
	
	@Autowired
	private ReceiveMailRepository receiveMailRepository;
	
	@Autowired
	private SendMailRepository sendMailRepository;
/*	
	@Transactional
	public void sendMail(SendMail sendMail) {
		sendMailRepository.save(sendMail);
	}
*/	
	@Transactional
	public void saveSendMail(SendMail sendMail) {
		sendMailRepository.save(sendMail);
	}
	
	@Transactional
	public void saveReceiveMail(ReceiveMail receiveMail) {
		receiveMailRepository.save(receiveMail);
	}

	public void isDeleteSendMail(Integer sendMailId) {
		sendMailRepository.deleteById(sendMailId);
	}
	
	public void isDeleteReceiveMail(Integer receiveMailId) {
		receiveMailRepository.deleteById(receiveMailId);
	}

//======================================================================================	
	@Transactional
	public List<SendMail> sendMailList(){
		return sendMailRepository.findAll(); 
	}
//======================================================================================	
	@Transactional
	public List<ReceiveMail> receiveMailList(){
		return receiveMailRepository.findAll();
	}
//======================================================================================   	보낸 메일함	

	@Transactional
	public List<SendMail> sentMailbox(String userEmail, MailIsDelete isDelete, MailImportant important){
		return sendMailRepository.findBySendMailSenderEmailAndSendMailIsDeleteAndSendMailImportant(userEmail,isDelete,important);
	};
//======================================================================================   받은 메일함	
	
	@Transactional
	public List<ReceiveMail> receivedMailBox(String userEmail, MailIsDelete isDelete, MailImportant important){
		return receiveMailRepository.findByReceiveMailReceiverEmailAndReceiveMailIsDeleteAndReceiveMailImportant(userEmail,isDelete,important);
	};
	
//====================================================================================== 
		
	@Transactional(readOnly = true)
	public SendMail getSendMail(Integer sendMailId){
	 SendMail findSendMail = sendMailRepository.findById(sendMailId).orElseGet(()->{
			return new SendMail();
		});
	 return findSendMail;
	}
	
	@Transactional(readOnly = true)
	public ReceiveMail getReceiveMail(Integer receiveMailId){
	 ReceiveMail findReceiveMail = receiveMailRepository.findById(receiveMailId).orElseGet(()->{
			return new ReceiveMail();
		});
	 return findReceiveMail;
	}

	

	

	
	
	
	
	
	
}