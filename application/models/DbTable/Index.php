<?php

class Application_Model_DbTable_Index extends Zend_Db_Table_Abstract
{

    protected $_name = 'cms';

	public function getcms($sec)
	{
		$row = $this->fetchRow('cms_sec = "'.$sec.'"');
		if (!$row) 
		{
			throw new Exception("Could not find row $id");
		}
		return $row->toArray();
	}
	public function planlist()
	{
	    $customerId = new Zend_Session_Namespace('customerId');
	    $cusid=$customerId->customerId;
	    
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $select = $db->select()
	    ->from(array('hosted_plans'),array('hp_id','hp_name','Imagename'))
	    ->where('hp_status=1')
	    ->where('customer_id='.$cusid);
	 
	    return $db->fetchAll($select);
	}
}

