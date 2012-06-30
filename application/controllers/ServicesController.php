<?php
require_once 'Zend/Loader.php';
class ServicesController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
     
    }

    public function soapAction()
    {
 
        $this->_helper->layout()->disableLayout();
        $server = new Zend_Soap_Server(null,
        array('uri' => 'urn://soap/zf'));
        // set SOAP service class
        $server->setClass('Application_Model_DbTable_Services');
       // handle request
        $server->handle();
    }

    public function viewsoapAction()
    {
        	
        $this->_helper->layout()->disableLayout();
   		$hfemail=$this->_getParam('uid');
   		//$hfemail='pradeep@zhservices.com';

        $gndb = new Application_Model_DbTable_General();
        // Passwords length
        $pass_len = 16;
        // Use numbers?
        $pass_num = true;
        // Use letters? (e.g. abcde)
        $pass_alpha = true;
        // Use mixed case? (e.g. AbcaBc)
        $pass_mc = true;
        // Exclude any chars from password? (e.g. oO0iI1l)
        $pass_exclude = 'oO0iI1l';
         
        $tim = strtotime(gmdate("Y-m-d H:m"));
        
        $userid = 'hostedopenemrsetup';
        $randomvalue = $gndb->generatepassword($pass_len, $pass_num, $pass_alpha, $pass_mc, $pass_exclude);
        $password = sha1('hostedopenemrsetup@123'.date("Y-m-d H",($tim-3600)).$randomvalue);
        
       
        $db_server = $gndb->dbname($hfemail);
     	$this->_helper->layout()->disableLayout();
		Zend_Loader::loadClass('Zend_Soap_Client');
		
		$servicedb = new Application_Model_DbTable_Services();
		$setupvalues = $servicedb->activateplansetting($hfemail);
	// initialize SOAP client
		$options = array(
	  				'location' => 'http://192.168.1.139/installer/installer/setup.php',
	  				'uri'      => 'urn://portal/req'
					);
		
		$tim = strtotime(gmdate("Y-m-d H:m"));
		$arr = array(array($userid,$password,$randomvalue),$setupvalues);
		
		echo "<pre>";
		print_r($arr);
		echo "</pre>";
		die;
		try {
	  		$client = new Zend_Soap_Client(null, $options);  
	  		$result = $client->setup_new_db($arr);
	  		echo "<pre>";
	  		print_r($result);
	  		echo "</pre>";
			} 
			catch (SoapFault $s) 
			{
	  			die('ERROR: [' . $s->faultcode . '] ' . $s->faultstring);
			} 
			catch (Exception $e) 
			{
	  			die('ERROR: ' . $e->getMessage());
			}
    }

    public function checkAction()
    {
        $db = new Application_Model_DbTable_Services();
        $result = $db->activateplansetting('hg@hg.com');
      //  $userdetails = $db->userdetails('pradeep@zhservices.com');
        echo "<pre>";
        print_r($result);
        echo "</pre>";
    }

    public function installAction() // not using 
    {
        $hfemail=$this->_getParam('uid');

        $gndb = new Application_Model_DbTable_General();
        // Passwords length
        $pass_len = 8;
        // Use numbers?
        $pass_num = true;
        // Use letters? (e.g. abcde)
        $pass_alpha = true;
        // Use mixed case? (e.g. AbcaBc)
        $pass_mc = true;
        // Exclude any chars from password? (e.g. oO0iI1l)
        $pass_exclude = 'oO0iI1l';
         
        $tim = strtotime(gmdate("Y-m-d H:m"));
        
        $userid = 'hostedopenemrsetup';
        $randomvalue = $gndb->generatepassword();
        $password = sha1('hostedopenemrsetup@123'.date("Y-m-d H",($tim-3600)).$randomvalue);
        
       
        $db_server = $gndb->dbname($hfemail);
     	$this->_helper->layout()->disableLayout();
		Zend_Loader::loadClass('Zend_Soap_Client');
		
		$servicedb = new Application_Model_DbTable_Services();
		$setupvalues = $servicedb->activateplansetting($hfemail);
	// initialize SOAP client
		$options = array(
	  				'location' => 'http://192.168.1.139/installer/installer/setup.php',
	  				'uri'      => 'urn://portal/req'
					);
		
		$tim = strtotime(gmdate("Y-m-d H:m"));
		$arr = array(array($userid,$password,$randomvalue),$setupvalues);
		
		try {
	  		$client = new Zend_Soap_Client(null, $options);  
	  		$result = $client->setup_new_db($arr);
	  		echo "<pre>";
	  		print_r($result);
	  		echo "</pre>";
			} 
			catch (SoapFault $s) 
			{
	  			die('ERROR: [' . $s->faultcode . '] ' . $s->faultstring);
			} 
			catch (Exception $e) 
			{
	  			die('ERROR: ' . $e->getMessage());
			}
    }


}











