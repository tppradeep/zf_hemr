<?php

class Admin_EmailController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
        $this->_helper->layout()->disableLayout();
        $hf_id=base64_decode($this->_getParam('hf_id'));
        $this->view->hf_id=$hf_id;
        
        $gDb = new Application_Model_DbTable_General();
        $this->view->userdetails = $gDb->identifierdetails($hf_id);
        
        if ($this->getRequest()->isPost())
        {
            $formData = $this->getRequest()->getPost();
            $hf_id = $formData['hf_id'];
            $email = $formData['email'];
            $email_title = $formData['email_title'];
            $email_message = $formData['cms_details'];
            
            /*
             * Email Template Section
            */
            $MailLegal = new Zend_Session_Namespace('maillegal');
            $mailbottom=$MailLegal->maillegal;
            
           
            $emailsubject =  $email_title;
            $emailbody = $email_message;
            
            $emailbody=$emailbody.$mailbottom;
             
           
            
            $emailto = trim($email);
            $nameto = $email;
            
             
            $mailconfig = new Zend_Session_Namespace('mail');
             
            $config = array('ssl' => 'tls', 'port' => 587, 'auth' => 'login', 'username' =>  $mailconfig->userid, 'password' => $mailconfig->password);
            
            $transport = new Zend_Mail_Transport_Smtp('smtp.gmail.com', $config);
            
            $mail = new Zend_Mail();
            $mail->setType(Zend_Mime::MULTIPART_RELATED);
            //$mail->setBodyText('Invoice Details attached');
            $mail->setBodyHtml($emailbody);
             
             
            $mail->setFrom($mailconfig->userid, 'ZH Healthcare');
            $mail->addTo($emailto, $nameto);
            $mail->setSubject($emailsubject);
             
            $gDb->messageadd($hf_id,addslashes($emailsubject),addslashes($emailbody));
            try
            {
            	$mail->send($transport);
            
            }
            catch(Zend_Exception $e)
            {
            	 
            }
            echo "Mail Send Successfully";
            die;
        }
    }


}

