<?php

class Admin_HelpController extends Zend_Controller_Action
{
    public function preDispatch()
    {
    	$auth = Zend_Auth::getInstance();
    	if (!$auth->hasIdentity()) {
    		$this->_redirect('/');
    	} else {
    		$useremail = $auth->getIdentity();
    	}
    }
    public function init()
    {
         /*
    	 * This section is using for displaying the status of action
    	 * if st=1 then add success
    	 * if st=2 then update success
    	 * if st=3 then delete success
    	 */
    	$id=$this->_getParam('st');
    	$pss = new Admin_Model_DbTable_Planfeatures();
    	$this->view->pss = $pss->viewStatus($id);
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
    	$hlist = new Admin_Model_DbTable_Help();
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
				$details = $formData['details'];
									
				// calling model db to insert values			
				$helpadd = new Admin_Model_DbTable_Help();
				$hid=$helpadd->addHelp($module,$section,$details);
			
				$this->_redirect('Admin/Help/index/st/1');
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
    		$details = $formData['details'];
    			
    		 
    		// calling model db to insert values (Planfeatures.php)
    		$helpupdate = new Admin_Model_DbTable_Help();
    		$helpupdate->updateHelp($id,$module,$section,$details);
    		 
    		$this->_redirect('Admin/Help/index/st/2');
    		 
    	}
    	else
    	{
    		$helpedit = new Admin_Model_DbTable_Help();
    		$this->view->hedit = $helpedit->RetriveHelpValues($id); // Calling values to display
    	}
    }

    public function deleteAction()
    {
         $id=$this->_getParam('id'); // Retriving Id
         $hss = new Admin_Model_DbTable_Help(); // Initializing db
         $this->view->fvalues = $hss->deleteHelp($id); // Calling function
         $this->_redirect('Admin/Help/index/st/3'); // redirecting to listing
    }


}







