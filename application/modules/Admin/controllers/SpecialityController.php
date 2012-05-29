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
    }

    public function addAction()
    {
        // action body
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
        // action body
    }


}






