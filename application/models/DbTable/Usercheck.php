<?php

class Application_Model_DbTable_Usercheck extends Zend_Db_Table_Abstract
{

    protected $_name = 'hosted_facilities';

	public function userdtd($emailid,$password)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $select = $db->select()
	    ->from(array('admin_details'),array('AdminId','customer_id','AdminFullName','role'))
	    ->where('AdminEmail="'.$emailid.'"')
	    ->where('AdminPassword="'.$password.'"');
	    return $db->fetchRow($select);
	}
	
	public function UserPlan($hf_id)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql = 'select 	plan_id,payment_status,plan_status from customer_selected_plan where hf_id='.$hf_id;
	    
	    return $db->fetchRow($sql);
	    
	}
}

