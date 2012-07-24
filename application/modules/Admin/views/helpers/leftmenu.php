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
		$rvalue ='<div class="title11">Admin Modules('.$session->displayname.')</div>';
		$rvalue.='<div id="accordion">';
		
		$db = Zend_Db_Table::getDefaultAdapter();
		
		$sql ='select menu_group from modules where menu_group <>"" group by menu_group';
		$mg = $db->fetchAll($sql);
		
		$leftmenu = new Zend_Session_Namespace('leftmenuid');
		$storedId = $leftmenu->leftmenuid;
		$gid=0;
		foreach($mg as $m)
		{
		    
	   	 	$rvalue .='<h3><a href="#">'.$m['menu_group'].'</a></h3>';
		   	$rvalue .='<div>';
		  
		    
		    $select ='select module_id,module_name,module_controller,module_display_name from modules where menu_group="'.$m['menu_group'].'" order by module_id';
		    
		    $row = $db->fetchAll($select);
		    for($i=0; $i<sizeof($row);$i++)
		    {
		        	$rvalue .='<a href=';
		        	$rvalue .= $this->view->url(array('module'=>'Admin','controller' => 'Index','action' => 'menu-click','cont'=>$row[$i]['module_name'],'act'=>$row[$i]['module_controller'],'sec'=>$row[$i]['module_id'],'mgroup'=>$gid),0,true);
		        	$rvalue .=' class="">';
		        	$rvalue .= $row[$i]['module_display_name'];
		        	$rvalue .= '</a><br/>';
		        
		    }
		    $rvalue.='</div>';
		    $gid = $gid + 1;
		}
	
$rvalue.='</div>';

		        
		return $rvalue;  
		
	
	}
}
