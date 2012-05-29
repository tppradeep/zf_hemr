<?php

class Admin_EmailTemplateController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
       $etdb = new Admin_Model_DbTable_EmailTemplate();
       $this->view->emaillist = $etdb->listemil();
    }

    public function addAction()
    {
        // action body
    }

    public function editAction()
    {
        $etdb = new Admin_Model_DbTable_EmailTemplate();
        
        $templateid=$this->view->Dcode($this->_getParam('id'));
        if ($this->getRequest()->isPost())
        {
            $formData = $this->getRequest()->getPost();
            unset($formData['Submit']);
            $etdb->updatetemplate($formData);
            $this->_redirect('Admin/EmailTemplate/index/st/2');
        }
        else
        {
            $this->view->TmpDtd = $etdb->templatedtd($templateid);
        }
    }


}





