<?php

class Admin_SubproductController extends Zend_Controller_Action
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
        
    }

    public function indexAction()
    {
        $this->_helper->layout->setLayout('Admin_popup'); 
     	
        if ($this->getRequest()->isPost())
        {
           
        	$formData = $this->getRequest()->getPost();
        	 
        	unset($formData["button"]);
        	//$formData=var_dump($formData);
        	
        	$subproductadd = new Admin_Model_DbTable_Subproduct();
        	$idproducts=$subproductadd->addsubproducts($formData);
        	
        	$productname = new Admin_Model_DbTable_Productprice();
        	$this->view->idproduct = $idproducts;
        	$this->view->productname = $productname->productname($idproducts);
        	$productlist = new Admin_Model_DbTable_Subproduct();
        	$this->view->productlist = $productlist->productlist($idproducts);
        	
        	$selectedsubproducts = new Admin_Model_DbTable_Subproduct();
        	$SSP=$selectedsubproducts->selectedsubproducts($idproducts);
        	$_ssp = array();
        	foreach($SSP as $s)
        	{
        		$_ssp[]=$s['sub_idproducts'];
        	}
        	$this->view->selectedsubproducts = $_ssp;
        	$this->view->success="y";
        }
        else 
        {
	        $idproducts=$this->_getParam('id');
	        $productname = new Admin_Model_DbTable_Productprice();
	        $this->view->idproduct = $idproducts;
	        $this->view->productname = $productname->productname($idproducts);
	        $productlist = new Admin_Model_DbTable_Subproduct();
	        $this->view->productlist = $productlist->productlist($idproducts);
	        
	        $selectedsubproducts = new Admin_Model_DbTable_Subproduct();
	        $SSP=$selectedsubproducts->selectedsubproducts($idproducts);
	        $_ssp = array();
	        foreach($SSP as $s)
	        {
	            $_ssp[]=$s['sub_idproducts'];
	        }
	        $this->view->selectedsubproducts = $_ssp;
        }
    }


}

