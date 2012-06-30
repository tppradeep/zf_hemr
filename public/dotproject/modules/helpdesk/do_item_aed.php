<?php /* HELPDESK $Id: do_item_aed.php,v 1.18 2004/05/06 18:09:39 agorski Exp $ */

$del = dPgetParam( $_POST, 'del', 0 );
$item_id = dPgetParam( $_POST, 'item_id', 0 );
$do_task_log = dPgetParam( $_POST, 'task_log', 0 );
$new_item = !($item_id>0);

if($do_task_log=="1"){

	//first update the status on to current helpdesk item.
	$hditem = new CHelpDeskItem();
	$hditem->load( $item_id );
	$new_status = dPgetParam( $_POST, 'item_status', 0 );
	if($new_status!=$hditem->item_status){
		$status_log_id = $hditem->log_status(11, "changed from \"{$ist[$hditem->item_status]}\" to \"{$ist[$new_status]}\"");
		$hditem->item_status = $new_status;

		if (($msg = $hditem->store($status_log_id))) {
			$AppUI->setMsg( $msg, UI_MSG_ERROR );
			$AppUI->redirect();
		}
	}

	//then create/update the task log
	$obj = new CTaskLog();

	if (!$obj->bind( $_POST )) {
		$AppUI->setMsg( $obj->getError(), UI_MSG_ERROR );
		$AppUI->redirect();
	}

	if ($obj->task_log_date) {
		$date = new CDate( $obj->task_log_date );
		$obj->task_log_date = $date->format( FMT_DATETIME_MYSQL );
	}

	$AppUI->setMsg( 'Task Log' );
	if ($del) {
		if (($msg = $obj->delete())) {
			$AppUI->setMsg( $msg, UI_MSG_ERROR );
		} else {
			$AppUI->setMsg( "deleted", UI_MSG_ALERT );
		}
	} else {
		$obj->task_log_costcode = $obj->task_log_costcode;
		if (($msg = $obj->store())) {
			$AppUI->setMsg( $msg, UI_MSG_ERROR );
			$AppUI->redirect();
		} else {
			$AppUI->setMsg( @$_POST['task_log_id'] ? 'updated' : 'added', UI_MSG_OK, true );
		}
	}

	$AppUI->redirect("m=helpdesk&a=view&item_id=$item_id&tab=0");

} else {

	$hditem = new CHelpDeskItem();

	if ( !$hditem->bind( $_POST )) {
		$AppUI->setMsg( $hditem->error, UI_MSG_ERROR );
		$AppUI->redirect();
	}

	$AppUI->setMsg( "Help Desk item", UI_MSG_OK );

	if ($del) {
		if (($msg = $hditem->delete())) {
			$AppUI->setMsg( $msg, UI_MSG_ERROR );
		} else {
			$AppUI->setMsg( "Help Desk item deleted", UI_MSG_OK );
			$hditem->log_status(17);
			$AppUI->redirect('', -1);
		}
	} else {
    $status_log_id = $hditem->log_status_changes();

		if (($msg = $hditem->store($status_log_id))) {
			$AppUI->setMsg( $msg, UI_MSG_ERROR );
		} else {
      if($new_item){
        $status_log_id = $hditem->log_status(0,"Created");
      }

			$AppUI->setMsg( $new_item ? 'added' : 'updated' , UI_MSG_OK, true );
			$AppUI->redirect('m=helpdesk&a=view&item_id='.$hditem->item_id);
		}
	}
}

?>
