<?php

class Admin_Model_DbTable_Imagegallery extends Zend_Db_Table_Abstract
{

    protected $_name = 'page_help_images';
    
    public function helptitle($page_help_id)
    {
    	$db = Zend_Db_Table::getDefaultAdapter();
    	$select = $db->select()
    				 ->from(array('page_help'),array('module','Section','title'))
    				 ->where('page_help_id='.$page_help_id);
    	return $row = $db->fetchRow($select);
    }

    public function imagelist($page_help_id,$title)// Function using to retrive all the Images of a help gallery based on id
    {
    	$db = Zend_Db_Table::getDefaultAdapter();
    
    	if($title=="")
    	{
    		$select = $db->select()
    		->from(array('page_help_images'),array('page_help_images_id','image_title','image_description','image_name','sortorder','status'))
    		->where('page_help_id="'.$page_help_id.'"')
    		->order('page_help_images_id');
    	}
    	elseif($title!="")
    	{
    		$select = $db->select()
    		->from(array('page_help_images'),array('page_help_images_id','image_title','image_description','image_name','sortorder','status'))
    		->where('image_title like "%'.$title.'%"')
    		->where('page_help_id="'.$page_help_id.'"')
    		->order('page_help_images_id');
    	}
    	
    
    	$row = $db->fetchAll($select);
    
    	if (!$row)
    	{
    		//		throw new Exception("Could not find row");
    		//exit;
    	}
    	return $row;
    
    }
    public function addImage($page_help_id,$image_title,$desc,$Imagename,$sortorder,$status)
    {
    	$db = Zend_Db_Table::getDefaultAdapter();
    	
    	$data = array(
    			'page_help_id' => addslashes($page_help_id),
    			'image_title' => addslashes($image_title),
    			'image_description' => addslashes($desc),
    			'image_name' => addslashes($Imagename),
    			'sortorder' => addslashes($sortorder),
    			'status'=>$status
    	);
    	$numRows = $db->insert('page_help_images', $data);
    	return $db->lastInsertId();
    }
    public function RetriveImageValues($id)// Retriving the selected help values to edit
    {
    	$db = Zend_Db_Table::getDefaultAdapter();
    	$select = $db->select()
    	->from(array('page_help_images'),array('page_help_images_id','page_help_id','image_title','image_description','image_name','sortorder','status'))
    	->where('page_help_images_id='.$id);
    	$row = $db->fetchRow($select);
    	
    
    	if(!$row)
    	{
    		throw new Exception("Count not find row");
    	}
    	return $row;
    }
    public function UpdateImage($page_help_images_id,$page_help_id,$image_title,$desc,$sortorder,$status)
    {
       
        $data = array(
        		'image_title' => addslashes($image_title),
        		'image_description' => addslashes($desc),
        		'sortorder'=> $sortorder,
        		'status' => $status
        );
        
        $this->update($data,'page_help_images_id='.$page_help_images_id);
       return $page_help_id;
    }
    public function deleteimage($id)
    {
        $this->delete('page_help_images_id='.$id);
    }
}

