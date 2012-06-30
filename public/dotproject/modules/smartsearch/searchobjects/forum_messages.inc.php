<?php /* SMARTSEARCH$Id: forum_messages.inc.php 6038 2010-10-03 05:49:01Z ajdonnison $ */
if (!defined('DP_BASE_DIR')) {
  die('You should not access this file directly.');
}

/**
* forum_messages Class
*/
class forum_messages extends smartsearch 
{
	var $table = 'forum_messages';
	var $table_module = 'forums';
	var $table_key = 'message_id';			// primary key
	var $table_link = '?m=forums&amp;a=viewer&amp;message_id=';
	var $table_title = 'Forum messages';
	var $table_orderby = 'message_title';
	var $search_fields = array ('message_title', 'message_body');
	var $display_fields = array ('message_title', 'message_body');

	function cforum_messages () {
		return new forum_messages();
	}
}
?>
