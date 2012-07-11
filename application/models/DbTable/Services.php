<?php

class Application_Model_DbTable_Services extends Zend_Db_Table_Abstract
{

    protected $_name = 'hosted_facility';

	public function listfacility($dbname)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql = 'select hf_id,customer_id,hf_facility_identifier,db_server,backup_db_server,hf_backup_password from hosted_facilities where backup_db_server="'.$dbname.'"';
	    return $db->fetchAll($sql);
	}
	public function providerno($hf_facility_identifier)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql ='select hf.hf_facility_identifier,csp.provider_no from customer_selected_plan csp, hosted_facilities hf where csp.hf_id=hf.hf_id and hf.hf_facility_identifier="'.$hf_facility_identifier.'"';
	    return $db->fetchRow($sql);
	}
	public function userdetails($hfemail)
	{
		$db = Zend_Db_Table::getDefaultAdapter();
			
		$sql ='select hf_id,hf_facility_identifier,hf_email,hf_organization,hf_facility_suffix,hf_facility_name,hf_facility_lname,hf_speciality,dashboard_password,hf_phone,hf_address,hf_state,hf_city,hf_zip,hf_country,db_server,backup_db_server from hosted_facilities where hf_email="'.$hfemail.'"';
		return $db->fetchRow($sql);
	}
	public function activateplan($hfemail,$planid)
	{
	    // Need to call the setting service url
	}
	public function activateplansetting($hfemail,$invoice_no)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    
	  	  $sql = 'select cp.idproducts,p.emrfeature from customer_selected_plan csp 
				right join customer_products cp on csp.hf_id=cp.hf_id
				right join products p on cp.idproducts = p.idproducts
				where csp.dashboard_userid="'.$hfemail.'" and csp.plan_status=1 and p.emrfeature!="0"';
	    $productsrequiredtoenable = $db->fetchAll($sql);
	    
	    $userdetails = $this->userdetails($hfemail);
	    
	    
	    $result = array();
	 //   $result[] = array(0);
	   $invdtd = array("inv_no"=>$invoice_no); 
	   
	  $userdetails= array_merge((array)$userdetails, (array)$invdtd);
	   
	    array_push($result, $userdetails);
	   // array_pust($result,)
	    array_push($result, $productsrequiredtoenable);
	    
	    $tim = strtotime(gmdate("Y-m-d H:m"));
	    $userid = 'hostedopenemrsetup';
	    $randomvalue = substr(md5(rand().rand()), 0, 8);
	    
	    
	    $gndb = new Application_Model_DbTable_General();
	    $i=1;
	    do {
	        
	        $pass = sha1('hostedopenemrsetup@123'.date("Y-m-d H",($tim-3600)).$randomvalue);
	        $i = $gndb->checkautonumer($pass);
	        
	    }while($i!=0);
	   
	    // Just of encoding the password to pass. the end section knows how to dcode it.
	    $password = $result[0]['dashboard_password'];
	    $result[0]['dashboard_password']= base64_encode($password.substr(str_shuffle("abcdef1234567890"),0,6));
	   // $result[0]['dashboard_password']= $result[0]['dashboard_password'];
	    
	    $arr = array(array($userid,$pass,$randomvalue),$result);
	    
	
	    return $arr;
	}
	public function activationresult($hf_id,$inv_no,$activation_status,$activation_message)
	{
	    
	    $db = Zend_Db_Table::getDefaultAdapter();
	    
	    if($activation_status=='Success')
	    {
	        $activation_status=1;
	    }
	    else
	    {
	        $activation_status=0;
	    }
	    $sql = 'update customer_invoice set activation_status='.$activation_status.',activation_message="'.$activation_message.'" where invoice_number="'.$inv_no.'" and hf_id ='.$hf_id;
	    $db->query($sql);
	    
	    if($activation_status==1)//Success
	    {
	    
	    	/*
	    	 * Sending Mail with Plan Confiration confirmation
	    	*/
	    	/*
	    	 * Email Template Section
	    	*/
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
	    	$invoiceaddress		= $InvoiceAddress->invoiceaddress_invoice($inv_no);

	    	$emailto = trim($invoiceaddress[0]['hf_email']);
	    	$nameto = $invoiceaddress[0]['hf_facility_name'];
	    	 
	    	$gendb->sendmail($emailto,$nameto,$emailsubject,$emailbody);
	    	$gendb->messageadd($hf_id,addslashes($emailsubject),addslashes($emailbody));
	    
	    	return 1;
	    		
	    }
	    else
	    {
	    	//$serviceDb = new Application_Model_DbTable_Services();
	    	//$serviceDb->activationresult($hf_id,$inv_no,$activation_status,$activation_message);
	    }
	}
}


