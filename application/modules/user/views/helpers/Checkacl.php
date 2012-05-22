<?php  
class Zend_View_Helper_Checkacl  extends Zend_View_Helper_Abstract 
{ 
   public function checkacl($module,$controller,$action,$hf_id)
   {
   		/*
   		 * First select the action id from db
   		 */
   		$db = Zend_Db_Table::getDefaultAdapter();
   		$sql = 'select id from acl_resources where module="'.$module.'" and controller="'.$controller.'" and action="'.$action.'"';
   		$actionid = $db->fetchOne($sql);

   		$sql = 'select acl_action from acl_user_setting where hf_id='.$hf_id;
   		$assigned_actions =explode(',',$db->fetchOne($sql));
   		foreach($assigned_actions as $Assigned)
   		{
   		    if($Assigned==$actionid)
   		    {
   		        return true;
   		        break;
   		    }
   		}
   }
}
