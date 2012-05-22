<?php

class Viewhelp_IndexController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
        // action body
    	$module = $this->_getParam('m');
    	$sec = $this->_getParam('s');
        $dishelp = new Viewhelp_Model_DbTable_Viewhelpdb();
        $this->view->help = $dishelp->displayHelp($module, $sec);
    }


}

