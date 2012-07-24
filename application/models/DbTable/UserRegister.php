<?php

class Application_Model_DbTable_UserRegister extends Zend_Db_Table_Abstract
{

    protected $_name = 'hosted_facilities';
	
	public function addUser($hf_organization,$hf_facility_identifier,$cusid,$hf_facility_suffix,$hf_facility_name,$hf_facility_lname,$hf_speciality,$dashboard_password,$dashboard_password_confirm,$hf_email,$hf_address,$hf_city,$hf_state,$hf_zip,$hf_country,$hf_phone,$hf_fax,$hf_tax_id,$hf_npi,$id,$apid,$bpcost,$pcost,$setupfee,$totalfee)
	{
	   
	    
		$db = Zend_Db_Table::getDefaultAdapter();
		
		/*
		 * Checking the any other databse is created with given facility name in mysql schema
		 * Query : SELECT count(SCHEMA_NAME) FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'test';
		 */
		
		
		/*
		 * fetching active db server and backup db server details
		 * 
		 */
		
		$gndb = new Application_Model_DbTable_General();
		
		$dbserver = $gndb->activedbserver();
		$backupserver = $gndb->activebackupdbserver();
		
		$mailuserpwd = $dashboard_password;
		$dashboard_password = sha1($dashboard_password);
		$data = array(
		        'customer_id' => $cusid,
		        'hf_organization'=>$hf_organization,
				'hf_facility_identifier' => $hf_facility_identifier,
		        'hf_facility_suffix'=>$hf_facility_suffix,
				'hf_facility_name' => addslashes($hf_facility_name),
		        'hf_facility_lname'=> addslashes($hf_facility_lname),
				'hf_speciality' => addslashes($hf_speciality),
				'dashboard_password' => $dashboard_password,
				'hf_email' => addslashes($hf_email),
				'hf_address' => addslashes($hf_address),
				'hf_city' => addslashes($hf_city),
				'hf_state' => addslashes($hf_state),
				'hf_zip' => addslashes($hf_zip),
				'hf_country' => addslashes($hf_country),
				'hf_phone' => addslashes($hf_phone),
				'hf_fax' => $hf_fax,
				'hf_tax_id' => $hf_tax_id,
				'hf_npi' => $hf_npi,
		        'reg_date'=>date('Y-m-d'),
		        'hosted_server'=>$dbserver,
		        'db_server'=>$dbserver,
		        'backup_db_server'=>$backupserver
		);
		
		$sc = Zend_Db_Table::getDefaultAdapter();

		/*
		 * Checking if the table is facility is created already or not. Important for registration
		 */
		$select = $sc->select()
		->from(array('s'=>'INFORMATION_SCHEMA.SCHEMATA'),array("SCHEMA_NAME"=>"COUNT(s.SCHEMA_NAME)"))
		->where('s.SCHEMA_NAME="hostedemr_'.$hf_facility_identifier.'"');
		$row = $db->fetchRow($select);
		
		if ($row['SCHEMA_NAME']!=0)
		{
			return $uid="schemaexist";
			exit;
		}	
		
		
		/*
		 * Checking dashboard userid already exist or not
		 */
		$db = Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
		->from(array('h'=>'hosted_facilities'),array("hf_email"=>"COUNT(h.hf_email)"))
		->where('h.hf_email="'.$hf_email.'"');
		$row = $db->fetchRow($select);
		if ($row['hf_email']!=0)
		{
			return $uid="dashboarduserid";
			exit;
		}
		
         //////////////////////////////////////////////////////////		
		$numRows = $db->insert('hosted_facilities', $data);
		//die;
		$uid=$db->lastInsertId();
		
		$sess = new Zend_Session_Namespace('user');
		$sess->duser = $row['hf_email'];
		$sess->hf_id = $uid;
		
		
		$data = array(
				'hf_id' => $uid,
				'acl_resource' => 'Profile,Changepassword,Plan,Products,Invoice,Backup',
				'acl_action'=>'18,17,16,13,15,14,11,19,20'
		
		);
		$numRows = $db->insert('acl_user_setting', $data);
		
		
		/*
		 * Sending Mail with User Login Details
		*/
		
		/*
		 * Retriving subject and content from template - sec : new_user_register
		 */
		
		$gn = new Application_Model_DbTable_General();
		$emldata = $gn->emailtemplate('new_user_register');
		
		$MailLegal = new Zend_Session_Namespace('maillegal');
		$mailbottom=$MailLegal->maillegal;
		$emailbody = $emldata['content'];
		$emailbody = str_replace('__name__', $hf_facility_name, $emailbody);
		$emailbody = str_replace('__email__', $hf_email, $emailbody);
		$emailbody = str_replace('__userpwd__', $mailuserpwd, $emailbody);
		
		$emailbody=$emailbody.$mailbottom;

		$emailto = trim($hf_email);
		$nameto = $hf_facility_name;

		$config = array('ssl' => 'tls', 'port' => 587, 'auth' => 'login', 'username' => 'pradeep@zhservices.com', 'password' => 'pradulmon');
		$transport = new Zend_Mail_Transport_Smtp('smtp.gmail.com', $config);
		
				
		$mail = new Zend_Mail();
		$mail->setType(Zend_Mime::MULTIPART_RELATED);
		//$mail->setBodyText('Invoice Details attached');
		$mail->setBodyHtml($emailbody);
		$mail->setFrom('pradeep@zhservices.com', 'ZH Healthcare');
		$mail->addTo($emailto, $nameto);
		$mail->setSubject($emldata['Subject']);
		 
		try
		{
			//$mail->send($transport);
		}
		catch(Zend_Exception $e)
		{
		    
		}
		
		
		if($apid=='')
		{
		   
		    $sess = new Zend_Session_Namespace('user');
		    $sess->step='compare';
		    return $uid;
		}
		return $this->InsertCart($apid,$id,$uid);
		//die;
		/*
		 * Sending Mail with User Login Details End
		*/
		
		
		
		/*
		 * Adding Details to customer_selected_plan
		 * This table contains the customer selected plan details and payment status
		 * The Plan features will insert into customer_selected_plan_features after this action
		 */
		
		/*
		 * Retriving Plan Name
		 */
		
		// PROVIDERS SELECTED BY CUSTOMER
		
		
		
	}
	public function InsertCart($provider,$id,$hf_id)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
		
