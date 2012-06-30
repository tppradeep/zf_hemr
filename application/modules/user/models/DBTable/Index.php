<?php

class user_Model_DbTable_Index extends Zend_Db_Table_Abstract
{

   // protected $_name = 'hosted_facilities';
	public function UserName($uid) // Retriving Name through uid(hf_id table field)
	{
		$db = Zend_Db_Table::getDefaultAdapter();
		$sql = "select hf_facility_suffix,hf_facility_name,hf_facility_lname from hosted_facilities where hf_email='".$uid."'";
			
		$row = $db->fetchRow($sql);
	
		if(!$row)
		{
			throw new Exception($e);
		}
		return $row['hf_facility_suffix'].'&nbsp;'.$row['hf_facility_name'].'&nbsp;'.$row['hf_facility_lname'];
	}
	
	public function LastPayment_invoice($hf_id)
	{
		
		/*
		 * SELECT idcustomer_invoice,invoice_number,amount,payment_date FROM hosted_emr.customer_invoice
		 *  where hf_id=1 and payment_status='1'
		 */
		$hf=new Zend_Session_Namespace("user");
		$hf_id=$hf->hf_id;
		$db = Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
		->from(array('customer_invoice'),array('idcustomer_invoice','invoice_number','amount','invoice_date'))
		->where('hf_id='.$hf_id)
		->where('payment_status="Completed"')
		->order('payment_date DESC');
		
		$row = $db->fetchRow($select);
		if(is_array($row))
		{
			return $row;
		}
		else
		{
			return "There is no paid invoice on your account till now.";
		}
	}
	public function Outstanding_invoice()
	{
		/*
		 * SELECT idcustomer_invoice,invoice_number,amount,payment_date FROM hosted_emr.customer_invoice
		*  where hf_id=1 and payment_status='1'
		*/
		$hf=new Zend_Session_Namespace("user");
		$hf_id=$hf->hf_id;
		$db = Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
		->from(array('customer_invoice'),array('idcustomer_invoice','invoice_number','amount','invoice_date'))
		->where('hf_id='.$hf_id)
		->where('payment_status<>"Completed"');
		
		$row = $db->fetchAll($select);
		if(!$row)
		{
			return "There is No Outstanding Invoice on your account.";
		}
		else
		{
			if(is_array($row))
			{
				return $row;
			}
			else
			{
				return "There is No Outstanding Invoice on your account.";
			}
		}
	}
	/*
	 * Plan basic info to display user dashboard
	 */
	public function BasicPlanInfo()
	{
		/*
		 * select plan_name,plan_status,plan_activated_date,plan_disabled_date,
		 * plan_expired_date from customer_selected_plan where hf_id=30
		 */
		$hf=new Zend_Session_Namespace("user");
		$hf_id=$hf->hf_id;
		$db = Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()	
					 ->from(array('customer_selected_plan'),array('plan_name','plan_status','plan_activated_date','plan_disabled_date','plan_expired_date'))
					 ->where('hf_id='.$hf_id);
		$row = $db->fetchRow($select);
		return $row;
		
	}
}

