<?php

class TestsidebarController extends Zend_Controller_Action
{

    public function preDispatch()
    {
   $this->view->render('testsidebar/_sidebar.phtml');
    
    }

    public function indexAction()
    {
        // action body
    }

    public function listusersAction()
    {
        // action body
		
    }


}