	     $id=base64_decode($id);
	    
	   
	 
	    /*
	     * Collecting User details
	     */
	    $gnDb = New Application_Model_DbTable_General();
	    $userdetails=$gnDb->identifierdetails($hf_id);
	    
	    
	    $uid = $hf_id;
	    $hf_email = $userdetails['hf_email'];
	   
	   
	    
	    $select = $db->select()
	    ->from(array('hosted_plans'),array('hp_name','discount','discount_start_date','discount_end_date','bundle_discount_type','bundle_discount_per_cost','bundle_discount_per_setup','bundle_cost'))
	    ->where('hp_id='.$id);
	    
	  
	    $row=$db->fetchRow($select);
	    $planname=$row['hp_name'];
	    $discount=$row['discount'];
	    $discount_start_date=$row['discount_start_date'];
	    $discount_end_date=$row['discount_end_date'];
	    
	    $bd_type = $row['bundle_discount_type'];
	    //	echo "<br>";
	    $bd_dpc = $row['bundle_discount_per_cost'];
	    //echo "<br>";
	    $db_dps=$row['bundle_discount_per_setup'];
	    //	echo "<br>";
	    
	    
	   
	    // Calcuating One Time Payment and Monthely Payment
	    
	    $one_time_payment=0;
	    $monthly_payment=0;
	    $discount_amt=0;
	    $productsetupfee=0;
	    $PlanCostTotalDiscount=0;
	    $PlanSetupTotalDiscount=0;
	    $plancost=0;
	    $plansetupfee=0;
	    $select = $db->select()
	    -> from(array('p'=>'products'),array('sum(p.cost) as pcost','sum(p.setup_fee) as setupcost'))
	    ->join(array('pp'=>'plan_products'),'pp.idproducts=p.idproducts')
	    -> where('pp.idplan='.$id);
	    //$otm = $db->fetchRow($select);
	    	
