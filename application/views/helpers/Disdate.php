<?php  
class Zend_View_Helper_Disdate  extends Zend_View_Helper_Abstract 
{ 
   public function Disdate($sval)
   {
   		echo $sval;
   		//die;
   		if($sval!="")
   		{
	   		$sval=explode("-",$sval);
	   		return $sval[1]."-".$sval[2]."-".$sval[0];
   		}
   }
 
}
