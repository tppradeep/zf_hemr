<?php  
class Zend_View_Helper_Checkaclresource  extends Zend_View_Helper_Abstract 
{ 
   public function checkaclresource($module,$controller,$hf_id)
   {
       $db = Zend_Db_Table::getDefaultAdapter();
       $sql ='select acl_resource from acl_user_setting where hf_id='.$hf_id;
       $assignedresources = $db->fetchOne($sql);
       if(stristr($assignedresources, $controller) === FALSE) {
           return false;
       }
       else
       {
           return true;
       }
       	 
   }
 
}
