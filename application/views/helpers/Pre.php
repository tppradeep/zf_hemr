<?php  
class Zend_View_Helper_Pre  extends Zend_View_Helper_Abstract 
{ 
   public function pre($sval)
   {
   		echo "<pre>";
		echo print_r($sval);
		echo "</pre>";
   }
 
}
