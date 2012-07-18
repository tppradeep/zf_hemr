<?php

class Admin_FaqController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
		$faqdb = new Admin_Model_DbTable_Faq();
		$this->view->faqlist = $faqdb->listfaq();
		$this->view->st=$this->_getParam('st');
    }

    public function addAction()
    {
        $faqdb=new Admin_Model_DbTable_Faq();
	    if ($this->getRequest()->isPost())
         {
             $formData = $this->getRequest()->getPost();
             
             $faqdb->addfaq($formData);
             $this->_redirect('Admin/Faq/index/st/1');
         }
    }

    public function editAction()
    {
     	$faqdb=new Admin_Model_DbTable_Faq();
         
         if ($this->getRequest()->isPost())
         {
             $formData = $this->getRequest()->getPost();
             
             $faqdb->updatefaq($formData);
             $this->_redirect('Admin/Faq/index/st/2');
         }
         else
         {
             $id=$this->view->Dcode($this->_getParam('id')); // Retriving id from query string
             $this->view->faqview = $faqdb->viewfaq($id); // Calling values to display
         }
    }

    public function deleteAction()
    {
        $faqdb=new Admin_Model_DbTable_Faq();
         $id=$this->_getParam('id');
         $faqdb->deletefaq($id);
         $this->_redirect('Admin/Faq/index/st/3');
    }
    public function deleteallAction()
    {
    	$id=$this->_getParam('id');
    	$delids = explode(",",$id);
    	
	   	$pss = new Admin_Model_DbTable_Faq();

	   	foreach($delids as $id)
	   	{
	   	    if($id<>'0')
	   	    	$this->del = $pss->deletefaq(base64_decode($id));
	   	}
    	
    	$this->_redirect('Admin/Faq/index/st/3');
    }

}







