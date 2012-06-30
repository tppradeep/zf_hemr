<?php

class Bootstrap extends Zend_Application_Bootstrap_Bootstrap
{
   
	function _initSession()
	{
		Zend_Session::start();
		
		$sess = new Zend_Session_Namespace('user');
		
		$customerId = new Zend_Session_Namespace('customerId');
		$customerId->customerId = 1;
		
		$Address = new Zend_Session_Namespace('address');
		$Address->address = "<b>Z&H Healthcare Solutions,LLC.</b><br>2010 Corporate Ridge, Suite 700,<br>McLean, VA 22101<br>USA<br>Phone: +1 (571) 766 8074<br>FAX:+1 (703) 345 0512";

		$MailLegal = new Zend_Session_Namespace('maillegal');
		$MailLegal->maillegal='<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>';
		
		$mailconfig = new Zend_Session_Namespace('mail');
		$mailconfig->userid='hostedopenemr@zhservices.com';
		$mailconfig->password='hostedemr';
	}
	protected function _initDatabase()
	{
		$db = new Zend_Db_Adapter_Pdo_Mysql(array(
				'host'     => 'localhost',
				'username' => 'root',
				'password' => '',
				'dbname'   => 'hosted_emr'
		));
		Zend_Registry::set('zf_db', $db);
	}
    function _initViewHelpers ()
    {
        $this->bootstrap('layout');
        $layout = $this->getResource('layout');
        $view = $layout->getView();
        $view->doctype('XHTML1_STRICT');
        $view->headMeta()->appendHttpEquiv('Content-Type', 'text/html;charset=utf-8');
        
    }
	
	
	protected function _initAutoloaders() // ##### For Module Layout changing
	{
		$this->getApplication()->setAutoloaderNamespaces(array('Galahad_'));
		return $this;
	}
	protected function _initPlugins() // ##### For Initiallizing the Layout of Modules
	{
	//««««««««  THIS FUNCTION USING TO GET DIFFERENT LAYOUT FOR MODULES  »»»»»»»»»»
		$this->bootstrap('autoloaders');
		$this->bootstrap('frontController');
	 
		$plugin = new Galahad_Controller_Plugin_Modularlayout();
		$this->frontController->registerPlugin($plugin);
	}
	
}

?>