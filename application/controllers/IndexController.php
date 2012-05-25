<?php

class IndexController extends Zend_Controller_Action
{

    public function preDispatch()
    {
    	echo $loginError = $this->view->Dcode($this->_getParam('emes'));
    	$this->view->loginerror = $loginError;
    	$this->view->render('dashboardlogin/dashboardlist.phtml');
    }

    public function init()
    {
        $emptycartjunk = new Application_Model_DbTable_General();
        $empty = $emptycartjunk->emptycartjunk();
    }

    public function indexAction()
    {
		$cmsObj = new Application_Model_DbTable_Index();
		//$this->view->index = $cmsObj->fetchAll();
		/*
		 * catching login error
		 */
		$this->view->index = $cmsObj->getcms('homepage');
		
		//$loginError = $this->view->Dcode($this->_getParam('emes'));
		//$this->view->loginerror = $loginError;
		
		$plans = new Application_Model_DbTable_Index();
		$this->view->plans = $plans->planlist();
		
    }

    public function logoutAction()
    {
        Zend_Auth::getInstance()->clearIdentity();
      	$sess = new Zend_Session_Namespace('user');
     	$sess->duser="";
 		unset($sess->duser);
		Zend_Session::destroy(true);
		
		$this->_redirect('Index');
    }


}



