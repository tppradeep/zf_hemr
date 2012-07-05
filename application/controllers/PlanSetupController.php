<?php

class PlanSetupController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
        
        $cmsObj = new Application_Model_DbTable_Index();
        $cms = $cmsObj->getcms('Payment Confirmation');
        
        $hf_id=base64_decode($this->_getParam('hfid'));
        $status=$this->_getParam('st');
        $invoice_no = base64_decode($this->_getParam('invno'));
       
        
        
    	$gndb = new Application_Model_DbTable_General();
		$hfemail = $gndb->facilityemail($hf_id);
		$db_server = $gndb->dbname($hfemail);
		$customer_tranid = $gndb->customer_tranid($hf_id);
		$identifierdetails = $gndb->identifierdetails($hf_id);
		
		$cms = str_replace('__name__', $identifierdetails['hf_facility_name'].' '.$identifierdetails['hf_facility_lname'], $cms);
		$cms = str_replace('__TranID__',$customer_tranid,$cms);
		
		$this->view->cms = $cms;		
		
		//$this->_helper->layout()->disableLayout();
		Zend_Loader::loadClass('Zend_Soap_Client');
					
		$servicedb = new Application_Model_DbTable_Services();
						
		$setupvalues = $servicedb->activateplansetting($hfemail,$invoice_no);
						
		
		
		// initialize SOAP client
		$options = array(
		  				'location' => 'http://www.hostedopenemr.com/installer/setup.php',
		  				'uri'      => 'urn://portal/req'
						);
			
		$tim = strtotime(gmdate("Y-m-d H:m"));
		$arr = $setupvalues;

	//	echo "<pre>";
	//		print_r($arr);
	//	echo "</pre>";
	//die;	
		try 
		{
			 $client = new Zend_Soap_Client(null, $options);   // SOAP CALL
			$result = $client->setup_new_db($arr);
			echo "<pre>";
		//	print_r($result);
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

