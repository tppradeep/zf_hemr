<?php

class ResetpasswordController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
        if ($this->getRequest()->isPost())
        {
            $formData 		= $this->getRequest()->getPost();
            $hf_id 			= base64_decode($formData['hf_id']);
            $temppass 		= $formData['temppass'];
            $newpass 		= $formData['newpass'];
            $confirmnewpass = $formData['confirmnewpass'];
            
            $ResetDb = new Application_Model_DbTable_Resetpassword();
            $this->view->hf_id=base64_encode($hf_id);
            $this->view->sec=1;
            $result = $ResetDb->resetpassword($hf_id,$temppass,$newpass,$confirmnewpass);
            if($result=="success")
            {
                $this->view->noretry=1;
                $this->view->message = "Your Password reseted successfully";
            }
            if($result=="passwordnotmatch")
            {
                $this->view->noretry=0;
                $this->view->message = "The new password and confirm password is not matching. Please note the password is case sensitive";
            }
            if($result=="tempfail")
            {
                $this->view->noretry=0;
                $this->view->message = "The Temporary password you had entered is not correct. Please check the temporary password and enter correctly.";
            }
        }
        else 
        {
            $this->view->sec=0;
	        $hf_id=base64_decode($this->_getParam('uid'));
			$GenDb =  new Application_Model_DbTable_General();
			$this->view->hf_id=base64_encode($hf_id);
			$this->view->userdata = $GenDb->identifierdetails($hf_id);
	    	
			$cmsObj = new Application_Model_DbTable_Index();
			$this->view->cms = $cmsObj->getcms('Reset Password Intro');
        }
    }


}

