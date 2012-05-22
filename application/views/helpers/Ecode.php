<?php  
class Zend_View_Helper_Ecode  extends Zend_View_Helper_Abstract 
{ 
   public function ecode($sval)
   {
   		return base64_encode($sval);
   }
 
}
