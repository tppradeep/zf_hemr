<?php

class User_Model_DbTable_Inbox extends Zend_Db_Table_Abstract
{

    protected $_name = 'messages';


    public function listmessage($hf_id)
    {
        $db = Zend_Db_Table::getDefaultAdapter();
        $sql = "select id,subject,status,date from messages where hf_id=".$hf_id." order by date";
        	
        return $db->fetchAll($sql);
    }
    public function viewmessage($id)
    {
        $db = Zend_Db_Table::getDefaultAdapter();
        $sql ='select subject,message from messages where id='.$id;
        return $db->fetchRow($sql);
    }
}

