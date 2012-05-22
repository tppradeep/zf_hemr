<?php

class Admin_IndexController extends Zend_Controller_Action
{
    public function preDispatch()
    {
    	$auth = Zend_Auth::getInstance();
    	if (!$auth->hasIdentity()) {
    		$this->_redirect('/');
    	} else {
    		$useremail = $auth->getIdentity();
    		//$this->view->username = $userdata->username;
    	}
    }
    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
        // action body
		
		if ($this->getRequest()->isPost()) 
		{
		
			$formData = $this->getRequest()->getPost();
		
			$uid = $formData['uid'];
			$pwd = $formData['pwd'];
			//echo $uid;
			//echo $pwd;
			$db = Zend_Db_Table::getDefaultAdapter();
			
			$adapter = new Zend_Auth_Adapter_DbTable(
                $db,
                'admin_details',
                'AdminUserId',
                'AdminPassword'
                );
			$adapter->setIdentity($formData['uid']);
            $adapter->setCredential($formData['pwd']);
			
			$auth   = Zend_Auth::getInstance();
            $result = $auth->authenticate($adapter);
 
            if ($result->isValid()) 
			{
				Zend_Session::start();
				$sess = new Zend_Session_Namespace('MyNamespace');
    			$sess->username = $uid;
				
			//	echo $userName = $sess->username;
				
				$this->_helper->FlashMessenger('Successful Login');
              	$this->_redirect('Admin/admin');
                return;
            }
		}
    }

    public function logoutAction()
    {
      // 
		
    }


}


?>




