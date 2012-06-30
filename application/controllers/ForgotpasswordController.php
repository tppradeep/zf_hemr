<?php

class ForgotpasswordController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
        
        $this->_helper->layout->setLayout('ajax'); 

        if ($this->getRequest()->isPost())
        {
        	$formData = $this->getRequest()->getPost();
        	$uid = $formData['email'];
        	$forgotdb = new Application_Model_DbTable_Forgotpassword();
        	$result = $forgotdb->sendtemppassword($uid);
        	if($result!="0")// sending mail
        	{
        	   
        	    /*
        	     * Email Template Section
        	    */
        	    $MailLegal = new Zend_Session_Namespace('maillegal');
        	    $mailbottom=$MailLegal->maillegal;
        	    
        	    
        	    $gendb = new Application_Model_DbTable_General();
        	    
        	    $userdata = $gendb->userdeatils_email($uid);
        	    $reseturl = 'http://hostedopenemr.com/Resetpassword/index/uid/'.base64_encode($userdata['hf_id']);
        	    
        	    $emldata = $gendb->emailtemplate('forgot_password');
        	    $emailsubject =  $emldata['Subject'];
        	    $emailbody = $emldata['content'];
        	    $emailbody = str_replace('__temppassword__', $result, $emailbody);
        	     $emailbody = str_replace('__resetlink__', $reseturl, $emailbody);
        	    
        	    $emailbody = str_replace('__name__', $userdata['hf_facility_suffix']." ".$userdata['hf_facility_name']." ".$userdata['hf_facility_lname'], $emailbody);
        	    
        	    
        	    
        	    $emailbody=$emailbody.$mailbottom;
        	     
        	   
        	    
        	    $emailto = trim($uid);
        	    $nameto = $userdata['hf_facility_suffix']." ".$userdata['hf_facility_name']." ".$userdata['hf_facility_lname'];
        	    
        	    
        	    $mailconfig = new Zend_Session_Namespace('mail');
        	    
        	    
        	    $config = array('ssl' => 'tls', 'port' => 587, 'auth' => 'login', 'username' => $mailconfig->userid, 'password' => $mailconfig->password);
        	    
        	    $transport = new Zend_Mail_Transport_Smtp('smtp.gmail.com', $config);
        	    
        	    $mail = new Zend_Mail();
        	    $mail->setType(Zend_Mime::MULTIPART_RELATED);
        	    //$mail->setBodyText('Invoice Details attached');
        	    $mail->setBodyHtml($emailbody);
        	    $mail->setFrom($mailconfig->userid, 'ZH Healthcare');
        	    $mail->addTo($emailto, $nameto);
        	    $mail->setSubject($emailsubject);
        	     
        	    $gendb->messageadd($userdata['hf_id'],addslashes($emailsubject),addslashes($emailbody));
        	    try
        	    {
        	    	$mail->send($transport);
        	    
        	    }
        	    catch(Zend_Exception $e)
        	    {
        	    	 
        	    }
        	    $this->view->message = "<p>&nbsp</p><p class='cms'>We had forwarded the password reset instructions to the provided email address. Please check your email to reset password.</p>";
        	    $this->view->st=1;
        	}
        	else // If there is no email address
        	{
        	    $this->view->message = "<p>&nbsp</p><p class='cms red'>The entered email address is not valid. Please check and enter your email address correctly</p>";
        	    $this->view->st=1;
        	}
        }
        else
        {
            $cmsObj = new Application_Model_DbTable_Index();
            $this->view->cms = $cmsObj->getcms('Forgot Password');
        }
    }


}

