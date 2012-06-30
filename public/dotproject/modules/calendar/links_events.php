<?php /* CALENDAR $Id: links_events.php 5878 2009-04-26 22:19:37Z merlinyoda $ */
if (!defined('DP_BASE_DIR')) {
	die('You should not access this file directly.');
}


/**
* Sub-function to collect events within a period
* @param Date the starting date of the period
* @param Date the ending date of the period
* @param array by-ref an array of links to append new items to
* @param int the length to truncate entries by
* @author Andrew Eddie <eddieajau@users.sourceforge.net>
*/
function getEventLinks($startPeriod, $endPeriod, &$links, $strMaxLen) {
  global $AppUI, $event_filter;
	$events = CEvent::getEventsForPeriod($startPeriod, $endPeriod, $event_filter);

	// assemble the links for the events
	foreach ($events as $row) {
		$start = new CDate($row['event_start_date']);
		$end = new CDate($row['event_end_date']);
		
		$date = $start;
		$date->setTime(0, 0, 0);
		
		$cwd = explode(',', $GLOBALS['dPconfig']['cal_working_days']);

		for ($i=0, $x=$end->dateDiff($start); $i <= $x; $i++) {
			// the link
			// optionally do not show events on non-working days 
			if (($row['event_cwd'] && in_array($date->getDayOfWeek(), $cwd)) 
			    || !($row['event_cwd'])) {
				$link['href'] = '?m=calendar&a=view&event_id=' . $row['event_id'];
				$link['alt'] = $row['event_description'];
				$link['text'] = (dPshowImage(dPfindImage(('event' . $row['event_type'] . '.png'), 
														 'calendar'), 16, 16)
				                 . htmlspecialchars($row['event_title']));
			
			
				if ($i == 0) {
					$link['alt'] .= (' [' . $AppUI->_('START') . ']');
				} 
				if ($i == $x) {
					$link['alt'] .= (' [' . $AppUI->_('END') . ']');
				}
				$links[$date->format(FMT_TIMESTAMP_DATE)][] = $link;
			}
			
			$date = $date->getNextDay();
		}
	}
}
?>
