<?php

class Admin_VideogalleryController extends Zend_Controller_Action
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
        $page_help_id=$this->view->Dcode($this->_getParam('id')); // Retriving the id
    	$this->view->page_help_id =$this->view->Ecode($page_help_id);
    }

    public function indexAction()
    {
        $page_help_id=$this->view->Dcode($this->_getParam('id')); // Retriving the id
    	
    	/*
    	 * Title of Page Help
    	 */
    	
    	
        if ($this->getRequest()->isPost())
		{
		
				
			$formData = $this->getRequest()->getPost();
			$title = $formData['title'];
		}
		else
		{
			$title = "";

		}
		$formData = $this->getRequest()->getPost();
		$this->view->formdata = $formData;
		//die;
    	$hlist = new Admin_Model_DbTable_Videogallery();
   		$result= $hlist->videolist($page_help_id,$title);
   		
   		$page=$this->_getParam('page',1);
   		
   		$paginator = Zend_Paginator::factory($result);
   		
   		$paginator->setItemCountPerPage(10);
   		$paginator->setCurrentPageNumber($page);
   		
   		$this->view->videolist=$paginator;
    }

    public function videolistAction()
    {
        // action body
    }

    public function addAction()
    {
        $page_help_id=$this->view->Dcode($this->_getParam('page_help_id'));
        
    	if ($this->getRequest()->isPost())
    	{
    		$formData = $this->getRequest()->getPost();
    			
    		$video_title = $formData['video_title'];
    		$utube_url = $formData['utube_url'];
    		$sortorder = $formData['sortorder'];
    		$status = $formData['status'];
    		
    		$helpadd = new Admin_Model_DbTable_Videogallery();
    		$hid=$helpadd->addvideo($page_help_id,$video_title,$utube_url,$sortorder,$status);
    		 
    		$this->_redirect('Admin/Videogallery/index/id/'.$this->view->Ecode($page_help_id).'/st/1');
    	}
    }

    public function editAction()
    {
    	$id=$this->view->Dcode($this->_getParam('id')); // Retriving the id
    	if ($this->getRequest()->isPost())
    	{
    		 
    		 
    		$formData = $this->getRequest()->getPost();
    		 
    		 
    		$page_help_video_id = $formData['page_help_video_id'];
    		$page_help_id = $formData['page_help_id'];
    		$video_title = $formData['video_title'];
    		$utube_url = $formData['utube_url'];
    		$sortorder = $formData['sortorder'];
    		$status = $formData['status'];
    	
    			
    		 
    		// calling model db to insert values (Planfeatures.php)
    		$helpupdate = new Admin_Model_DbTable_Videogallery();
    		$helpupdate->UpdateVideo($page_help_video_id,$page_help_id,$video_title,$utube_url,$sortorder,$status);
    		 
    		$this->_redirect('Admin/Videogallery/index/id/'.$this->view->Ecode($page_help_id).'/st/2');
    		 
    	}
    	else
    	{
    		$videoedit = new Admin_Model_DbTable_Videogallery();
    		$this->view->videoedit = $videoedit->RetriveVideoValues($id); // Calling values to display
    	}
    }

    public function deleteAction()
    {
         $page_help_id=$this->_getParam('pageid');
        $id=$this->_getParam('id');
	   	$pss = new Admin_Model_DbTable_Videogallery();
    	$this->view->fvalues = $pss->deletevideo($id);
    	$this->_redirect('Admin/Videogallery/index/id/'.$this->view->Ecode($page_help_id).'/st/3');
    }


}









