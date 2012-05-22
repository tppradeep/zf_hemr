<?php

class Admin_Model_DbTable_Updateinvoice extends Zend_Db_Table_Abstract
{

    protected $_name = 'customer_products';

    public function invoicedtd($invid)
    {
       
    	//select * from products where ProductType in (1,3) and product_status='1' and idproducts != 1
    	 
    	$db = Zend_Db_Table::getDefaultAdapter();
    	$select = $db->select()
    	->from(array('customer_invoice'),array('idcustomer_invoice','invoice_number','plan_id','hf_id','cartsessionid','subscription_amount','setupfee','discount_amount'))
    	->where('invoice_number ="'.$invid.'"');

    	$returnarray = array();
    	$invdtd = $db->fetchrow($select);
    	
    	
    	$plan_id=$invdtd['plan_id'];
    	$hf_id=$invdtd['hf_id'];
    	
    	
    	$select3 = $db->select()
    	->from(array('customer_selected_plan'),array('plan_name','provider_no'))
    	->where('plan_id ="'.$plan_id.'"');
    	$planname = $db->fetchRow($select3);
    	
    	$returnarray[]=$planname;
    	$returnarray[]=$invdtd;
    	
    	$select2 = $db->select()
    				->from(array('customer_products'),array('idcustomer_products','hf_id','hp_id','idproducts','product_name','cost','setup_fee'))
    				->where('hp_id ="'.$plan_id.'"')
    				->where('hf_id='.$hf_id);
    	
    	$productids = $db->fetchAll($select2);
    	
    	$returnarray[]=$productids;
    	
    	return $returnarray;
    	
    }
    public function updateprice($formData)
    {
      //  echo "<pre>";
      //  print_r($formData);
      //  echo "</pre>";
        $discount_amount = $formData['discount_amount'];
        $invoiceno = $formData['invoiceno'];
        
        $db = Zend_Db_Table::getDefaultAdapter();
        
        $data = array(
        		'discount_amount' => $discount_amount
        );
      
			$db->update('customer_invoice', $data,'invoice_number = "'.$invoiceno.'"');
        
    }
}

