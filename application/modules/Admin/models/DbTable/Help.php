<?php

class Admin_Model_DbTable_Help extends Zend_Db_Table_Abstract
{

    protected $_name = 'help';
	
    public function helplist($module,$section) // Function using to retrive all the help to list
    {
    	$db = Zend_Db_Table::getDefaultAdapter();

    	if($module=="" && $section=="")
    	{
    		$select = $db->select()
    		->from(array('h' => 'help'),array('h.id','h.module','h.section','h.details'))
    		->order('h.module');
    	}
    	elseif($module!="" && $section=="")
    	{
    	   	$select = $db->select()
	    	->from(array('h' => 'help'),array('h.id','h.module','h.section','h.details'))
	    	->where('h.module="'.$module.'"')
	    	->order('h.module');
    	}
    	elseif($module=="" && $section!="")
    	{
    		$select = $db->select()
    		->from(array('h' => 'help'),array('h.id','h.module','h.section','h.details'))
    		->where('h.section="'.$section.'"')
    		->order('h.module');
    	}
    	else
    	{
    		$select = $db->select()
    		->from(array('h' => 'help'),array('h.id','h.module','h.section','h.details'))
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
    /*
     * adHelp function using to add new help.
     * This function is not for the admin users. only developer can do a new help because, its call section requried to code in 
     * its corresponding section. 
     */
    public function addHelp($module,$section,$details)
    {
    	$db = Zend_Db_Table::getDefaultAdapter();
    
    	$data = array(
    			'module' => $module,
    			'section' => $section,
    			'details' => $details
    	);
    	$numRows = $db->insert('help', $data);
    	return $db->lastInsertId();
    }
    public function RetriveHelpValues($id)// Retriving the selected help values to edit
    {
    	$db = Zend_Db_Table::getDefaultAdapter();
    	$select = $db->select()
    	->from(array('h'=>'help'),array('h.id','h.module','h.section','h.details'))
    	->where('h.id='.$id);
    	$row = $db->fetchRow($select);
    
    	if(!$row)
    	{
    		throw new Exception("Count not find row $id");
    	}
    	return $row;
    }
    
    public function updateHelp($id,$module,$section,$details) // Updating function for Help
    {
    	$data = array(
    			'module' => $module,
    			'section' => $section,
    			'details' => $details
    			);
    	$this->update($data,'id='.(int)$id);
    }
    public function deleteHelp($id)
    {
    	$this->delete('id='.(int)$id);
    }
}

