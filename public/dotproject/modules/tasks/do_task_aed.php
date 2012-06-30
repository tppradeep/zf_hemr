<?php /* TASKS $Id: do_task_aed.php 5872 2009-04-25 00:09:56Z merlinyoda $ */
if (!defined('DP_BASE_DIR')) {
	die('You should not access this file directly.');
}


$adjustStartDate = dPgetParam($_POST, 'set_task_start_date');
$del = dPgetParam($_POST, 'del', 0);
$task_id = dPgetParam($_POST, 'task_id', 0);
$hassign = dPgetParam($_POST, 'hassign');
$hperc_assign = dPgetParam($_POST, 'hperc_assign');
$hdependencies = dPgetParam($_POST, 'hdependencies');
$notify = dPgetParam($_POST, 'task_notify', 0);
$comment = dPgetParam($_POST, 'email_comment','');
$sub_form = dPgetParam($_POST, 'sub_form', 0);

if ($sub_form) {
	// in add-edit, so set it to what it should be
	$AppUI->setState('TaskAeTabIdx', $_POST['newTab']);
	if (isset($_POST['subform_processor'])) {
		$mod = ((isset($_POST['subform_module'])) 
				? $AppUI->checkFileName($_POST['subform_module']) 
				: 'tasks');
		$proc = $AppUI->checkFileName($_POST['subform_processor']);
		include (DP_BASE_DIR . '/modules/' . $mod . '/' . $proc . '.php');
	}
} else {
	// Include any files for handling module-specific requirements
	foreach (findTabModules('tasks', 'addedit') as $mod) {
		$fname = (DP_BASE_DIR . '/modules/' . $mod . '/tasks_dosql.addedit.php');
		dprint(__FILE__, __LINE__, 3, ('checking for ' . $fname));
		if (file_exists($fname)) {
			require_once $fname;
		}
	}
	
	$obj = new CTask();
	
	// If we have an array of pre_save functions, perform them in turn.
	if (isset($pre_save)) {
		foreach ($pre_save as $pre_save_function) {
			$pre_save_function();
		}
	} else {
		dprint(__FILE__, __LINE__, 2, 'No pre_save functions.');
	}
	
	// Find the task if we are set
	$task_end_date = null;
	if ($task_id) {
		$obj->load($task_id);
		$task_end_date = new CDate($obj->task_end_date);
	}
	if ($_POST['task_start_date'] === '') {
		$_POST['task_start_date'] = '000000000000';
	}
	if ($_POST['task_end_date'] === '') {
		$_POST['task_end_date'] = '000000000000';
	}
	
	if (isset($_POST) && !($obj->bind($_POST))) {
		$AppUI->setMsg($obj->getError(), UI_MSG_ERROR);
		$AppUI->redirect();
	}
	
	if (!($obj->task_owner)) {
		$obj->task_owner = $AppUI->user_id;
	}
	
	// Check to see if the task_project has changed
	if (isset($_POST['new_task_project']) && $_POST['new_task_project'] && ($obj->task_project != $_POST['new_task_project'])) {
		$obj->task_project = $_POST['new_task_project'];
		$obj->task_parent  = $obj->task_id;
	}
	
	// Map task_dynamic checkboxes to task_dynamic values for task dependencies.
	if ($obj->task_dynamic != 1) {
		$task_dynamic_delay = dPgetParam($_POST, 'task_dynamic_nodelay', '0');
		if (in_array($obj->task_dynamic, $tracking_dynamics)) {
			$obj->task_dynamic = $task_dynamic_delay ? 21 : 31;
		} else {
			$obj->task_dynamic = $task_dynamic_delay ? 11 : 0;
		}
	}
    
	// Make sure checkboxes are set or reset as appropriately
	$checkbox_properties = array('task_dynamic', 'task_milestone', 'task_notify');
	foreach ($checkbox_properties as $task_property) {
		if (!(array_key_exists($task_property, $_POST))) {
			$obj->$task_property = false;
		}
	}
	
	//format hperc_assign user_id=percentage_assignment;user_id=percentage_assignment;user_id=percentage_assignment;
	$tmp_ar = explode(';', $hperc_assign);
	$hperc_assign_ar = array();
	for ($i = 0, $xi = sizeof($tmp_ar); $i < $xi; $i++) {
		$tmp = explode('=', $tmp_ar[$i]);
		$hperc_assign_ar[$tmp[0]] = ((count($tmp) > 1) ? $tmp[1] : 100);
	}
	
	// let's check if there are some assigned departments to task
	$obj->task_departments = implode(',', dPgetParam($_POST, 'dept_ids', array()));
	
	// convert dates to SQL format first
	if ($obj->task_start_date) {
		$date = new CDate($obj->task_start_date);
		$obj->task_start_date = $date->format(FMT_DATETIME_MYSQL);
	}
	$end_date = null;
	if ($obj->task_end_date) {
		if (mb_strpos($obj->task_end_date, '2400') !== false) {
		  $obj->task_end_date = str_replace('2400', '2359', $obj->task_end_date);
		}
		$end_date = new CDate($obj->task_end_date);
		$obj->task_end_date = $end_date->format(FMT_DATETIME_MYSQL);
	}
	
	require_once($AppUI->getSystemClass('CustomFields'));
	
	// prepare (and translate) the module name ready for the suffix
	if ($del) {
		if (($msg = $obj->delete())) {
			$AppUI->setMsg($msg, UI_MSG_ERROR);
			$AppUI->redirect();
		} else {
			$AppUI->setMsg('Task deleted');
			$AppUI->redirect('', -1);
		}
	} else {
		if (($msg = $obj->store())) {
			$AppUI->setMsg($msg, UI_MSG_ERROR);
			$AppUI->redirect(); // Store failed don't continue?
		} else {
			$custom_fields = New CustomFields($m, 'addedit', $obj->task_id, 'edit');
 			$custom_fields->bind($_POST);
 			$sql = $custom_fields->store($obj->task_id); // Store Custom Fields
			
			// Now add any task reminders
			// If there wasn't a task, but there is one now, and
			// that task date is set, we need to set a reminder.
			if (empty($task_end_date) || (!(empty($end_date)) 
			                              && $task_end_date->dateDiff($end_date))) {
				$obj->addReminder();
			}
			$AppUI->setMsg($task_id ? 'Task updated' : 'Task added', UI_MSG_OK);
		}
		
		if (isset($hassign)) {
			$obj->updateAssigned($hassign , $hperc_assign_ar);
		}
				
		if (isset($hdependencies)) { // && !empty($hdependencies)) {
			// there are dependencies set!
			
			// backup initial start and end dates
			$tsd = new CDate ($obj->task_start_date);
			$ted = new CDate ($obj->task_end_date);
			
			// updating the table recording the 
			// dependency relations with this task
			$obj->updateDependencies($hdependencies);
			
			// we will reset the task's start date based upon dependencies
			// and shift the end date appropriately
			if ($adjustStartDate && !is_null($hdependencies)) {
				
				// load already stored task data for this task
				$tempTask = new CTask();
				$tempTask->load($obj->task_id);
				
				// shift new start date to the last dependency end date
				$nsd = new CDate ($tempTask->get_deps_max_end_date($tempTask));
				
				// prefer Wed 8:00 over Tue 16:00 as start date
				$nsd = $nsd->next_working_day();
				
				// prepare the creation of the end date
				$ned = new CDate();
				$ned->copy($nsd);
				
				if (empty($obj->task_start_date)) {
					// appropriately calculated end date via start+duration
					$ned->addDuration($obj->task_duration, $obj->task_duration_type);		
				} else { 			
					// calc task time span start - end
					$d = $tsd->calcDuration($ted);
					
					// Re-add (keep) task time span for end date.
					// This is independent from $obj->task_duration.
					// The value returned by Date::Duration() is always in hours ('1') 
					$ned->addDuration($d, '1');
				}
				
				// prefer tue 16:00 over wed 8:00 as an end date
				$ned = $ned->prev_working_day();
				
				$obj->task_start_date = $nsd->format(FMT_DATETIME_MYSQL);
				$obj->task_end_date = $ned->format(FMT_DATETIME_MYSQL);						
				
				$q = new DBQuery;
				$q->addTable('tasks', 't');							
				$q->addUpdate('task_start_date', $obj->task_start_date);	
				$q->addUpdate('task_end_date', $obj->task_end_date);
				$q->addWhere('task_id = '.$obj->task_id);
				$q->addWhere('task_dynamic != 1');
				$q->exec();
				$q->clear();
			}
		}
		
		// If there is a set of post_save functions, then we process them
		if (isset($post_save)) {
			foreach ($post_save as $post_save_function) {
				$post_save_function();
			}
		}
		
		if ($notify && $msg = $obj->notify($comment)) {
			$AppUI->setMsg($msg, UI_MSG_ERROR);
		}
		
		$AppUI->redirect();
	}

} // end of if subform
?>
