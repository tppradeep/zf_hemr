<?php

class Admin_PlanconfigController extends Zend_Controller_Action
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
        $id=$this->view->Dcode($this->_getParam('id'));
        
        $ps = new Admin_Model_DbTable_Planconfig();
        $this->view->products = $ps->products();
        $this->view->planname = $ps->hp_plan_name($id);
        $this->view->AddedProducts = $ps->AddedProducts($id);
        
        if ($this->getRequest()->isPost())
        {
        	 $formData = $this->getRequest()->getPost();
        	 unset($formData['button']);
        	 $this->view->AddProduct = $ps->AddProduct($formData,$id);

        	 $this->_redirect('Admin/Plans/index/st/2');
        }
       
    }

    public function addAction()
    {
        
       
    }


}



