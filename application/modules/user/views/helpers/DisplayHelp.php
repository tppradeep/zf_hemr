<?php  
class Zend_View_Helper_DisplayHelp  extends Zend_View_Helper_Abstract 
{ 
   public function DisplayHelp($module,$sec)
   {
   		echo "&nbsp;<a href='".$this->view->baseUrl()."/Viewhelp/?m=".$module."&s=".$sec."' class='jTip' id='".$sec."'><img src='". $this->view->baseUrl()."/images/help.png' width='16px;' height='16px;'/></a>";
   }
 
}