	    $sql = 'select cost,setup_fee,provider_cost_nature,provider_setup_nature from products p ,plan_products pp where pp.idplan='.$id.' and pp.idproducts=p.idproducts';
	    
	    $PlanTotal = $db->fetchAll($sql);
	    /*
	     * The follwoing section is to calcualte weather the product price is incrementing with additional provider or not.
	    * Based on that product cost and setup fee calculating for the plan with selected provider
	    */
	    foreach($PlanTotal as $PT)
	    {
	    	// Cost Section
	    	if($PT['provider_cost_nature']==1)//increment with provider
	    	{
	    		$plancost = $plancost + $PT['cost'] * $provider;
	    	}
	    	if($PT['provider_cost_nature']==0)//increment with provider
	    	{
	    		$plancost = $plancost + $PT['cost'];
	    	}
	    	// Setup Fee section
	    	if($PT['provider_setup_nature']==1) // increment with provider
	    	{
	    		$plansetupfee = $plansetupfee + $PT['setup_fee'] * $provider;
	    	}
	    	if($PT['provider_setup_nature']==0) // increment with provider
	    	{
	    		$plansetupfee = $plansetupfee + $PT['setup_fee'];
	    	}
	    
	    }
	    
	    	
	    
	    if($bd_type==1) // if in %
	    {
	    	$monthly_payment = $plancost - $plancost * $bd_dpc / 100;
	    	 
	    	$one_time_payment = $plansetupfee - $plansetupfee * $db_dps / 100;
	    	 
	    	$PlanCostTotalDiscount = $plancost * $bd_dpc / 100;
	    	$PlanSetupTotalDiscount = $plansetupfee * $db_dps / 100;
	    }
	    if($bd_type==2) // if in price
	    {
	    	$monthly_payment = ($plancost) - ($bd_dpc*$provider);
	    	$one_time_payment = ($plansetupfee)-($db_dps*$provider);
	    		
	    	$PlanCostTotalDiscount = $bd_dpc * $provider ;
	    	$PlanSetupTotalDiscount = $db_dps * $provider;
	    }
	    
	    
	    
	    
	    //	echo $PlanCostTotalDiscount;
	    //	echo "<br>";
	    //	echo $PlanSetupTotalDiscount;
	    //die;
	    $dd=date('Y-m-d');
	    $total_discount = $PlanCostTotalDiscount + $PlanSetupTotalDiscount;
	    $total_amount = $one_time_payment + $monthly_payment;
	    
	    
	    
	    $customer_selected_plan_data = array(
	    		'plan_id' => $id,
	    		'plan_name'=> $planname,
	    		'provider_no'=>$provider,
	    		'hf_id' => $uid,
	    		'dashboard_userid' => $hf_email,
	    		'one_time_payment'=> $one_time_payment,
	    		'monthly_payment'=>$monthly_payment,
	    		'setupfee'=>$one_time_payment,
	    		'discount_percentage'=>$bd_dpc,
	    		'discount_amount'=>$total_discount,
	    		'total_payment'=>$total_amount,
	    		'created_date' => $dd,
	    		'payment_status' => 0,
	    		'payment_error_message' => "Not Proceed to Payment Gateway"
	    
	    );
	    
	
	    
	    $db->insert('customer_selected_plan', $customer_selected_plan_data);
	    $idcustomer_selected_plan=$db->lastInsertId();
	  
	    /*
	     * Updating the Plan Products into Customer Product table
	    */
	    
