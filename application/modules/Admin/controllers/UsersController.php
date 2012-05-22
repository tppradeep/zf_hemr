<?php

class Admin_UsersController extends Zend_Controller_Action
{

    public function preDispatch()
    {
    	$auth = Zend_Auth::getInstance();
    	if (!$auth->hasIdentity()) 
    	{
    		$this->_redirect('/');
    	} 
    	else 
    	{
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
         $us = new Admin_Model_DbTable_Users();
         $this->view->userlist = $us->userlist();
         
         
    }

    public function userdetailsAction()
    {
         $this->_helper->layout->setLayout('Admin_popup'); 
      	 $hf_id = $this->view->Dcode($this->_getParam('id'));
       
        $userdetails = new Admin_Model_DbTable_Users();
        $this->view->formdata = $userdetails->retriveuserdetails($hf_id);
        
        $country = new Application_Model_DbTable_General();
        $this->view->country = $country->countrylist();
    }

    public function deleteAction()
    {
        $id=$this->_getParam('id');
	   	$pss = new Admin_Model_DbTable_Users();
    	$this->del = $pss->deleteUser($id);
    	$this->_redirect('Admin/Users/index/st/3');
    }

    public function userinvoiceAction()
    {
        $this->_helper->layout->setLayout('Admin_popup');
        $hf_id=$this->view->Dcode($this->_getParam('id'));
        
        $userinvoice = new Admin_Model_DbTable_Users();
        $this->view->userinvoice = $userinvoice->userinvoice($hf_id);
        
        $this->view->providerno = $userinvoice->providerno($hf_id);
        
    }

    public function viewplanAction()
    {
        $hf_id=$this->view->Dcode($this->_getParam('id'));
        
        $planname = new Admin_Model_DbTable_Users();
        $this->view->planname = $planname->planname($hf_id);
       
        $plan = new Admin_Model_DbTable_Users();
        $this->view->sp_f_list = $plan->listplanfeatures($hf_id);
         
        $plandtd = $plan->listplanfeatures($hf_id);
        $this->view->productdetails=$plan->productdetails($hf_id);
        
        $this->view->providerno = $plan->providerno($hf_id);
        
    }

    public function userAclAction()
    {
        $db = new Admin_Model_DbTable_Users();
        $this->_helper->layout->setLayout('Admin_popup'); 
        
        $hf_id=$this->view->Dcode($this->_getParam('id'));
        
        // Fetching the user acl details from hosted_facilities table
                
        
        $this->view->resourcelist = $db->userresourcelist($hf_id);
        $this->view->hf_id=$hf_id;
    }

    public function userActionListAction()
    {
       $this->_helper->layout()->disableLayout();
       $resource=$this->_getParam('id');
       $hf_id = $this->_getParam('hf_id');
       $db = new Admin_Model_DbTable_Users();
       $this->view->actionlist = $db->useractionlist($resource,$hf_id);
       $this->view->hf_id=$hf_id;
    }

    public function setPermissionAction()
    {
       $this->_helper->layout()->disableLayout();
       $resource=$this->_getParam('id');
       $hf_id = $this->_getParam('hf_id');
       $db = new Admin_Model_DbTable_Users();
       $db->useractionupdate($resource,$hf_id);
    }
}