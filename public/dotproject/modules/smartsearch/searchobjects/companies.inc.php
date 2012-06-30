<?php /* SMARTSEARCH$Id: companies.inc.php 6038 2010-10-03 05:49:01Z ajdonnison $ */
if (!defined('DP_BASE_DIR')) {
  die('You should not access this file directly.');
}

/**
* companies Class
*/
class companies extends smartsearch 
{
	var $table = 'companies';
	var $table_module = 'companies';
	var $table_key = 'company_id';
	var $table_link = '?m=companies&amp;a=view&amp;company_id=';
	var $table_title = 'Companies';
	var $table_orderby = 'company_name';
	var $search_fields = array('company_name', 'company_address1', 'company_address2', 
	                           'company_city', 'company_state', 'company_zip', 
	                           'company_primary_url', 'company_description', 'company_email');
	var $display_fields = array('company_name', 'company_address1', 'company_address2', 
	                            'company_city', 'company_state', 'company_zip', 
	                            'company_primary_url', 'company_description', 'company_email');
	
	function ccompanies() {
		return new companies();
	}
}
?>
