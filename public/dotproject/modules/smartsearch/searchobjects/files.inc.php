<?php /* SMARTSEARCH$Id: files.inc.php 6038 2010-10-03 05:49:01Z ajdonnison $ */
if (!defined('DP_BASE_DIR')) {
  die('You should not access this file directly.');
}

/**
* files Class
*/
class files extends smartsearch 
{
	var $table = 'files';
	var $table_module = 'files';
	var $table_key = 'file_id';
	var $table_link = '?m=files&amp;a=addedit&amp;file_id=';
	var $table_title = 'Files';
	var $table_orderby = 'file_name';
	var $search_fields = array('file_real_filename', 'file_name', 'file_description', 'file_type');
	var $display_fields = array('file_real_filename', 'file_name', 'file_description', 'file_type');
	var $follow_up_link = 'fileviewer.php?file_id=';
	
	function cfiles () {
		return new files();
	}
}
?>
