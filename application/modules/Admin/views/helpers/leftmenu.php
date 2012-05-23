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
		$rvalue .='<div id="list3"><div class="title11">Admin Modules('.$session->displayname.')</div>';
		//$rvalue .='<table width="100%" border="0">';
		
		
		/*
		$rvalue .="<pre>";
		$rvalue .= print_r($row);
		$rvalue .="</pre>";
		*/
		
		for($i=0; $i<sizeof($row);$i++)
		{
		    $leftmenu = new Zend_Session_Namespace('leftmenuid');
		     $storedId = $leftmenu->leftmenuid;
		    
		   // $leftmenu->leftmenuid = $sec;
		//	$rvalue .='<tr>';
		     if($storedId == $row[$i]['module_id'])
		     {
		     	$rvalue .='<div class="selected">';
		     }
		     else
		     {
		     	$rvalue .='<div>';
		     }
		   
		            
		     $rvalue .='<div class="title">'.$row[$i]['module_display_name'].'</div>';
		    if($storedId == $row[$i]['module_id'])
		    {
		      $rvalue .='<div id="menuactive">';  
		    }
		    else 
		    {
			$rvalue .='<div>';
		    }
			
			$rvalue .='<a href=';
			//'sec'=>$row[$i]['module_id']
			
			//$rvalue .= $this->view->url(array('controller' => $row[$i]['module_name'],'action' => $row[$i]['module_controller']),0,true);
			$rvalue .= $this->view->url(array('module'=>'Admin','controller' => 'Index','action' => 'menu-click','cont'=>$row[$i]['module_name'],'act'=>$row[$i]['module_controller'],'sec'=>$row[$i]['module_id']),0,true);
		//	$rvalue .= $row[$i]['module_name'],null,true;
			$rvalue .=' class="plan_list">';
			$rvalue .= $row[$i]['module_display_name'];
			$rvalue .= '</a>';
			$rvalue .= '</div></div>';
		//	$rvalue .='</tr>';
		}
		
		//$rvalue .='</table>';
		$rvalue .='<div><div class="title">&nbsp;</div></div>';
		$rvalue .= '</div></div>';
		return $rvalue;  
		
	
	}
}
