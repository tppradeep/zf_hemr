<?php

class Admin_UpdateinvoiceController extends Zend_Controller_Action
{
    public function preDispatch()
    {
    	$auth = Zend_Auth::getInstance();
    	if (!$auth->hasIdentity()) {
    		$this->_redirect('/');
    	} else {
    		$useremail = $auth->getIdentity();
    		//$this->view->username = $userdata->username;
    	}
    }
    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
        //$this->_helper->layout()->disableLayout();
        $this->_helper->layout->setLayout('Admin_popup');
        $id=$this->_getParam('id');
        $invdtd = new Admin_Model_DbTable_Updateinvoice();
        $invdtd=$invdtd->invoicedtd($id);
        $this->view->invdtd=$invdtd;
	//	echo "<pre>";
       // print_r($invdtd);
       // echo "</pre>";
       
        if ($this->getRequest()->isPost())
        {
        	 
        	$formData = $this->getRequest()->getPost();
        	
        	$invdtd = new Admin_Model_DbTable_Updateinvoice();
        	$invdtd=$invdtd->updateprice($formData);
        }
    }


}

