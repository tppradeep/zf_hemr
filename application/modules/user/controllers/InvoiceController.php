<?php

class User_InvoiceController extends Zend_Controller_Action
{

    public function init()
    {
        $this->view->checkacl('0','0','0','1'); // Just for initiallization for helper call
        $this->view->checkaclresource('0','0',0); // Just for initiallization for helper call
        $sess = new Zend_Session_Namespace('user');
        if($sess->duser=="")
        {
        	$this->_redirect('Index');
        	exit;
        }

    }

    public function indexAction()
    {
        // action body
    }

    public function viewAction()
    {
       $this->_helper->layout()->disableLayout();
       $invoiceId	= $this->view->Dcode($this->_getParam('inid'));
    	//$PlanCustomFields = $this->view->Dcode($this->_getParam('PlanCustomFields'));
    	
    	$invDetails = new Application_Model_DbTable_Paymentdb();

    	$invoicedetails 			    = $invDetails->invoicedetails($invoiceId);
    	$this->view->invoicedetails		= $invDetails->invoicedetails($invoiceId);

    	$InvoiceAddress					= New Application_Model_DbTable_Paymentdb();
    	$this->view->invoiceaddress		= $InvoiceAddress->invoiceaddress($invoicedetails['hf_id']);
    	
    	$uname 							= new Application_Model_DbTable_UserRegister();
    	$this->view->uname 				= ucfirst(strtolower($uname->UserName($invoicedetails['hf_id']))); // for User Full Name
    	$this->view->ulogin 			= $uname->UserLoginInfo($invoicedetails['hf_id']); // for User Login and password info
    	
    	if($invoicedetails['plan_id']!=0)
    	{
	    	$pname 							= new Application_Model_DbTable_PlanList();
	    	$this->view->planname 			=$pname->planname($invoicedetails['plan_id']);
    	}
    	$PayPal_Notification 			= new Application_Model_DbTable_Cms();
    	$this->view->paypaldtd 			= $PayPal_Notification->getcms('Paypal_intimation');
    	
    	$cms 							= new Application_Model_DbTable_Cms();
    	$this->view->cmsdtd 			= $cms->getcms('User_reg_Confirm');
    }

    public function paidinvoiceAction()
    {
    	$PaidInvoice					= new user_Model_DbTable_Invoice();
    	$this->view->paidinvoice 		= $PaidInvoice->PaidInvoiceList();
    	 
    }

    public function outstandinginvoiceAction()
    {
       $OutstandingInvoice					= new user_Model_DbTable_Invoice();
       $this->view->OutstandingInvoice	 	= $OutstandingInvoice->OutstandingInvoiceList();
    }

    public function ledgerbalanceAction()
    {
        $ledgerbalance						= new user_Model_DbTable_Ledgerbalance();
       	$this->view->ledgerbalance		 	= $ledgerbalance->ledgerbalance();
    }


}









