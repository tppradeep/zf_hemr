<?php

class User_IndexController extends Zend_Controller_Action
{

    public function init()
    {
        $sess = new Zend_Session_Namespace('user');
        if($sess->duser=="")
        {
        	$this->_redirect('Index');
        	exit;
        }
        $this->view->checkacl('0','0','0','1'); // Just for initiallization for helper call
        $this->view->checkaclresource('0','0',0); // Just for initiallization for helper call
        
        
    }

    public function indexAction()
    {
        
        $welcomemessage = new Application_Model_DbTable_Cms();
    	$this->view->welcome = $welcomemessage->getcms('User_welcome_after_login');
    	
    	// User Name Retriving from UserRegisterController
    	$sess = new Zend_Session_Namespace('MyNamespace');
    
    	    	
    	$userfullname = new user_Model_DbTable_Index();
    //	$this->view->ufullname = $userfullname->UserName($sess->duser); 
    	
    	// Checking Invoice Paid Details
    	$userfullname = new user_Model_DbTable_Index();
    	$this->view->LastPayment_invoice = $userfullname->LastPayment_invoice($sess->duser); 
    	
    	// Checking Outstanding Invoice Details
    	
    	$userfullname = new user_Model_DbTable_Index();
    	$this->view->Outstanding_invoice = $userfullname->Outstanding_invoice();
    	
    	// Display Basic Plan Details
    	$plandetails = new user_Model_DbTable_Index();
    	$this->view->PlanDetails = $plandetails->BasicPlanInfo();
    	
    	
    }


}

