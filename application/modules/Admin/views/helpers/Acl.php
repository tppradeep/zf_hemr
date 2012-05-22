<?php  
class Zend_View_Helper_Acl  extends Zend_View_Helper_Abstract 
{ 
 	public function acl($module,$controller,$action,$hf_id)
   {
   		echo $hf_id;
   		echo $controller;
   		echo $action;
   }
 
}
