<?php

class User_InboxController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
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
         $sess = new Zend_Session_Namespace('user');
         
         $inboxdb = new user_Model_DbTable_Inbox();
         $this->view->inbox = $inboxdb->listmessage($sess->hf_id);
    }

    public function viewAction()
    {
        $this->_helper->layout()->disableLayout();
        $this->_helper->layout->setLayout('ajax');
        $messid = $this->_getParam('id');
        $inboxdb = new user_Model_DbTable_Inbox();
        $this->view->inbox = $inboxdb->viewmessage($messid);
    }


}



