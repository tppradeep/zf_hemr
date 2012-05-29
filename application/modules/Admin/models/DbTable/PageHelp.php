<?php

class Admin_Model_DbTable_PageHelp extends Zend_Db_Table_Abstract
{

    protected $_name = 'page_help';
	
    public function helplist($module,$section) // Function using to retrive all the help to list
    {
    	$db = Zend_Db_Table::getDefaultAdapter();
    
    	if($module=="" && $section=="")
    	{
    		$select = $db->select()
    		->from(array('h' => 'page_help'),array('h.page_help_id','h.module','h.section','h.title'))
    		->order('h.module');
    	}
    	elseif($module!="" && $section=="")
    	{
    		$select = $db->select()
    		->from(array('h' => 'page_help'),array('h.page_help_id','h.module','h.section','h.title'))
    		->where('h.module="'.$module.'"')
    		->order('h.module');
    	}
    	elseif($module=="" && $section!="")
    	{
    		$select = $db->select()
    		->from(array('h' => 'page_help'),array('h.page_help_id','h.module','h.section','h.title'))
    		->where('h.section="'.$section.'"')
    		->order('h.module');
    	}
    	else
    	{
    		$select = $db->select()
    		->from(array('h' => 'page_help'),array('h.page_help_id','h.module','h.section','h.title'))
    		->where('h.module="'.$module.'"')
    		->orWhere('h.section="'.$section.'"')
    		->order('h.module');
    	}
    		
    	$row = $db->fetchAll($select);
    	 
    	if (!$row)
    	{
    		//		throw new Exception("Could not find row");
    		//exit;
    	}
    	return $row;
    
    }
    
    public function addHelp($module,$section,$title,$details)
    {
    	$db = Zend_Db_Table::getDefaultAdapter();
    
    	$data = array(
    			'module' => addslashes($module),
    			'section' =>addslashes($section),
    			'title' => addslashes($title),
    			'description' => addslashes($details)
    	);
    	$numRows = $db->insert('page_help', $data);
    	return $db->lastInsertId();
    }
    public function RetriveHelpValues($id)// Retriving the selected help values to edit
    {
    	$db = Zend_Db_Table::getDefaultAdapter();
    	$select = $db->select()
    	->from(array('h'=>'page_help'),array('h.page_help_id','h.module','h.section','h.title','h.description'))
    	->where('h.page_help_id='.$id);
    	$row = $db->fetchRow($select);
    
    	if(!$row)
    	{
    		throw new Exception("Count not find row $id");
    	}
    	return $row;
    }
    
    public function updateHelp($id,$module,$section,$title,$details) // Updating function for Help
    {
    	$data = array(
    			'module' =>addslashes($module),
    			'section' => addslashes($section),
    			'title'=> addslashes($title),
    			'description' => addslashes($details)
    	);
    
    	$this->update($data,'page_help_id='.(int)$id);
    }
    public function deleteHelp($id)
    {
    	$this->delete('page_help_id='.(int)$id);
    }

}

