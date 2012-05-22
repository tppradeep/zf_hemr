<?php

class Admin_ImagegalleryController extends Zend_Controller_Action
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
        /* Initialize action controller here */
    	$page_help_id=$this->view->Dcode($this->_getParam('id')); // Retriving the id
    	$this->view->page_help_id =$this->view->Ecode($page_help_id);
    }

    public function indexAction()
    {
    	$page_help_id=$this->view->Dcode($this->_getParam('id')); // Retriving the id
    	
    	/*
    	 * Title of Page Help
    	 */
    	$helptitle = new Admin_Model_DbTable_Imagegallery();
    	$this->view->helptitle = $helptitle->helptitle($page_help_id);
    	
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
    	$hlist = new Admin_Model_DbTable_Imagegallery();
   		$result= $hlist->imagelist($page_help_id,$title);
   		$page=$this->_getParam('page',1);
   		$paginator = Zend_Paginator::factory($result);
   		$paginator->setItemCountPerPage(10);
   		$paginator->setCurrentPageNumber($page);
   		
   		$this->view->imagelist=$paginator;
    }

    public function imagegalleryAction()
    {
        // action body
    }

    public function addAction()
    {
    	$page_help_id=$this->view->Dcode($this->_getParam('page_help_id'));
        
    	if ($this->getRequest()->isPost())
    	{
    		$formData = $this->getRequest()->getPost();
    			
    		$image_title = $formData['image_title'];
    		$desc = $formData['desc'];
    		$sortorder = $formData['sortorder'];
    		$status = $formData['status'];
    		
    		
    		/*
    		 * * * * * * * * * * * * * * * 
    		 *   IMAGE UPLOADING SECTION
    		 * * * * * * * * * * * * * * * 
    		 */
    		$imgwithpath = str_replace("application", "public", APPLICATION_PATH).'\\uploads\\';
    		$upload = new Zend_File_Transfer_Adapter_Http();
			$upload->addValidator('Count', false, array('min' =>1, 'max' => 1))
			       ->addValidator('IsImage', false, 'jpeg,gif,jpg,png')
			       ->addValidator('Size', false, array('max' => '551200kB'))
			       ->setDestination($imgwithpath);
			if (!$upload->isValid())
			{
				throw new Exception('Bad image data: '.implode(',', $upload->getMessages()));
			}
			
			try {
				$upload->receive();
			}
			catch (Zend_File_Transfer_Exception $e)
			{
				throw new Exception('Bad image data: '.$e->getMessage());
			}
			$Imagename = $upload->getFileName('image_name',false);
			
			
			require_once 'Zend/Filter/ImageSize.php';
			require_once 'Zend/Filter/ImageSize/Strategy/Crop.php';
			
			//echo $imgwithpath = $imgwithpath.$Imagename;
			
			$filter = new Zend_Filter_ImageSize();
			$output = $filter->setHeight(100)
							 ->setWidth(100)
							 ->setThumnailDirectory($imgwithpath)
							 ->setOverwriteMode(Zend_Filter_ImageSize::OVERWRITE_ALL)
							 ->setStrategy(new Zend_Filter_Imagesize_Strategy_Crop())
							 ->filter($imgwithpath.$Imagename);
				
    		/*
    		 * * * * * * * * * * * * * * * *
    		 *   IMAGE UPLOADING SECTION END
    		 * * * * * * * * * * * * * * * *
    		 */
    		// calling model db to insert values
    		$helpadd = new Admin_Model_DbTable_Imagegallery();
    		$hid=$helpadd->addImage($page_help_id,$image_title,$desc,$Imagename,$sortorder,$status);
    			
    		$this->_redirect('Admin/Imagegallery/index/id/'.$this->view->Ecode($page_help_id).'/st/1');
    	}
    }

    public function editAction()
    {
    	$id=$this->view->Dcode($this->_getParam('id')); // Retriving the id
    	if ($this->getRequest()->isPost())
    	{
    		 
    		 
    		$formData = $this->getRequest()->getPost();
    		 
    		 
    		$page_help_images_id = $formData['page_help_images_id'];
    		$page_help_id = $formData['page_help_id'];
    		$image_title = $formData['image_title'];
    		$desc = $formData['desc'];
    		$sortorder = $formData['sortorder'];
    		$status = $formData['status'];
    	
    			
    		 
    		// calling model db to insert values (Planfeatures.php)
    		$helpupdate = new Admin_Model_DbTable_Imagegallery();
    		$helpupdate->UpdateImage($page_help_images_id,$page_help_id,$image_title,$desc,$sortorder,$status);
    		 
    		$this->_redirect('Admin/Imagegallery/index/id/'.$this->view->Ecode($page_help_id).'/st/2');
    		 
    	}
    	else
    	{
    		$imageedit = new Admin_Model_DbTable_Imagegallery();
    		$this->view->imgedit = $imageedit->RetriveImageValues($id); // Calling values to display
    	}
    }

    public function deleteAction()
    {
        $page_help_id=$this->_getParam('pageid');
        $id=$this->_getParam('id');
	   	$pss = new Admin_Model_DbTable_Imagegallery();
    	$this->view->fvalues = $pss->deleteimage($id);
    	$this->_redirect('Admin/Imagegallery/index/id/'.$this->view->Ecode($page_help_id).'/st/3');
    }


}









