<?php

class Admin_LogoutController extends Zend_Controller_Action
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
    }

    public function indexAction()
    {
        // action body
			
			$session = new Zend_Session_Namespace('MyNamespace');
 			unset($session->username);
 			Zend_Auth::getInstance()->clearIdentity();
			$this->_redirect('/');
		 	Zend_Session::destroy(true);
			
			$menu = new Admin_Model_DbTable_AdminUser();
			$this->view->menustructure = $menu->LeftSideMenu();
		
    }


}
?>

