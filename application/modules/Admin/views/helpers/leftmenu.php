<?php
class Zend_View_Helper_leftmenu  extends Zend_View_Helper_Abstract
{

	public function leftmenu()
	{
		
		$session = new Zend_Session_Namespace('MyNamespace');
		if($session->username=="")
		{
			header("Location: ".$this->view->baseUrl()."/Admin");
		}
		
		$db = Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
			   	->from(array('m' => 'modules'),array('m.module_id','m.module_name','m.module_controller','m.module_display_name'))
			 	->order('m.module_id');
		$row = $db->fetchAll($select);
				
		if (!$row) 
		{
			throw new Exception("Could not find");
		}
		
		$session = new Zend_Session_Namespace('MyNamespace');
				
		
		$rvalue ='<div id="leftmenu">';
		$rvalue .='<h4>Admin Modules('.$session->displayname.')</h4>';
		$rvalue .='<table width="100%" border="0">';
		
		
		/*
		$rvalue .="<pre>";
		$rvalue .= print_r($row);
		$rvalue .="</pre>";
		*/
		
		for($i=0; $i<sizeof($row);$i++)
		{
			
			$rvalue .='<tr>';
			$rvalue .='<td>';
			
			$rvalue .='<a href=';
			$rvalue .= $this->view->url(array('controller' => $row[$i]['module_name'],'action' => $row[$i]['module_controller']),0,true);
		//	$rvalue .= $row[$i]['module_name'],null,true;
			$rvalue .=' class="plan_list">';
			$rvalue .= $row[$i]['module_display_name'];
			$rvalue .= '</a>';
			$rvalue .= '</td>';
			$rvalue .='</tr>';
		}
		
		$rvalue .='</table>';
		$rvalue .= '</div>';
		return $rvalue;  
		
	
	}
}
