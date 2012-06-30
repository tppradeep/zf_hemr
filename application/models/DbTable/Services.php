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
	public function activateplansetting($hfemail)
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
	    
	    array_push($result, $userdetails);
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
	    $result[0]['dashboard_password']= base64_encode(sha1($password).substr(str_shuffle("abcdef1234567890"),0,6));
	    
	    $arr = array(array($userid,$pass,$randomvalue),$result);
	    return $arr;
	    
	    
	}
}


