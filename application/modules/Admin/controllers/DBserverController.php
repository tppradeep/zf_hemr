<?php

class Admin_DBserverController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
        $dbsdb = new Admin_Model_DbTable_DBserver();
		$this->view->serverlist = $dbsdb->listserver();
		$this->view->st=$this->_getParam('st');
    }

    public function addAction()
    {
    	$dbsdb=new Admin_Model_DbTable_DBserver();
	    if ($this->getRequest()->isPost())
         {
             $formData = $this->getRequest()->getPost();
             
             $dbsdb->adddbserver($formData);
             $this->_redirect('Admin/DBserver/index/st/1');
           
         }
    }

    public function editAction()
    {
    	$dbsdb=new Admin_Model_DbTable_DBserver();
         
         if ($this->getRequest()->isPost())
         {
             $formData = $this->getRequest()->getPost();
             
             $dbsdb->editserver($formData);
             $this->_redirect('Admin/DBserver/index/st/2');
         }
         else
         {
             $id=$this->view->Dcode($this->_getParam('id')); // Retriving id from query string
             $this->view->dbview = $dbsdb->viewdb($id); // Calling values to display
         }
    }

    public function deleteAction()
    {
        $dbsdb=new Admin_Model_DbTable_DBserver();
         $id=$this->_getParam('id');
         $dbsdb->deleteserver($id);
         $this->_redirect('Admin/DBserver/index/st/3');
    }

    public function deleteallAction()
    {
        $id=$this->_getParam('id');
    	$delids = explode(",",$id);
    	
	   	$pss = new Admin_Model_DbTable_DBserver();

	   	foreach($delids as $id)
	   	{
	   	    if($id<>'0')
	   	    	$this->del = $pss->deleteserver(base64_decode($id));
	   	}
    	
    	$this->_redirect('Admin/DBserver/index/st/3');
    }


}









