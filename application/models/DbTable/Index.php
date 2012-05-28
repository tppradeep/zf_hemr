<?php
class Application_Model_DbTable_Index extends Zend_Db_Table_Abstract
{

    protected $_name = 'cms';

	public function getcms($sec)
	{
	    $customerId = new Zend_Session_Namespace('customerId');
	    $cust_id=$customerId->customerId;
	    
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql = 'select cms_title,cms_details from cms where cms_sec="'.$sec.'" and customer_id='.$cust_id.'';
		return $db->fetchRow($sql);
	}
	public function planlist()
	{
	    $customerId = new Zend_Session_Namespace('customerId');
	    $cusid=$customerId->customerId;
	    
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $select = $db->select()
	    ->from(array('hosted_plans'),array('hp_id','hp_name','Imagename','bundle_cost'))
	    ->where('hp_status=1')
	    ->where('customer_id='.$cusid);
	 	$plist = $db->fetchAll($select);
	 	
	 	for($i=0;$i<sizeof($plist);$i++)
	 	{
	 	    $sql ='call listprice('.$plist[$i]['hp_id'].')';
	 	    $listprice =  $db->fetchOne($sql);
	 	    $plist[$i]['listprice']=$listprice;
	 	}
	 	return $plist;
	}
}

