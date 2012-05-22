<?php

class Admin_Model_DbTable_AdminUser extends Zend_Db_Table_Abstract
{

  //  protected $_name = 'admin_details';

	public function left_side_menu()
	{
		$customerId = new Zend_Session_Namespace('customerId');
		$db = Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
			   	->from(array('m' => 'modules'),array('m.module_id', 'm.module_name','m.module_display_name'))
			   	->where('m.customer_id='.$customerId->customerId)
			 	->order('m.module_id');
		$row = $db->fetchAll($select);
				
		if (!$row) 
		{
			throw new Exception("Could not find row $id");
		}
		return $row;
	}
	public function planfeature()
	{
		$db = Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
		->from(array('h' => 'hosted_plan_content_mapping'),array('h.hpcm_type_id', 'h.hpcm_type_name','h.hpcm_order','h.hpcm_level','h.delete','h.min_val','custom_label1'))
		->order('h.hpcm_order');
		$row = $db->fetchAll($select);
		
		if (!$row)
		{
			throw new Exception("Could not find row $id");
		}
		return $row;
	
	}
}

