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
        	
        $serdb = new Application_Model_DbTable_Services();
        $hf_id=266;
        $inv_no='ZH-2012-07-09-00160';
        $activation_status='Success';
        $activation_message='';
        $serdb->activationresult($hf_id,$inv_no,$activation_status,$activation_message);
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

    public function planconfirmAction()
    {
    	 $this->_helper->layout()->disableLayout();
	/*
    	 $hf_id = $this->_getParam('hf_id');
    	 $inv_no=$this->_getParam('inv_no');
    	 $activation_status = $this->_getParam('st');
    	 $activation_message = $this->_getParam('activation_message');
    	 
    	 
    	 if($activation_status==1)//Success
    	 {
    	     
    	     /*
    	      * Sending Mail with Plan Confiration confirmation
    	     */
    	     /*
    	      * Email Template Section
    	     
    	     $MailLegal = new Zend_Session_Namespace('maillegal');
    	     $mailbottom=$MailLegal->maillegal;
    	     
    	     $gendb = new Application_Model_DbTable_General();
    	     $userdetails = $gendb->identifierdetails($hf_id);
    	     
    	     $firstName = $userdetails['hf_facility_name'];
    	     $lastName = $userdetails['hf_facility_lname'];
    	     
    	     $emldata = $gendb->emailtemplate('plan_configuration_success');
    	     $emailsubject =  str_replace('__invoiceno__', $inv_no, $emldata['Subject']);
    	     $emailbody = $emldata['content'];
    	     $emailbody = str_replace('__invoiceno__', $inv_no, $emailbody);
    	     $emailbody = str_replace('__name__', $firstName." ".$lastName, $emailbody);
    	     
    	     $emailbody=$emailbody.$mailbottom;
    	      
    	     $InvoiceAddress		= New Application_Model_DbTable_Paymentdb();
    	     $invoiceaddress		= $InvoiceAddress->invoiceaddress_invoice(hf_id);
    	     
    	     $emailto = trim($invoiceaddress[0]['hf_email']);
    	     $nameto = $invoiceaddress[0]['hf_facility_name'];
    	      
    	     $gendb->sendmail($emailto,$nameto,$emailsubject,$emailbody);
    	     $gendb->messageadd($hf_id,addslashes($emailsubject),addslashes($emailbody));
    	     
    	     //updating the database
    	     
    	     $serviceDb = new Application_Model_DbTable_Services();
    	     $serviceDb->activationresult($hf_id,$inv_no,$activation_status,$activation_message);
    	    
    	 }
    	 else
    	 {
    	     $serviceDb = new Application_Model_DbTable_Services();
    	     $serviceDb->activationresult($hf_id,$inv_no,$activation_status,$activation_message);
    	 }*/
    }
}











