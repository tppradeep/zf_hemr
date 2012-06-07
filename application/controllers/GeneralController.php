<?php

class GeneralController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
        // action body
    }

    public function privacyPolicyAction()
    {
        $this->_helper->layout->setLayout('Ajax');
        $cmsObj = new Application_Model_DbTable_Index();
        $this->view->cms = $cmsObj->getcms('Privacy Policy');
    }

    public function termsOfUseAction()
    {
        $this->_helper->layout->setLayout('Ajax');
        $cmsObj = new Application_Model_DbTable_Index();
        $this->view->cms = $cmsObj->getcms('Terms of Use');
    }

    public function legalDocumentationAction()
    {
        $this->_helper->layout->setLayout('Ajax');
        $cmsObj = new Application_Model_DbTable_Index();
        $this->view->cms = $cmsObj->getcms('Legal Documentation ');
    }


}







