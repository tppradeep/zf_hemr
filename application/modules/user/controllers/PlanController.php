<?php

class User_PlanController extends Zend_Controller_Action
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
        // action body
        $plan = new user_Model_DbTable_Plan();
        $this->view->sp_f_list = $plan->listplanfeatures();
       
        $plandtd = $plan->listplanfeatures();
        $this->view->productdetails=$plan->productdetails();
        
        $planname = new User_Model_DbTable_Plan();
        $this->view->planname = $planname->planname();
    }


}

