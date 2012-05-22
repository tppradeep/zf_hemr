<?php  
class Zend_View_Helper_PlanStatus  extends Zend_View_Helper_Abstract 
{ 
   public function PlanStatus($pstatus)
   {
   		if($pstatus==0)
		{
			return "Plan not activated";
		}
		elseif($pstatus==1)
		{
			return "Plan is active";
		}
		elseif($pstatus==2)
		{
			return "Plan is disabled";
		}
		elseif($pstatus==3)
		{
			return "Plan is Expired";
		}
   }
 
}
