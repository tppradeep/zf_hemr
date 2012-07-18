<?php

class Admin_Model_DbTable_Paypal extends Zend_Db_Table_Abstract
{

    protected $_name = 'paypal_setting';

	public function listdetails()
	{
	   $db = Zend_Db_Table::getDefaultAdapter();
	   
	   $sql = 'select * from paypal_setting';
	   return $db->fetchAll($sql);
	}
	public function paypaldtd($id)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql = 'select id,username,password,signature,version,type,status from paypal_setting where id='.$id;
	    return $db->fetchRow($sql);
	}
	public function updatedtd($details)
	{

	    $db = Zend_Db_Table::getDefaultAdapter();
	    
	    $sql = 'update paypal_setting set username="'.$details['username'].'",password="'.base64_encode($details['password']).'",signature="'.$details['signature'].'",version="'.$details['version'].'",status='.$details['status'].' where id='.base64_decode($details['id']);
	    $db->query($sql);
	}
}

