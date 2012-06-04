<?php

class User_Model_DbTable_Plan extends Zend_Db_Table_Abstract
{

    protected $_name = 'hosted_facilities';

	public function listplanfeatures()
	{
		$sess = new Zend_Session_Namespace('user');
		$hf_id=$sess->hf_id;
		
		$db = Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
		->from(array('customer_selected_plan'),array('idcustomer_selected_plan','plan_id','plan_name','provider_no'))
		->where('hf_id="'.$hf_id.'"');
		return $plandtd = $db->fetchRow($select);
		
		
	
		//echo "<pre>";
		//print_r($plandtd);
		//die;
	}
	public function productdetails()
	{
	    $pdtd = $this->listplanfeatures();
	    $pid = $pdtd['plan_id'];
	    
	   
	    $sess = new Zend_Session_Namespace('user');
	    $hf_id=$sess->hf_id;
	    
		//select p.idproducts,p.product_name,p.product_feature,p.cost,from products p, plan_products pp where pp.idproducts=p.idproducts and pp.idplan=1
		$db = Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
		-> from(array('p'=>'customer_products'),array('p.idproducts','p.product_name','p.product_feature','p.cost','setup_fee'))
		-> where('p.hf_id='.$hf_id)
		-> where('p.hp_id='.$pid);
		 
		$row = $db->fetchAll($select);
		 
		if (!$row)
		{
			throw new Exception("Could not find row");
		}
		return $row;
	}
	public function planname()
	{
		$sess = new Zend_Session_Namespace('user');
		$hf_id=$sess->hf_id;
		
		$db = Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
		->from(array('customer_selected_plan'),array('plan_name','provider_no','plan_activated_date'))
		->where('hf_id="'.$hf_id.'"');
		return $db->fetchRow($select);
	}
}

