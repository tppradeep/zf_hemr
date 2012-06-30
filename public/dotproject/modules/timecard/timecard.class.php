<?php /* HELPDESK $Id: timecard.class.php,v 1.6 2007/01/31 16:02:50 theideaman Exp $ */
require_once $AppUI->getSystemClass('dp');
//require_once $AppUI->getSystemClass('libmail');

// Function to build a where clause to be appended to any sql that will narrow
// down the returned data to only permitted entities

function getPermsWhereClause($mod, $mod_id_field)
{
	global $AppUI, $perms;
	//print "<pre>";
	//print_r($perms);
	//print "</pre>";
  // Figure out the module and field
/*	switch($mod){
		case "companies":
			$id_field = "company_id";
			break;
		case "users":
			$id_field = "user_id";
			break;
		case "projects":
			$id_field = "project_id";
			break;
		case "tasks":
			$id_field = "task_id";
			break;
		case "helpdesk_items":
			$id_field = "item_id";
			break;
		default:
			return null;
	}
	if(
		(isset($perms[$mod]['-1']) && ($perms[$mod]['-1']=='1' || $perms[$mod]['-1']=='-1')) || 
     		(isset($perms["all"]['-1']) && ($perms["all"]['-1']=='1' || $perms["all"]['-1']=='-1'))
     	) {
		$sql = "SELECT $id_field FROM $mod";
		$list = db_loadColumn( $sql );
	} else {
		$list = array();
	}

	$list[] = "''";
	$list[] = "0";

	if(isset($perms[$mod])){
		foreach($perms[$mod] as $key => $value){
			//-1 is all perms, so not a specific one

			if($key=='-1')
				continue;

			switch($value){
				case '-1': //edit
					$list[] = $key;
					break;
				case '0'://deny
					unset($list[array_search($key, $list)]);
					break;
				case '1'://read
					$list[] = $key;
					break;
				default:
					break;
			}
		}
	}

	$list = array_unique($list);

	return " $mod_id_field in (".implode(",",$list).")";
*/
	return "1 = 1";	
}
?>