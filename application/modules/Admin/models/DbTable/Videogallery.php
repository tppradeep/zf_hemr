<?php

class Admin_Model_DbTable_Videogallery extends Zend_Db_Table_Abstract
{

    protected $_name = 'page_help_video';

    public function videolist($page_help_id,$title)// Function using to retrive all the Images of a help gallery based on id
    {
    	$db = Zend_Db_Table::getDefaultAdapter();
    
    	if($title=="")
    	{
    		$select = $db->select()
    		->from(array('page_help_video'),array('page_help_video_id','video_title','utube_url','sortorder','status'))
    		->where('page_help_id="'.$page_help_id.'"')
    		->order('page_help_video_id');
    	}
    	elseif($title!="")
    	{
    		$select = $db->select()
    		->from(array('page_help_video'),array('page_help_video_id','video_title','utube_url','sortorder','status'))
    		->where('video_title like "%'.$title.'%"')
    		->where('page_help_id="'.$page_help_id.'"')
    		->order('page_help_video_id');
    	}
    	 
    
    	$row = $db->fetchAll($select);
    
    	if (!$row)
    	{
    		//		throw new Exception("Could not find row");
    		//exit;
    	}
    	return $row;
    
    }
    public function addvideo($page_help_id,$video_title,$utube_url,$sortorder,$status)
    {
        $db = Zend_Db_Table::getDefaultAdapter();
         
        $data = array(
        		'page_help_id' => $page_help_id,
        		'video_title' => $video_title,
        		'utube_url' => $utube_url,
        		'sortorder' => $sortorder,
        		'status'=>$status
        );
        $numRows = $db->insert('page_help_video', $data);
        return $db->lastInsertId();
    }
    public function RetriveVideoValues($id)
    {
        $db = Zend_Db_Table::getDefaultAdapter();
        $select = $db->select()
        ->from(array('page_help_video'),array('page_help_video_id','page_help_id','video_title','utube_url','sortorder','status'))
        ->where('page_help_video_id='.$id);
        $row = $db->fetchRow($select);
         
        
        if(!$row)
        {
        	throw new Exception("Count not find row");
        }
        return $row;
    }
    public function UpdateVideo($page_help_video_id,$page_help_id,$video_title,$utube_url,$sortorder,$status)
    {
    	 
    	$data = array(
    			'video_title' => $video_title,
    			'utube_url' => $utube_url,
    			'sortorder'=> $sortorder,
    			'status' => $status
    	);
    
    	$this->update($data,'page_help_video_id='.$page_help_video_id);
    	return $page_help_id;
    }
    public function deletevideo($id)
    {
    	$this->delete('page_help_video_id='.$id);
    }
}

