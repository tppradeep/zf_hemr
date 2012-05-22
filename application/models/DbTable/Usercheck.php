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
}

