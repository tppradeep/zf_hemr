<?php  
class Zend_View_Helper_Checkacl  extends Zend_View_Helper_Abstract 
{ 
   public function checkacl($module,$controller,$action,$hf_id)
   {
   		//echo $hf_id;
   		//echo $controller;
   		//echo $action;
   		
   		/*
   		 * First select the action id from db
   		 */
   		$db = Zend_Db_Table::getDefaultAdapter();
   		$sql = 'select id from acl_resources where module="'.$module.'" and controller="'.$controller.'" and action="'.$action.'"';
   		$actionid = $db->fetchOne($sql);

   		$sql = 'select acl_action from hosted_facilities where hf_id='.$hf_id;
   		$assigned_actions =explode(',',$db->fetchOne($sql));
   	//	echo "<pre>";
   	//	print_r($assigned_actions);
   		foreach($assigned_actions as $aa)
   		{
   		    if($aa==$actionid)
   		    {
   		        return true;
   		        break;
   		    }
   		}
   }
 
}