	    //select p.idproducts,p.product_name,p.customer_id,p.product_feature,p.cost,p.payment_term,p.product_sort_order,p.product_status from
	    //products p, plan_products pp where p.idproducts=pp.idproducts and pp.idplan=1
	    $select = $db->select()
	    ->from(array('p'=>'products',array('p.idproducts','p.category','p.product_name','p.customer_id','p.product_feature','p.cost','setup_fee','p.payment_term','p.product_sort_order','p.product_status','p.provider_cost_nature','p.provider_setup_nature')))
	    ->join(array('pp'=>'plan_products'),'pp.idproducts=p.idproducts')
	    -> where('pp.idplan='.$id);
	    $row=$db->fetchAll($select);
	    
	    
	    
	    foreach($row as $record)
	    {
	    		
	    		
	    	$customer_selected_plan_features_data = array(
	    			'hf_id' => $uid,
	    			'hp_id' => $id,
	    			'idproducts' => $record['idproducts'],
	    			'category'=>$record['category'],
	    			'product_name'=> $record['product_name'],
	    			'customer_id'=> $record['customer_id'],
	    			'product_feature' => $record['product_feature'],
	    			'cost' => $record['cost'],
	    			'setup_fee'=>$record['setup_fee'],
	    			'product_sort_order'=>$record['product_sort_order'],
	    			'product_status'=>$record['product_status'],
	    			'provider_cost_nature'=>$record['provider_cost_nature'],
	    			'provider_setup_nature'=>$record['provider_setup_nature']
	    				
	    	);
	    	$db->insert('customer_products', $customer_selected_plan_features_data);
	    		
	    }
	    /*
	     * Adding to cart
	    */
	    
	    
	    
	    $carttotal = $plancost+$plansetupfee-$total_discount;
	    
	    
	    $cartdata = array(
	    		'cartsession'=>session_id(),
	    		'plan_id' => $id,
	    		'hf_id' => $uid,
	    		'description'=>$planname." Subscription",
	    		'qty'=>$provider,
	    		'unit_price' => $plancost,
	    		'setupfee'=> $plansetupfee,
	    		'discount'=>$PlanCostTotalDiscount,
	    		'setupfee_discount'=>$PlanSetupTotalDiscount,
	    		'total'=>$carttotal,
	    		'cstatus'=>0,
	    		'cart_date' => $dd
	    
	    );
	    $db->insert('cart', $cartdata);

	 
	    return $uid;
	}
	public function UserName($uid) // Retriving Name through uid(hf_id table field)
	{
		$db = Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
    	->from(array('h'=>'hosted_facilities'),array('h.hf_facility_name'))
    	->where('h.hf_id='.$uid);
    	$row = $db->fetchRow($select);
    
    	if(!$row)
    	{
    		throw new Exception("Count not find row 1 ");
    	}
    	return $row['hf_facility_name'];
	}
	public function UserLoginInfo($uid) // Retriving Name through uid(hf_id table field)
	{
		$db = Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
		->from(array('h'=>'hosted_facilities'),array('h.hf_email','h.dashboard_password'))
		->where('h.hf_id='.$uid);
		$row = $db->fetchRow($select);
	
		if(!$row)
		{
			throw new Exception("Count not find row 2");
		}
		return $row;
	}
	public function hf_idInfo($uid) // Retriving Name through uid(hf_id table field)
	{
		$db = Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
		->from(array('h'=>'hosted_facilities'),array('h.hf_id'))
		->where('h.hf_email="'.$uid.'"');
		$row = $db->fetchOne($select);
	
		if(!$row)
		{
			throw new Exception("Count not find row 3");
		}
		return $row;
	}
	public function cleancart($hf_id)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql = 'delete from customer_invoice where hf_id='.$hf_id;
	    $db->query($sql);
	    
	    $sql = 'delete from customer_products where hf_id='.$hf_id;
	    $db->query($sql);
	    
	    $sql = 'delete from customer_selected_plan where hf_id='.$hf_id;
	    $db->query($sql);
	    
	}
}
?>

