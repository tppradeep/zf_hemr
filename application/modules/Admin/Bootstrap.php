<?php
require_once 'acl/acl.php';
class Admin_Bootstrap extends Zend_Application_Module_Bootstrap
{
    // put module related bootstrap here
    // note: these init methods AND init methods from other modules
    // are unconditionally executed on every request, not only requests
    // for the specific module
	function _initViewHelpers ()
	{
		$view = new Zend_View();
		$viewRenderer = new Zend_Controller_Action_Helper_ViewRenderer();
	 
		$view->addHelperPath('ZendX/JQuery/View/Helper/', 'ZendX_JQuery_View_Helper');
		$viewRenderer->setView($view);
		Zend_Controller_Action_HelperBroker::addHelper($viewRenderer);
	}
	
	
}
?>