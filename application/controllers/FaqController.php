<?php

class FaqController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
        $this->_helper->layout()->disableLayout();
        
        $faqdb = new Application_Model_DbTable_Faq();
        $this->view->faqlist = $faqdb->listfaq();
    }


}

