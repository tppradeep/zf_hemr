<?php

class User_Model_DbTable_Ledgerbalance extends Zend_Db_Table_Abstract
{

    protected $_name = 'customer_invoice';
	
    public function ledgerbalance()
    {
    	$sess = new Zend_Session_Namespace('user');
    	$hf_id=	$sess->hf_id;
    	
    	$db = Zend_Db_Table::getDefaultAdapter();
    	$select = $db->select()
    	->from(array('customer_invoice'),array('idcustomer_invoice', 'invoice_number','invoice_date','payment_date','amount','setupfee','payment_status','particulars','transaction_id'))
    	->order('invoice_date DESC')
    	->order('invoice_number DESC')
    	-> where ('hf_id='.$hf_id.'');
    	
    	$row = $db->fetchAll($select);
    	
    	if (!$row)
    	{
    		throw new Exception("Error");
    	}
    	return $row;
    }

}

