<?php 
## Active Projects View for Calendar
## based on Companies: View Projects sub-table by gregorerhardt
##
global $AppUI, $company_id, $pstatus, $dPconfig, $project_types, $priority, $company_id;

$df = $AppUI->getPref('SHDATEFORMAT');
$project_types = dPgetSysVal('ProjectStatus');

require_once($AppUI->getModuleClass('projects'));
require(DP_BASE_DIR.'/functions/projects_func.php');

// get any records denied from viewing
$obj = new CProject();

// Task sum table
// by Pablo Roca (pabloroca@mvps.org)
// 16 August 2003

$q = new DBQuery();
$q->dropTemp(array('tasks_sum', 'tasks_summy'));
$q->exec();
$q->clear();

$q->createTemp('tasks_sum');
$q->addQuery('task_project, COUNT(DISTINCT task_id) AS total_tasks,
			SUM(task_duration * task_duration_type * task_percent_complete) / SUM(task_duration * task_duration_type) AS project_percent_complete');
$q->addTable('tasks');
$q->addGroup('task_project');
$q->exec();
$q->clear();

// temporary My Tasks
// by Pablo Roca (pabloroca@mvps.org)
// 16 August 2003
$q->createTemp('tasks_summy');
$q->addQuery('task_project, COUNT(DISTINCT task_id) AS my_tasks');
$q->addTable('tasks');
$q->addWhere('task_owner = ' . $AppUI->user_id);
$q->addGroup('task_project');
$q->exec();
$q->clear();

$q->addTable('projects', 'pr');
$q->addQuery('pr.project_id, pr.project_name, pr.project_status, pr.project_color_identifier,
	pr.project_start_date, pr.project_end_date, pr.project_priority, pr.project_description,
	ts.total_tasks, tsm.my_tasks, ts.project_percent_complete,
	con.contact_first_name, con.contact_last_name, u.user_username');
$q->addJoin('users', 'u', 'u.user_id = pr.project_owner');
$q->addJoin('contacts', 'con', 'u.user_contact = con.contact_id');
$q->addJoin('tasks_sum', 'ts', 'pr.project_id = ts.task_project');
$q->addJoin('tasks_summy', 'tsm', 'pr.project_id = tsm.task_project');
$q->addWhere('pr.project_status <> 7');
$q->addWhere('pr.project_status <> 5');
$allowed_where = $obj->getAllowedSQL($AppUI->user_id);
if ($allowed_where) {
	$q->addWhere(implode(' AND ', $allowed_where));
}
if ($company_id) {
	$q->addWhere('pr.project_company = ' . $company_id);
}
$q->addOrder('project_end_date');

$projects = $q->loadList();
?>

<table width="100%" border="0" cellpadding="3" cellspacing="1" class="tbl">
<tr>
	<td align="right" width="65" nowrap="nowrap">&nbsp;<?php echo $AppUI->_('sort by');?>:&nbsp;</td>
	<th nowrap="nowrap">
		<a href="?m=projects&amp;orderby=project_name" class="hdr">
		<?php echo $AppUI->_('Name');?>
		</a>
	</th>
	<th nowrap="nowrap">
		<a href="?m=projects&amp;orderby=project_end_date" class="hdr">
		<?php echo $AppUI->_('End');?>
		</a>
	</th>
	<th nowrap="nowrap">
		<a href="?m=projects&amp;orderby=user_username" class="hdr">
		<?php echo $AppUI->_('Owner');?>
		</a>
	</th>
	<th nowrap="nowrap">
		<a href="?m=projects&amp;orderby=my_tasks" class="hdr">
		<?php echo $AppUI->_('My Tasks');?>
		</a>
		<a href="?m=projects&amp;orderby=total_tasks" class="hdr">
		(<?php echo $AppUI->_('All');?>)
		</a>
	</th>
	<th nowrap="nowrap"><?php echo $AppUI->_('Status'); ?></th>
	<th nowrap="nowrap"><?php echo $AppUI->_('Selection'); ?></th>
</tr>

<?php
$CR = "\n";
$CT = "\n\t";
$none = true;

foreach ($projects as $row) {
	$none = false;
	$end_date = (intval(@$row['project_end_date']) ? new CDate($row['project_end_date']) : null);
?>	
<tr>
	<td width="65" align="center" style="border: outset #eeeeee 2px;background-color:#<?php
	echo $row['project_color_identifier']; ?>">
		<span style="font-color: <?php echo bestColor($row['project_color_identifier']); ?>">
		<?php echo sprintf("%.1f%%", $row['project_percent_complete']); ?>
		</span>
	</td>
	<td width="100%">
		<a href="?m=projects&amp;a=view&amp;project_id=<?php 
echo $row['project_id']; ?>" title="<?php 
	echo htmlspecialchars($row['project_description'], ENT_QUOTES); ?>"><?php 
	echo htmlspecialchars($row['project_name'], ENT_QUOTES); ?>
		</a>
	</td>
	<td align="center"nowrap="nowrap" style="background-color:<?php echo ($priority[$row['project_priority']]['color']); ?>"><?php 
echo htmlspecialchars(($end_date ? $end_date->format($df) : '-')); ?></td>
	<td nowrap="nowrap"><?php echo htmlspecialchars($row['user_username'], ENT_QUOTES); ?></td>
	<td align="center" nowrap="nowrap">
		<?php echo ($row['my_tasks'] . ' ('.$row['total_tasks'] . ')'); ?>
	</td>
	<td align="center" nowrap="nowrap">
		<?php 
	echo $AppUI->_((($row['project_status']) 
	                ? $project_types[$row['project_status']] : 'Not Defined')); ?>
	</td>
	<td align="center">
		<input type="checkbox" name="project_id[]" value="<?php echo $row['project_id']; ?>" />
	</td>
</tr>
<?php
}
if ($none) {
	echo ('<tr><td colspan="6">' . $AppUI->_('No projects available') . '</td></tr>');
}
?>
</table>
