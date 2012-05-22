<?php  
class Zend_View_Helper_Dcode  extends Zend_View_Helper_Abstract 
{ 
   public function dcode($sval)
   {
   		return base64_decode($sval);
   }
 
}
