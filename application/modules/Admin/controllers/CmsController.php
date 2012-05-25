<?php

class Admin_CmsController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
       $cmsdb = new Admin_Model_DbTable_Cms();
       $this->view->cmslist = $cmsdb->listcms();
       $this->view->st=$this->_getParam('st');
    }

    public function addAction()
    {
        // action body
    }

    public function editAction()
    {
         $cmsdb = new Admin_Model_DbTable_Cms();
         
         if ($this->getRequest()->isPost())
         {
             $formData = $this->getRequest()->getPost();
             $cmsdb->updatecms($formData);
             $this->_redirect('Admin/Cms/index/st/2');
         }
         else
         {
             $id=$this->view->Dcode($this->_getParam('id')); // Retriving id from query string
             $this->view->cmsview = $cmsdb->viewcms($id); // Calling values to display
         }
    }


}





