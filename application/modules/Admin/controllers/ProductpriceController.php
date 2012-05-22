<?php

class Admin_ProductpriceController extends Zend_Controller_Action
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
        $idproducts=$this->view->Dcode($this->_getParam('idproducts'));
        $this->view->idproducts = $this->view->Ecode($idproducts);
        $ps = new Admin_Model_DbTable_Productprice();
        $this->view->productprice = $ps->productprice($idproducts);
        
        $productname = new Admin_Model_DbTable_Productprice();
        $this->view->productname = $productname->productname($idproducts);
    }

    public function addAction()
    {
         $idproducts=$this->view->Dcode($this->_getParam('idproducts'));
         $this->view->idproducts = $this->view->Ecode($idproducts);
         $productname = new Admin_Model_DbTable_Productprice();
         $this->view->productname = $productname->productname($idproducts);
         
         if ($this->getRequest()->isPost())
         {
         	$formData = $this->getRequest()->getPost();
         
         	$user_from = $formData['user_from'];
         	$user_to = $formData['user_to'];
         	$cost = $formData['cost'];
         	$sortorder = $formData['sortorder'];
         	$status=$formData['status'];
         	$added_date = date('Y-m-d');
         		
         	// calling model db to insert values
         	$pfeature = new Admin_Model_DbTable_Productprice();
         	$pid=$pfeature->addProductprice($idproducts,$user_from,$user_to,$cost,$sortorder,$status,$added_date);
         
         
         	$this->_redirect('Admin/Productprice/index/st/1/idproducts/'.$this->view->Ecode($idproducts));
         }
    }

    public function editAction()
    {
     if ($this->getRequest()->isPost())
         {
         	$formData = $this->getRequest()->getPost();
         	
         	$idproducts = $this->view->Dcode($formData['idproducts']);
         	$idproduct_feature = $this->view->Dcode($formData['idproduct_feature']);
         	$user_from = $formData['user_from'];
         	$user_to = $formData['user_to'];
         	$cost = $formData['cost'];
         	$sortorder = $formData['sortorder'];
         	$status=$formData['status'];
         	$added_date = date('Y-m-d');
         		
         	// calling model db to insert values
         	$pfeature = new Admin_Model_DbTable_Productprice();
         	$pid=$pfeature->updateProductprice($idproduct_feature,$idproducts,$user_from,$user_to,$cost,$sortorder,$status);
         
         
         	$this->_redirect('Admin/Productprice/index/st/2/idproducts/'.$this->view->Ecode($idproducts));
         }
         else
         {
             $idproducts=$this->view->Dcode($this->_getParam('idproducts'));
             $idproduct_feature=$this->view->Dcode($this->_getParam('idproduct_feature'));
             $this->view->idproducts = $this->view->Ecode($idproducts);
             $productname = new Admin_Model_DbTable_Productprice();
             $this->view->productname = $productname->productname($idproducts);
              
             $pfeature = new Admin_Model_DbTable_Productprice();
             $this->view->productprice = $pfeature->retriveproductprice($idproduct_feature);
         }
         
    }

    public function deleteAction()
    {
        $pfeature = new Admin_Model_DbTable_Productprice();
       $id=$this->_getParam('id');
       $idproducts=$this->_getParam('idproducts');
       $this->view->delproductprice = $pfeature->deleteproductprice($id);
       $this->_redirect('Admin/Productprice/index/st/2/idproducts/'.$this->view->Ecode($idproducts));
    }

}







