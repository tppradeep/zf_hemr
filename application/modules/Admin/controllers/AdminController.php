<?php

class Admin_AdminController extends Zend_Controller_Action
{

    public function preDispatch()
    {
    	$auth = Zend_Auth::getInstance();
    	if (!$auth->hasIdentity()) 
    	{
    		$this->_redirect('/');
    	} else 
    	{
    		$useremail = $auth->getIdentity(); // Storing the user email
    	}
    }

    public function init()
    {
		
			
		
    }

    public function indexAction()
    {
    	/*
    	 * This function is to call the left side menu structure
    	 */
   		$menulist = new Admin_Model_DbTable_AdminUser();
    	$this->view->leftmenu = $menulist->left_side_menu();
		
    }

    public function noaccessAction()
    {
        // action body
    }


}







