<?php

class User_Model_DbTable_Invoice extends Zend_Db_Table_Abstract
{

    protected $_name = 'customer_invoice';

	public function PaidInvoiceList()
	{
		$sess = new Zend_Session_Namespace('user');
		$hf_id=	$sess->hf_id;

		
		$db = Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
		->from(array('customer_invoice'),array('idcustomer_invoice', 'invoice_number','invoice_date','payment_date','amount','setupfee','transaction_id'))
		->order('payment_date DESC')
		-> where('payment_status="COMPLETED"')
		-> where ('hf_id='.$hf_id.'');
				
		$row = $db->fetchAll($select);
		
		if (!$row)
		{
		
		}
		return $row;
	}
	public function OutstandingInvoiceList()
	{
		$sess = new Zend_Session_Namespace('user');
		$hf_id=	$sess->hf_id;
	
	
		$db = Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
		->from(array('customer_invoice'),array('idcustomer_invoice', 'invoice_number','invoice_date','payment_date','amount','setupfee','transaction_id'))
		->order('payment_date DESC')
		-> where('payment_status!="COMPLETED"')
		-> where ('hf_id='.$hf_id.'');
	
		$row = $db->fetchAll($select);
	
		if (!$row)
		{
			//$row=0;
		}
		return $row;
	}
}

