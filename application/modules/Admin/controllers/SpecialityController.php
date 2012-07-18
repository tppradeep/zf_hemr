<?php

class Admin_SpecialityController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
       $spdb = new Admin_Model_DbTable_Speciality();
       $this->view->listsp = $spdb->listspeciality();
       $this->view->st=$this->_getParam('st');
    }

    public function addAction()
    {
        $spdb = new Admin_Model_DbTable_Speciality();
	    if ($this->getRequest()->isPost())
	        {
	            $formData = $this->getRequest()->getPost();
	            unset($formData['Submit']);
	            $spdb->addspeciality($formData);
	            $this->_redirect('Admin/Speciality/index/st/1');
	        }
    }

    public function editAction()
    {
     $spdb = new Admin_Model_DbTable_Speciality();
        
        $id=$this->view->Dcode($this->_getParam('id'));
        if ($this->getRequest()->isPost())
        {
            
            $formData = $this->getRequest()->getPost();
            unset($formData['Submit']);
            $spdb->updatespeciality($formData);
            $this->_redirect('Admin/Speciality/index/st/2');
        }
        else
        {
            $this->view->SpDtd = $spdb->specialitydtd($id);
        }
    }

    public function deleteAction()
    {
         $spdb = new Admin_Model_DbTable_Speciality();
         $id=$this->_getParam('id');
         $spdb->deletespeciality($id);
         $this->_redirect('Admin/Speciality/index/st/3');
    }

    public function deleteallAction()
    {
    	$id=$this->_getParam('id');
    	$delids = explode(",",$id);
    	
	   	$pss = new Admin_Model_DbTable_Speciality();

	   	foreach($delids as $id)
	   	{
	   	    if($id<>'0')
	   	    	$this->del = $pss->deletespeciality(base64_decode($id));
	   	}
    	
    	$this->_redirect('Admin/Speciality/index/st/3');
    }
    
}







