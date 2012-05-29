<?php

class Admin_Model_DbTable_EmailTemplate extends Zend_Db_Table_Abstract
{

    protected $_name = 'email_template';

	public function listemil()
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql = "select template_id,template_sec,Subject,content from email_template order by template_id asc";
	    return $db->fetchAll($sql);
	}
	public function templatedtd($templateid)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql ='select template_id,template_sec,Subject,content from email_template where template_id='.$templateid;
	    return $db->fetchRow($sql);
	}
	public function updatetemplate($formData)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    
	    $template_id = $formData['id'];
	    $Subject = addslashes($formData['Subject']);
	    echo "<pre>";
	   echo $content = addslashes($formData['contents']);
	  //  die;
	    $sql='update email_template set Subject="'.$Subject.'",content="'.$content.'" where template_id='.$template_id;
	    $db->query($sql);
	    
	}
}

