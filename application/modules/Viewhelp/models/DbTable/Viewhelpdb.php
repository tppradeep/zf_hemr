<?php

class Viewhelp_Model_DbTable_Viewhelpdb extends Zend_Db_Table_Abstract
{

    protected $_name = 'help';

    public function displayHelp($module,$sec)
    {
    	$db = Zend_Db_Table::getDefaultAdapter();
    	$select = $db->select()
    	->from(array('h' => 'help'),array('h.details'))
    	->where('h.module="'.$module.'"')
    	->where('h.section="'.$sec.'"');
    	
    	$row = $db->fetchRow($select);
    		
    	if (!$row)
    	{
    		throw new Exception("Could not find row");
    	}
    	return $row;
    }
    
}

