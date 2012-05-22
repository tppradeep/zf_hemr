<?php

class Application_Model_DbTable_PlanListSideBar extends Zend_Db_Table_Abstract
{

    protected $_name = 'hosted_plans';
    
    public function activeplans()
    {
    	
    	$customerId = new Zend_Session_Namespace('customerId');
    	$cusid=$customerId->customerId;
    	
    	$db = Zend_Db_Table::getDefaultAdapter();
    	$select = $db->select()
    	->from(array('p' => 'hosted_plans'),array('p.hp_id', 'p.hp_name'))
    	->order('p.hp_id')
    	->where('p.customer_id='.$cusid)
    	->where('p.hp_status=1');
    	
    	
    	$row = $db->fetchAll($select);
    	
    	if (!$row)
    	{
    		throw new Exception("Could not find row $id");
    	}
    	return $row;
    }

}

