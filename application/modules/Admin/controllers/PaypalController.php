<?php

class Admin_PaypalController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
       $PDb = new Admin_Model_DbTable_Paypal();
       $paypaldetails = $PDb->listdetails();
       $this->view->PayPalDtd = $paypaldetails;
    }

    public function updateAction()
    {
        $pDb = new Admin_Model_DbTable_Paypal();
        
        if($this->getRequest()->isPost())
    	{
    	    $formData = $this->getRequest()->getParams();
    	    unset($formData['button']);
    	    
    	    $pDb->updatedtd($formData);
    	    $this->_redirect('Admin/Paypal/index/st/2');
    	    
    	}
    	else
    	{
    	    $id=base64_decode($this->_getParam('id'));
    	    
    	    $PDetails = $pDb->paypaldtd($id);
    	    $this->view->PDtd=$PDetails;
    	 
    	    	
    	}
    }


}



