<?php

class Admin_PageHelpController extends Zend_Controller_Action
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
       if ($this->getRequest()->isPost())
		{
		
				
			$formData = $this->getRequest()->getPost();
			$module = $formData['module'];
			$section = $formData['sec'];
		}
		else
		{
			$module = "";
			$section = "";
		}
		$formData = $this->getRequest()->getPost();
		$this->view->formdata = $formData;
		//die;
    	$hlist = new Admin_Model_DbTable_PageHelp();
   		$result= $hlist->helplist($module,$section);
   		$page=$this->_getParam('page',1);
   		$paginator = Zend_Paginator::factory($result);
   		$paginator->setItemCountPerPage(10);
   		$paginator->setCurrentPageNumber($page);
   		
   		$this->view->helplist=$paginator;
    }

    public function addAction()
    {
     if ($this->getRequest()->isPost()) 
		{
			$formData = $this->getRequest()->getPost();
					
				$module = $formData['module'];
				$section = $formData['section'];
				$title = $formData['title'];
				$details = $formData['detailss'];
									
				// calling model db to insert values			
				$helpadd = new Admin_Model_DbTable_PageHelp();
				$hid=$helpadd->addHelp($module,$section,$title,$details);
			
				$this->_redirect('Admin/PageHelp/index/st/1');
			}
    }

    public function editAction()
    {
    	$id=$this->view->Dcode($this->_getParam('id')); // Retriving the id
    	if ($this->getRequest()->isPost())
    	{
    		 
    		 
    		$formData = $this->getRequest()->getPost();
    		 
    		 
    		$id = $formData['id'];
    		$module = $formData['module'];
    		$section = $formData['section'];
    		$title = $formData['title'];
    		$details = $formData['detailss'];
    	
    			
    		 
    		// calling model db to insert values (Planfeatures.php)
    		$helpupdate = new Admin_Model_DbTable_PageHelp();
    		$helpupdate->updateHelp($id,$module,$section,$title,$details);
    		 
    		$this->_redirect('Admin/PageHelp/index/st/2');
    		 
    	}
    	else
    	{
    		$helpedit = new Admin_Model_DbTable_PageHelp();
    		$this->view->hedit = $helpedit->RetriveHelpValues($id); // Calling values to display
    	}
    }

    public function deleteAction()
    {
         $id=$this->_getParam('id'); // Retriving Id
         $hss = new Admin_Model_DbTable_PageHelp(); // Initializing db
         $this->view->fvalues = $hss->deleteHelp($id); // Calling function
         $this->_redirect('Admin/PageHelp/index/st/3'); // redirecting to listing
    }


}







