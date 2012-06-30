<?php
if (!defined('DP_BASE_DIR')) {
	die('You should not access this file directly.');
}

// $Id: ae_depend.php 6048 2010-10-06 10:01:39Z ajdonnison $
global $AppUI, $dPconfig, $task_parent_options, $loadFromTab;
global $can_edit_time_information, $obj;
global $durnTypes, $task_project, $task_id, $tab;

//Time arrays for selects
$start = intval(dPgetConfig('cal_day_start'));
$end   = intval(dPgetConfig('cal_day_end'));
$inc   = intval(dPgetConfig('cal_day_increment'));
if ($start === null) $start = 8;
if ($end   === null) $end = 17;
if ($inc   === null)  $inc = 15;
$hours = array();
for ($current = $start; $current <= $end; $current++) {
	if ($current < 10) { 
		$current_key = "0" . $current;
	} else {
		$current_key = $current;
	}
	
	if (mb_stristr($AppUI->getPref('TIMEFORMAT'), "%p")) {
		//User time format in 12hr
		$hours[$current_key] = ($current > 12 ? $current-12 : $current);
	} else {
		//User time format in 24hr
		$hours[$current_key] = $current;
	}
}

// Pull tasks dependencies
$q = new DBQuery;
$q->addQuery('t.task_id, t.task_name');
$q->addTable('tasks', 't');
$q->addTable('task_dependencies','td');
$q->addWhere('td.dependencies_task_id = '.$task_id.' AND t.task_id = td.dependencies_req_task_id');
$taskDep = $q->loadHashList();

?>
<form name="dependFrm" action="?m=tasks&a=addedit&task_project=<?php echo $task_project;?>" method="post">
<input name="dosql" type="hidden" value="do_task_aed" />
<input name="task_id" type="hidden" value="<?php echo $task_id;?>" />
<input name="sub_form" type="hidden" value="1" />
<table width="100%" border="0" cellpadding="4" cellspacing="0" class="std">
			<?php
				if ($can_edit_time_information) {
			?>
			<tr>
				<td align="center" nowrap="nowrap" colspan="3"><b><?php echo $AppUI->_('Dependency Tracking');?></b></td>
			</tr>
			<tr>
				<td align="right" nowrap="nowrap"><?php echo $AppUI->_('On');?></td>
				<td nowrap="nowrap">
					<input type="radio" name="task_dynamic" value="31" <?php if ($obj->task_dynamic > '20') echo "checked"?> />
				</td>
			</tr>
			<tr>
				<td align="right" nowrap="nowrap"><?php echo $AppUI->_('Off');?></td>
				<td id="no_dyn" nowrap="nowrap">
					<input type="radio" name="task_dynamic" value="0" <?php if ($obj->task_dynamic == '0' || $obj->task_dynamic == '11') echo "checked"?> />
				</td>
</tr>
<tr>
	<td align="right" nowrap="nowrap"><label for="task_dynamic"><?php echo $AppUI->_('Dynamic Task');?></label></td>
	<td nowrap="nowrap">
		<input type="checkbox" name="task_dynamic" id="task_dynamic" value="1" <?php if ($obj->task_dynamic=="1") echo 'checked="checked"'?> />
	</td>
</tr>
<tr>
	<td align="right" nowrap="nowrap"><label for="task_dynamic_nodelay"><?php echo $AppUI->_('Do not track this task');?></label></td>
	<td>
		<input type="checkbox" name="task_dynamic_nodelay" id="task_dynamic_nodelay" value="1" <?php if (($obj->task_dynamic > '10') && ($obj->task_dynamic < 30)) echo 'checked="checked"' ?> />
	</td>
			</tr>
			<?php
				} else {  
			?>
			<tr>
					<td colspan="2"><?php echo $AppUI->_("Only the task owner, project owner, or system administrator is able to edit time related information."); ?></td>
				</tr>
			<?php
				}// end of can_edit_time_information
			?>
			<tr>
				<td><?php echo $AppUI->_('All Tasks');?>:</td>
				<td><?php echo $AppUI->_('Task Dependencies');?>:</td>
			</tr>
			<tr>
				<td>
					<select name="all_tasks" class="text" style="width:220px" size="10" class="text" multiple="multiple">
						<?php echo str_replace("selected", "", $task_parent_options); // we need to remove selected added from task_parent options ?>
					</select>
				</td>
				<td>
					<?php echo arraySelect($taskDep, 'task_dependencies', 'style="width:220px" size="10" class="text" multiple="multiple" ', null); ?>
				</td>
			</tr>
			<tr>
				<td colspan="2">
				<input type="checkbox" name="set_task_start_date" id="set_task_start_date" /><label for="set_task_start_date"><?php echo $AppUI->_('Set task start date based on dependency');?></label>
				</td>
			</tr>
			<tr>
				<td align="right"><input type="button" class="button" value="&gt;" onclick="javascript:addTaskDependency(document.dependFrm, document.datesFrm)" /></td>
				<td align="left"><input type="button" class="button" value="&lt;" onclick="javascript:removeTaskDependency(document.dependFrm, document.datesFrm)" /></td>
			</tr>
		</table>
<input type="hidden" name="hdependencies" />
</form>
<script language="javascript">
  subForm.push(new FormDefinition(<?php echo $currentTabId; ?>, document.dependFrm, checkDetail, saveDepend));
</script>
