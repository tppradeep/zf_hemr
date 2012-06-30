<?php /* SMARTSEARCH$Id: files_content.inc.php 5972 2010-03-29 00:05:34Z merlinyoda $ */
if (!defined('DP_BASE_DIR')) {
  die('You should not access this file directly.');
}

/*
 Files_content class
*/
class files_content extends smartsearch 
{
	var $table = 'files_index';
	var $table_module = 'files';
	var $table_key = 'file_id';
	var $table_link = 'fileviewer.php?file_id=';
	var $table_title = 'Files Content';
	var $table_orderby = 'word_placement';
	var $search_fields = array('word');
	var $display_fields = array('word');
	var $follow_up_link = 'fileviewer.php?file_id=';

	function cfiles_content () {
		return new files_content();
	}
}
?>
