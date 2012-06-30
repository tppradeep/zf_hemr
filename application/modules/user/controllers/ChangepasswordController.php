<?php

class User_ChangepasswordController extends Zend_Controller_Action
{

    public function init()
    {
        $this->view->checkacl('0','0','0','1'); // Just for initiallization for helper call
        $this->view->checkaclresource('0','0',0); // Just for initiallization for helper call
        $sess = new Zend_Session_Namespace('user');
        if($sess->duser=="")
        {
        	$this->_redirect('Index');
        	exit;
        }
    }

    public function indexAction()
    {
        if ($this->getRequest()->isPost()) 
		{
			
			$formData = $this->getRequest()->getPost();
			
				$c_pwd = $formData['c_pwd'];
				$n_pwd = $formData['n_pwd'];
				$cn_pwd = $formData['cn_pwd'];
				
				$user = new user_Model_DbTable_Changepassword();
				$st=$user->changepassword($c_pwd,$n_pwd,$cn_pwd);
				$this->view->status=$st;
		}
    }


}

