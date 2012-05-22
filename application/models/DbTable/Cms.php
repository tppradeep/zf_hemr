<?php

class Application_Model_DbTable_Cms extends Zend_Db_Table_Abstract
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

}

