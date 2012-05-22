<?php  
class Zend_View_Helper_Checkacl  extends Zend_View_Helper_Abstract 
{ 
   public function checkacl($module,$controller,$action,$hf_id)
   {
   		echo $hf_id;
   		echo $controller;
   		echo $action;
   }
 
}
