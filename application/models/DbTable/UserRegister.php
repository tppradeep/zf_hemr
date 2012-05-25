<?php

class Application_Model_DbTable_UserRegister extends Zend_Db_Table_Abstract
{

    protected $_name = 'hosted_facilities';
	
	public function addUser($hf_facility_identifier,$cusid,$hf_facility_suffix,$hf_facility_name,$hf_facility_lname,$hf_speciality,$dashboard_password,$dashboard_password_confirm,$hf_email,$hf_address,$hf_city,$hf_state,$hf_zip,$hf_country,$hf_phone,$hf_fax,$hf_tax_id,$hf_npi,$id,$apid,$bpcost,$pcost,$setupfee,$totalfee)
	{
	    
		$db = Zend_Db_Table::getDefaultAdapter();
		
		/*
		 * Checking the any other databse is created with given facility name in mysql schema
		 * Query : SELECT count(SCHEMA_NAME) FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'test';
		 */
		$mailuserpwd = $dashboard_password;
		$dashboard_password = sha1($dashboard_password);
		$data = array(
		        'customer_id' => $cusid,
				'hf_facility_identifier' => $hf_facility_identifier,
		        'hf_facility_suffix'=>$hf_facility_suffix,
				'hf_facility_name' => $hf_facility_name,
		        'hf_facility_lname'=>$hf_facility_lname,
				'hf_speciality' => $hf_speciality,
				'dashboard_password' => $dashboard_password,
				'hf_email' => $hf_email,
				'hf_address' => $hf_address,
				'hf_city' => $hf_city,
				'hf_state' => $hf_state,
				'hf_zip' => $hf_zip,
				'hf_country' => $hf_country,
				'hf_phone' => $hf_phone,
				'hf_fax' => $hf_fax,
				'hf_tax_id' => $hf_tax_id,
				'hf_npi' => $hf_npi,
		        'reg_date'=>date('Y-m-d')
				
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
		
///////////////////////////////////////////////////////////		
		$numRows = $db->insert('hosted_facilities', $data);
		$uid=$db->lastInsertId();
		
		
		$data = array(
				'hf_id' => $uid,
				'acl_resource' => 'Profile,Changepassword,Plan,Products,Invoice',
				'acl_action'=>'18,17,16,13,15,14,11,19'
		
		);
		$numRows = $db->insert('acl_user_setting', $data);
		/*
		 * Sending Mail with User Login Details
		*/
		$MailLegal = new Zend_Session_Namespace('maillegal');
		$mailbottom=$MailLegal->maillegal;
		 
		$emailbody='<p><font color="#104D96" size="2" face="Verdana, Geneva, sans-serif"><p>Hi '.$hf_facility_name.',<br />
					  Welcome to HZ Healthcare. Your registration with ZH completed successfully.  Please note your access details for future reference<br />
					  User ID : '.$hf_email.'<br />
					  Password : '.$mailuserpwd.'<br />
					  If your invoice is not successful, you can login to your  account area and in pending invoice section, you can find the Invoice and can  proceed to payment. Only after the successful payment, your plan will setup and  access details will mail to you.<br />
						<br />
						<strong>Regards,<br />
						ZH Healthcare Support Team</strong></font></p>'.$mailbottom;
		 
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
		$mail->setSubject('Welcome To ZH Healthcare!');
		 
		try
		{
			$mail->send($transport);
		}
		catch(Zend_Exception $e)
		{
		    
		}
		
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
		
		$provider = $apid;
		
		$id=base64_decode($id);
		
		
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
	
		$dd=date("Y-m-d");
	
		if(($dd>$discount_start_date)&&($dd<$discount_end_date))
		{
		    $discount_per = $discount;
		}
		else
		{
		    $discount_per=0;
		}
		
		// Calcuating One Time Payment and Monthely Payment
		
		$one_time_payment=0;
		$monthly_payment=0;
		$discount_amt=0;
		$productsetupfee=0;
		$PlanCostTotalDiscount=0;
		$PlanSetupTotalDiscount=0;
		$select = $db->select()
		-> from(array('p'=>'products'),array('sum(p.cost) as pcost','sum(p.setup_fee) as setupcost'))
		->join(array('pp'=>'plan_products'),'pp.idproducts=p.idproducts')
		-> where('pp.idplan='.$id)
		-> where('p.payment_term=0');
		
		 $otm = $db->fetchRow($select);
		 $one_time_payment = $otm['pcost'] * $provider;
		 $productsetupfee = $otm['setupcost'];
		 
		
		
		if($bd_type==1 && $one_time_payment>0) // if in %
		{
		   echo $one_time_payment = $one_time_payment - $one_time_payment * $bd_dpc / 100;
		   die;
		    $productsetupfee = $productsetupfee - $productsetupfee * $db_dps / 100;
		    
		    $PlanCostTotalDiscount = $one_time_payment * $bd_dpc / 100;
		    $PlanSetupTotalDiscount = $productsetupfee * $db_dps / 100;
		}
		if($bd_type==2 && $one_time_payment>0) // if in price
		{
			$one_time_payment = $one_time_payment - $bd_dpc;
			$productsetupfee = $productsetupfee - $db_dps ;
			
			$PlanCostTotalDiscount = $bd_dpc ;
			$PlanSetupTotalDiscount = $db_dps;
		}
		
	
		
		$select = $db->select()
		-> from(array('p'=>'products'),array('sum(p.cost) as pcost','sum(p.setup_fee) as setupcost'))
		->join(array('pp'=>'plan_products'),'pp.idproducts=p.idproducts')
		-> where('pp.idplan='.$id)
		-> where('p.payment_term=1');
		
		$mp = $db->fetchRow($select);
		$monthly_payment = $mp['pcost'] * $provider;
		$productsetupfee= $productsetupfee + $mp['setupcost'];
		
		
		if($bd_type==1 && $monthly_payment>0) // if in %
		{
			$monthly_payment = $monthly_payment - $monthly_payment * $bd_dpc / 100;
			$productsetupfee = $productsetupfee - $productsetupfee * $db_dps / 100;
						
			$PlanCostTotalDiscount = $PlanCostTotalDiscount + round($monthly_payment * $bd_dpc / 100);
			$PlanSetupTotalDiscount = $PlanSetupTotalDiscount + round($productsetupfee * $db_dps / 100);
			
		}
		if($bd_type==2 && $monthly_payment>0) // if in price
		{
			$monthly_payment = $monthly_payment - $bd_dpc;
			$productsetupfee = $productsetupfee - $db_dps ;
			
			$PlanCostTotalDiscount = $PlanCostTotalDiscount + $bd_dpc ;
			$PlanSetupTotalDiscount = $PlanSetupTotalDiscount + $db_dps;
		}
		
	//	echo $PlanCostTotalDiscount;
	//	echo "<br>";
	//	echo $PlanSetupTotalDiscount;
		//die;
		
		
		$total_amount = $one_time_payment + $monthly_payment + $productsetupfee;
		
		
		if($discount_per>0)
		{
		    $discount_amt=($total_amount*$discount_per)/100;
		    $total_amount=$total_amount-$discount_amt;
		}
		
		$customer_selected_plan_data = array(
				'plan_id' => $id,
				'plan_name'=> $planname,
		        'provider_no'=>$provider,
				'hf_id' => $uid,
				'dashboard_userid' => $hf_email,
				'one_time_payment'=> $one_time_payment,
		        'monthly_payment'=>$monthly_payment,
		        'setupfee'=>$productsetupfee,
		        'discount_percentage'=>$discount_per,
		        'discount_amount'=>$discount_amt,
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
					->from(array('p'=>'products',array('p.idproducts','p.product_name','p.customer_id','p.product_feature','p.cost','setup_fee','p.payment_term','p.product_sort_order','p.product_status')))
					->join(array('pp'=>'plan_products'),'pp.idproducts=p.idproducts')
	   				-> where('pp.idplan='.$id);
		$row=$db->fetchAll($select);
		
		
		
		foreach($row as $record)
		{
			
			
			$customer_selected_plan_features_data = array(
					'hf_id' => $uid,
			        'hp_id' => $id,
					'idproducts' => $record['idproducts'],
					'product_name'=> $record['product_name'],
					'customer_id'=> $record['customer_id'],
					'product_feature' => $record['product_feature'],
					'cost' => $record['cost'],
			        'setup_fee'=>$record['setup_fee'],
					'payment_term'=>$record['payment_term'],
			        'product_sort_order'=>$record['product_sort_order'],
			        'product_status'=>$record['product_status']
					
			);
			$db->insert('customer_products', $customer_selected_plan_features_data);
			
		}
		/*
		 * Adding to cart
		 */
		
		
	
		$carttotal = $otm['pcost']+$mp['pcost']+($otm['setupcost']+$mp['setupcost']-$PlanSetupTotalDiscount);
		
		$cartdata = array(
		        'cartsession'=>session_id(),
		        'plan_id' => $id,
				'hf_id' => $uid,
		        'description'=>$planname." Subscription",
		        'qty'=>$provider,
				'unit_price' => $otm['pcost']+$mp['pcost'],
		        'setupfee'=> $otm['setupcost']+$mp['setupcost'],
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
}
?>

